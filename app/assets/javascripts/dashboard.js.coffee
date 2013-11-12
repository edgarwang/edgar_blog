#= require common
#= require_tree ./dashboard

sendArticleToTrash = ->
  $('.trash.article.button').on 'click', ->
    $trashArticleButton = $(this)
    sendToTrashPath = $trashArticleButton.data('send-to-trash-path')
    $.ajax({
      url: sendToTrashPath,
      type: 'POST',
      success: ->
        $trashArticleButton.closest('.article.item').remove()
    })
$(document).ready(sendArticleToTrash)
$(document).on('page:load', sendArticleToTrash)

restoreArticle = ->
  $('.restore.article.button').on 'click', ->
    $restoreArticleButton = $(this)
    restoreArticlePath = $restoreArticleButton.data('restore-article-path')
    $.ajax({
      url: restoreArticlePath,
      type: 'POST',
      success: ->
        $restoreArticleButton.closest('.item').remove()
    })
$(document).ready(restoreArticle)
$(document).on('page:load', restoreArticle)
