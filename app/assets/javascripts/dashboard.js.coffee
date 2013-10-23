#= require common
#= require editor

sendArticleToTrash = ->
  $('.trash.article.button').on 'click', ->
    $trashArticleButton = $(this)
    send_to_trash_path = $trashArticleButton.data('send-to-trash-path')
    $.ajax({
      url: send_to_trash_path,
      type: 'POST',
      success: ->
        $trashArticleButton.closest('.article.item').remove()
    })

$(document).ready(sendArticleToTrash)
$(document).on('page:load', sendArticleToTrash)
