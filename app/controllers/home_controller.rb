class HomeController < ApplicationController
  def index
    @articles = Article.published
  end

  def about
  end
end
