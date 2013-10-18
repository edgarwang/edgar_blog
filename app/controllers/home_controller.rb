class HomeController < ApplicationController
  before_action :must_has_one_user
  layout 'home'

  def index
    @articles = Article.published
  end

  def about
  end
end
