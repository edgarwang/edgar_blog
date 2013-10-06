class HomeController < ApplicationController
  def index
    @articles = Article.all_published_articles
  end

  def about
  end
end
