#= require jquery
#= require jquery_ujs
#= require semantic.min
#= require turbolinks

closeNoticeMsg = ->
  $("#notice > .close.icon").on "click", ->
    $("#notice").fadeOut()
$(document).ready(closeNoticeMsg)
$(document).on("page:load", closeNoticeMsg)

closeAlertMsg = ->
  $("#alert > .close.icon").on "click", ->
    $("#alert").fadeOut()
$(document).ready(closeAlertMsg)
$(document).on("page:load", closeAlertMsg)
