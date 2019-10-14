# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def show
    @user = User.find(params[:id])
    @posts = current_user.posts.page(params[:page]).reverse_order

    # time関連の記述
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
        @min_total -= 60
        @hour_total += 1
      end
    end
    @timers.each do |f|
      @sec_total += f.sec
      if @sec_total > 59
        @sec_total -= 60
        @min_total += 1
      end
    end

    input_day = Date.today
    all_time = current_user.timers.where(created_at: input_day.in_time_zone.all_month)
    array_time = all_time.group('DAY(created_at)').sum(:total).to_a
    slice = input_day.end_of_month.mday
    @select_month = input_day.strftime('%m')

    if array_time.blank?
      gon.array = Array.new(slice, 0)
      @no_data = @select_month + '月のデータはありません'
    else
      gon.array = Array.new(slice, 0)
      array_time.length.times do |f|
        day_total = array_time[f][0]
        gon.array[day_total - 1] = ((array_time[f][1]) / 3600.to_f).round(1)
      end
      @month_time = @select_month + '月の勉強時間:' + all_time.sum(:hour).to_s + '時間' + all_time.sum(:min).to_s + '分' + all_time.sum(:sec).to_s + '秒'
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

  def destroy; end

  private

  def user_params
    params.require(:user).permit(:email, :name, :image)
  end
end
