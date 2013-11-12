module Dashboard::ArticlesHelper
  def draft?
    params[:status] == 'draft'
  end

  def trash?
    params[:status] == 'trash'
  end

  def published?
    params[:status] == 'published'
  end

  def not_published
    not published?
  end

  def article_edit_tag(article, id)
    article_info = {
      'id' => article.id,
      'slug' => article.slug,
      'status' => article.status,
      'save-article-path' => save_article_path(article)
    }

    raw text_area_tag('article[content]',
                  article.content,
                  id: id,
                  data: article_info)
  end

  private
  def save_article_path(article)
    # update article
    return dashboard_article_path(article, :json) if article.persisted?
    
    # create article
    return dashboard_articles_path(:json)
  end
end
