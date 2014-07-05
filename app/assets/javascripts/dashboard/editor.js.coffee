#= require codemirror/lib/codemirror
#= require codemirror/addon/mode/overlay
#= require codemirror/addon/selection/active-line
#= require codemirror/addon/display/placeholder
#= require codemirror/mode/gfm/gfm
#= require codemirror/mode/markdown/markdown
#= require codemirror/mode/javascript/javascript
#= require codemirror/mode/clike/clike
#= require codemirror/mode/ruby/ruby

class @Editor
  constructor: (@options) ->
    @codemirror = @initCodeMirror(@options.textarea)
    @toolbar = $(@options.toolbar)

    @initToolbarActions()

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
