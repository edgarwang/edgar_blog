#= require codemirror/lib/codemirror
#= require codemirror/addon/mode/overlay
#= require codemirror/mode/gfm/gfm
#= require codemirror/mode/markdown/markdown
#= require codemirror/mode/javascript/javascript
#= require codemirror/mode/clike/clike
#= require codemirror/mode/ocaml/ocaml
#= require codemirror/mode/ruby/ruby

# Enable markdown editor for blog content
enableMarkdownEditor = ->
  textArea = document.getElementById('editor')
  if textArea
    CodeMirror.fromTextArea(textArea, {
      mode: 'gfm',
      viewportMargin: Infinity
    })
$(document).ready(enableMarkdownEditor)
$(document).on('page:load', enableMarkdownEditor)


toggleMenu = ->
  $(document).on 'click', '#toggle-menu', ->
    $('.sidebar')
      .sidebar('toggle')
$(document).ready(toggleMenu)
$(document).on('page:load', toggleMenu)
