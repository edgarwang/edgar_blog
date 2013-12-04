class @ArticleEdit
  constructor:  ->
    @article = $("#editarea .article")
    @editor = new Editor {
      textarea: "content-editor"
      toolbar: ".editor.toolbar"
    }

    @bindActions()
    @initSettingsModal()

  bindActions: ->
    $("#sidebar .edit.button").on "click", @editArticle
    $("#sidebar .preview.button").on "click", @previewArticle
    $("#sidebar .settings.button").on "click", (event) => @showArticleSettings(event)
    $("#sidebar .save.button").on "click", (event) => @saveArticle(event)

  initSettingsModal: ->
    if @article.data("status") == "draft"
      $("#settings .draft.button").addClass("active")
    else
      $("#settings .publish.button").addClass("active")
      $("#settings .publish.button").addClass("blue")

  editArticle: ->

  previewArticle: ->

  showArticleSettings: (event) ->
    event.preventDefault()

    @monitorArticleStatus()
    @monitorArticleSlug()

    $(".article.settings.modal")
      .modal("show")
      .modal("setting", "debug", false)

  monitorArticleStatus: ->
    $publishBtn = $("#settings .publish.button")
    $draftBtn = $("#settings .draft.button")

    $publishBtn.on "click", =>
      @updateStatus($publishBtn.data("status"))
      $draftBtn.removeClass("active")
      $publishBtn.addClass("active")
      $publishBtn.addClass("blue")

    $draftBtn.on "click", =>
      @updateStatus($draftBtn.data("status"))
      $publishBtn.removeClass("active")
      $publishBtn.removeClass("blue")
      $draftBtn.addClass("active")

  monitorArticleSlug: ->
    $("#article_slug").on "change", =>
      @updateSlug($("#article_slug").val())


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
          title: $('#article_title').val()
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

  updateSlug: (slug) ->
    if @isPersisted()
      $.ajax(
        url: @article.data("save-article-path")
        type: 'put'
        data:
          article:
            slug: slug
      )
    @article.data("slug", slug)

  updateStatus: (status) ->
    if @isPersisted()
      $.ajax(
        url: @article.data("save-article-path")
        type: 'put'
        data:
          article:
            status: status
      )
    @article.data("status", status)

loadEditor = ->
  editorArea = document.getElementById('content-editor')
  if (editorArea)
    editor = new ArticleEdit

$(document).ready(loadEditor)
$(document).on('page:load', loadEditor)
