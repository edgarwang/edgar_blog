class @ArticleEdit
  constructor:  ->
    @article = $("#editarea .article")
    @editor = new Editor {
      textarea: "content-editor"
      toolbar: ".editor.toolbar"
    }

    @bindActions()

  bindActions: ->
    $("#sidebar .edit.button").on "click", @editArticle
    $("#sidebar .preview.button").on "click", @previewArticle
    $("#sidebar .setting.button").on "click", @showArticleSettings
    $("#sidebar .save.button").on "click", (event) => @saveArticle(event)

  editArticle: ->

  previewArticle: ->

  showArticleSettings: ->

  saveArticle: (event) ->
    event.preventDefault()

    if @isPersisted()
      @updateArticle()
    else
      @createArticle()

  isPersisted: ->
    !!@article.data("id")

  updateArticle: ->
    $.ajax(
      url: @article.data("save-article-path")
      type: 'put'
      data:
        article:
          content: @editor.codemirror.getValue()
    )

  createArticle: ->
    $.ajax(
      url: @article.data("save-article-path")
      type: 'post'
      data:
        article:
          title: $('#article_title').val()
          content: @editor.codemirror.getValue()
          slug: @article.data("slug")
          status: @article.data("status")
    ).done((data) =>
      window.location.replace(data.edit_article_path)
    )

loadEditor = ->
  editorArea = document.getElementById('content-editor')
  if (editorArea)
    editor = new ArticleEdit

$(document).ready(loadEditor)
$(document).on('page:load', loadEditor)
