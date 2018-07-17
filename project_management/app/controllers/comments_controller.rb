class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def new
    @ticket = Ticket.find(params[:ticket_id])
    @comment = Comment.new
  end

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.new comment_params
    @comment.user_id = current_user.id
    @comment.save
    redirect_to ticket_path(@ticket)
  end

  def destroy
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.find(params[:id])
    @comment.destroy
    redirect_to ticket_path(@ticket)
  end

  def edit
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @ticket
    else
      render 'edit'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :user_id, :ticket_id, :parent_id, :parent)
    end
end

