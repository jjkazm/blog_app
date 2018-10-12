class ArticlesController < ApplicationController
  #before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article hasn't been created"
      render 'new'
    end
  end

  def show
  end

  def edit
    if !user_signed_in?
      flash[:danger] = "You need to be logged in to edit articles. Sign in or sign up."
      redirect_to new_user_registration_path
    else
      if !(current_user.id == @article.user_id)
        redirect_to root_path
        flash[:danger] = "You need to be the author to edit articles."
      end
    end
  end

  def update
    if !user_signed_in?
      flash[:danger] = "You need to be logged in to edit articles. Sign in or sign up."
      redirect_to new_user_registration_path
    else
      if !(current_user.id == @article.user_id)
        flash[:danger] = "You need to be the author to edit articles."
        redirect_to root_path
      else
        if @article.update(article_params)
          flash[:success] = "Article has been updated"
          redirect_to @article
        else
          flash.now[:danger] = "Article has not been updated"
          render 'edit'
        end
      end
    end
  end

  def destroy
    if user_signed_in?
      if current_user.id == @article.user_id
        @article.destroy
        flash[:danger] = "Article has been deleted"
        redirect_to articles_path
      else
        flash[:danger] = "You need to be the author to delete articles."
        redirect_to @article
      end
    else
      flash[:danger] = "You need to be logged in to delete articles. Sign in or sign up."
      redirect_to new_user_registration_path
    end

  end

  protected
  def resource_not_found
    flash[:danger] = "The article you are looking for can't be found"
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
