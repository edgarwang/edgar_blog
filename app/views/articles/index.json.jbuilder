json.array!(@articles) do |article|
  json.extract! article, :title, :url, :content
  json.url article_url(article, format: :json)
end
