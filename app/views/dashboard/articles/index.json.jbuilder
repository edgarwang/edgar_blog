json.array!(@articles) do |article|
  json.extract! article, :title, :slug, :content
  json.url article_url(article, format: :json)
end
