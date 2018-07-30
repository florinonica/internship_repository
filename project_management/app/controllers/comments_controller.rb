class CommentsController < ApplicationController
  def index
    @ticket = Ticket.find(params[:ticket_id])
    @comments = @ticket.comments
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @ticket = Ticket.find(params[:ticket_id])
    @comment = Comment.new
  end

  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.new comment_params
    @comment.user_id = current_user.id
    
    if @comment.save
    #redirect_to ticket_path(@ticket)
      redirect_to :back
    else
      render 'new'
    end
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

  def destroy
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.find(params[:id])
    @comment.destroy
    redirect_to ticket_path(@ticket)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :user_id, :ticket_id, :parent_id)
    end
end

