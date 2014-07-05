class ArticlesController < ApplicationController
  before_action :set_article

  def show
    not_found if !@article.published?
    render layout: 'home'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
end
