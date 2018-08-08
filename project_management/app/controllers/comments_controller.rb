class CommentsController < ApplicationController
  before_action :get_ticket, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :get_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = @ticket.comments
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @ticket.comments.new comment_params
    @comment.user_id = current_user.id
    save_attachments
    
    if @comment.save
      redirect_to ticket_path(@ticket)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      save_attachments
      redirect_to ticket_path(@ticket)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to ticket_path(@ticket)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :user_id, :ticket_id, :parent_id)
    end

    def get_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    def get_comment
      @comment = Comment.find(params[:id])
    end

    def save_attachments
      params.require(:comment).permit(:files => [])
      params[:comment][:files].each do |file|
        @attachment = Attachment.new(user_id: current_user.id, file: file)
        
        if @attachment.save
          @comment.ticket.project.attachments << @attachment
          @comment.ticket.attachments << @attachment
          @comment.attachments << @attachment
        else
          render 'new'
        end
      end
    end
end

