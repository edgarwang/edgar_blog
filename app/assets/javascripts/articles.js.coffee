# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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
