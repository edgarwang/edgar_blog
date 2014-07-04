#= require codemirror/lib/codemirror
#= require codemirror/addon/mode/overlay
#= require codemirror/addon/selection/active-line
#= require codemirror/addon/display/placeholder
#= require codemirror/mode/gfm/gfm
#= require codemirror/mode/markdown/markdown
#= require codemirror/mode/javascript/javascript
#= require codemirror/mode/clike/clike
#= require codemirror/mode/ruby/ruby
#= require jquery-file-upload/js/vendor/jquery.ui.widget.js 
#= require jquery-file-upload/js/jquery.iframe-transport
#= require jquery-file-upload/js/jquery.fileupload

class @Editor
  constructor: (@options) ->
    @codemirror = @initCodeMirror(@options.textarea)
    @toolbar = $(@options.toolbar)

    @initToolbarActions()
    @initImageUploadModal()

  initCodeMirror: (textarea) ->
    editorArea = document.getElementById(textarea)
    CodeMirror.fromTextArea(editorArea, {
        mode: 'gfm',
        viewportMargin: Infinity,
        styleActiveLine: true,
        setFirstLineAsTitleLine: true,
        placeholder: 'Write something here',
        lineWrapping: true
      })

  initToolbarActions: ->
    editor = this
    @toolbar.find('[data-action]').each (index, elem) ->
      action = $(elem).data('action')
      $(elem).bind 'click', (event) ->
        event.preventDefault()
        editor[action]($(elem))

  initImageUploadModal: ->
    $('#attachment_file').on 'change', (event) ->
      imageName = $('#attachment_file').val()
      $('.show.image.name').text(imageName)

    # tigger attachment_file input
    $('.choose.image.button').on 'click', (event) ->
      event.preventDefault()
      $('#attachment_file').click()

    $uploadImageForm = $('#upload-image')
    $uploadImageForm.fileupload {
      type: 'POST'
      dataType: 'json'

      add: (event, data) =>
        $uploadImageForm.off('submit')
        $uploadImageForm.on 'submit', (event) ->
          event.preventDefault()
          data.submit()

      done: (event, data) =>
        @resetUploadImageForm()
        @insertImageBlock(data.result.files[0])
        $('.upload.image.modal').modal('hide')
    }

  resetUploadImageForm:  ->
    $('#upload-image').off('submit')
    $('.show.image.name').text('')

  insertImageBlock: (image) ->
    imageBlock = "![#{image.name}](#{image.url})"
    @codemirror.replaceSelection(imageBlock)

  undo: ($object) ->
    @codemirror.undo()

  heading: ($object) ->
    @codemirror.replaceSelection $object.data('snippet')

  "sub-heading": ($object) ->
    @codemirror.replaceSelection $object.data('snippet')

  bold: ($object) ->
    @codemirror.replaceSelection $object.data('snippet')

  italic: ($object) ->
    @codemirror.replaceSelection $object.data('snippet')

  image: ($object) ->
    $('.upload.image.modal')
      .modal('setting', 'debug', false)
      .modal('show')
