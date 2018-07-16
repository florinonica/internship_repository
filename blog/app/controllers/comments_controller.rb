class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new comment_params
    @comment.user_id = current_user.id
    @comment.save
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  def edit
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :user_id, :article_id, :parent_id, :parent, :children)
    end
end
