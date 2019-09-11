class TimersController < ApplicationController

    def create
        timer = Timer.new
        timer.user_id = current_user.id
        timer.save
        redirect_to timer_path(current_user.id,timer.id)
    end

    def show
        @timer = Timer.find(params[:id])
    end

    def update
        timer = Timer.find(params[:id])
        timer.update!(timer_params)
        redirect_to user_timer_path(current_user.id, timer)
    end

    private
    def timer_params
        params.require(:timer).permit(:user_id, :id)
    end
end
