class UsersController < ApplicationController
  
  def index
  end

  def show
    @user = User.find(params[:id])
    @posts = current_user.posts.all
    @timer = Timer.new

    @timers = current_user.timers.all

    @hour_total = 0
    @min_total = 0
    @sec_total = 0

    @timers.each do |f|
        @hour_total += f.hour
    end

    @timers.each do |f|
        @min_total += f.min
        if @min_total > 59
            @min_total = @min_total - 60
            @hour_total += 1
        end
    end
    @timers.each do |f|
        @sec_total += f.sec
        if @sec_total > 59
            @sec_total = @sec_total - 60
            @min_total += 1
        end
    end
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
