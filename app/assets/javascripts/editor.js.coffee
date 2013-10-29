#= require codemirror/lib/codemirror
#= require codemirror/addon/mode/overlay
#= require codemirror/addon/selection/active-line
#= require codemirror/addon/display/placeholder
#= require codemirror/mode/gfm/gfm
#= require codemirror/mode/markdown/markdown
#= require codemirror/mode/javascript/javascript
#= require codemirror/mode/clike/clike
#= require codemirror/mode/ocaml/ocaml
#= require codemirror/mode/ruby/ruby

# Enable markdown editor for blog content
enableMarkdownEditor = ->
  textArea = document.getElementById('content-editor')
  if textArea
    CodeMirror.fromTextArea(textArea, {
      mode: 'gfm',
      viewportMargin: Infinity,
      styleActiveLine: true,
      setFirstLineAsTitleLine: true,
      placeholder: 'Write something here',
      lineWrapping: true
    })
$(document).ready(enableMarkdownEditor)
$(document).on('page:load', enableMarkdownEditor)

# Sync two article slug input's value
showSetArticleSlugModal = ->
  hiddenArticleSlug = document.querySelector('#article_slug')
  modalArticleSlug = document.querySelector('#article-slug')
  $('#save-slug').on 'click', ->
    hiddenArticleSlug.value = modalArticleSlug.value
  $('#set-article-slug').on 'click', ->
    $('.article.slug.modal')
      .modal('setting', 'debug', false)
      .modal('setting', 'closable', false)
      .modal('setting', 'onShow', ->
        modalArticleSlug.value = hiddenArticleSlug.value
      )
      .modal('show')
$(document).ready(showSetArticleSlugModal)
$(document).on('page:load', showSetArticleSlugModal)


showUploadImageModal = ->
  $('a.upload.image').on 'click', ->
    $('.upload.image.modal')
      .modal('setting', 'debug', true)
      .modal('setting', 'closable', false)
      .modal('show')
$(document).ready(showUploadImageModal)
$(document).on('page:load', showUploadImageModal)
