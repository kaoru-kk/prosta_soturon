class UsersController < ApplicationController
  
  def index
  end

  def show
    @user = User.find(params[:id])
    @posts = current_user.posts.all
    @timer = Timer.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :image)
  end
end
