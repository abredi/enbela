class ArticlesController < ApplicationController
  before_action :authenticated?
  before_action :set_article, only: %i[edit update destroy]

  # GET /articles
  # GET /articles.json
  def index
    @featured = Article.featured

    @articles = Article.categories
    # .joins(:category).select('articles.*, priority, name').distinct.order(priority: :desc).to_a

  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @articles = Article.articles(params[:id])
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit; end

  # POST /articles
  # POST /articles.json
  #
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    if @article.save
      flash.notice = 'Article was successfully created.'
      redirect_to articles_path
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      flash.notice = 'Article was update created.'
      redirect_to articles_path
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    flash.info = 'Article was successfully destroyed.'
    redirect_to articles_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :text, :image)
  end
end
