json.extract! @article, :id, :title, :slug, :status, :created_at, :updated_at
json.edit_article_path edit_dashboard_article_path(@article)
