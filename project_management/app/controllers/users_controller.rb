class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.paginate(:page=>params[:page],per_page:5)
  end

  def show
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :username, :nickname, :position, :email, :password, :password_confirmation, :type, :avatar)
    end

    def get_user
      @user = User.find(params[:id])
    end
end
