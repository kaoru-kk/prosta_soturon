class TimersController < ApplicationController
    before_action :timer_user,only:[:show, :update]

    def index
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
        input_day = "2019-09-02"

        all_time = current_user.timers.where(created_at: input_day.in_time_zone.all_month)
        
        array_time = (all_time.group(:created_at).sum(:total)).to_a
        
        slice = array_time.count
        array = Array.new(slice, 0)
        
        (0..slice-1).each do |f|
            array[f] = array_time[f][1]
        end
        

    end
    def create
        timer = Timer.new(timer_params)
        timer.user_id = current_user.id
        timer.hour = params[:timer][:hour]
        hour = params[:timer][:hour].to_i * 3600

        timer.min = params[:timer][:min]
        min = params[:timer][:min].to_i * 60

        timer.sec = params[:timer][:sec]
        sec = params[:timer][:sec].to_i

        timer.detail = params[:timer][:detail]


        timer.total = hour + min + sec
        timer.save
        redirect_to timer_path(timer.id)
    end

    def new
        @timer = Timer.new
    end

    def show
        @timer = Timer.find(params[:id])
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

    def update
        timer = Timer.find(params[:id])
        timer.hour = params[:timer][:hour]
        timer.min = params[:timer][:min]
        timer.sec = params[:timer][:sec]
        timer.detail = params[:timer][:detail]
        timer.save
        redirect_to timer_path(timer.id)
    end

    private
    def timer_params
        params.require(:timer).permit(timer: [:hour, :min, :sec])
    end

    def timer_user
        timer = Timer.find(params[:id])
        if current_user.id != timer.user_id
            flash[:notice] = "不正な画面遷移です"
            redirect_to user_path(current_user.id)
        end
    end
end
