#= require jquery
#= require jquery_ujs
#= require semantic.min
#= require turbolinks

closeFlashMsg = ->
  $(".ui.message > .close.icon").on "click", ->
    $(".ui.message").fadeOut()
$(document).ready(closeFlashMsg)
$(document).on("page:load", closeFlashMsg)
