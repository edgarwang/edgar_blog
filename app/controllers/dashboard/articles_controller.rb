class Dashboard::ArticlesController < ApplicationController
  layout 'editor'
  before_action :require_signed_in!
  before_action :set_article, only: [:show, :edit, :update, :destroy,
                                     :restore, :send_to_trash]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all_by_status(params[:status])

    render layout: 'dashboard'
  end

  # GET /articles/trash
  def trash
    @articles = Article.trash
    render layout: 'dashboard'
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    not_found if !!@article.trash?
    render layout: 'home'
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    respond_to do |format|
      if @article.trash?
        flash[:alert] = 'Cannot edit trashed article'
        format.html { redirect_to dashboard_articles_url }
      else
        format.html
        format.json
      end
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        flash[:success] = 'Article was successfully created.';
        format.html { redirect_to dashboard_articles_url }
        format.json { render :article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        flash[:success] = 'Article was successfully updated.';
        format.html { redirect_to dashboard_articles_url }
        format.json { render :article }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /articles/1/trash
  def send_to_trash
    @article.send_to_trash

    if @article.save
      render text: "status=#{@article.status}"
    else
      return false
    end
  end

  # POST /articles/1/restore
  def restore
    @article.restore

    if @article.save
      render text: "status=#{@article.status}"
    else
      return false
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_articles_url }
      format.json { head :no_content }
    end
  end

  # DELETE /articles
  def empty_trash
    Article.trash.each do |article|
      article.destroy
    end
    respond_to do |format|
      format.html { redirect_to trash_dashboard_articles_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :slug, :content, :status)
    end
end
