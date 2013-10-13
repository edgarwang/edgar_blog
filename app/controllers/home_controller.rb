class HomeController < ApplicationController
  layout 'home'

  def index
    @articles = Article.published
  end

  def about
  end
end
