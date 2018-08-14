class PostsController < ApplicationController
  before_action :get_project, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :get_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = @project.posts
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = @project.posts.new post_params
    @post.user_id = current_user.id
    params.require(:post).permit(:files => [])
    save_attachments(@post, params[:post][:files])
    
    if @post.save
      redirect_to message_board_path(@project)
    else
      @post.attachments.each do |file|
        file.destroy
      end
      render 'new'
    end
  end

  def edit
  end

  def update
    params.require(:post).permit(:files => [])
    save_attachments(@post, params[:post][:files])
    if @post.update(post_params)
      redirect_to message_board_path(@project)
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to message_board_path(@project)
  end

  private
    def post_params
      params.require(:post).permit(:body, :user_id, :project_id)
    end

    def get_project
      @project = Project.find(params[:project_id])
    end

    def get_post
      @post = Post.find(params[:id])
    end
end

