class UserRatingController < ApplicationController
    
    def show
        average_rating = current_user.rate / current_user.raters_no
        render json: average_rating, status: :ok
    end

    def create 
        params[:ratings].each do |rate|
            User.find(rate[:hh_id]).change_rating(rate[:rating])
        end
    end

    def update
        byebug
        User.find(params[:driver_id]).change_rating(params[:rate])
        render json: current_user.rate, status: :ok
    end

end
