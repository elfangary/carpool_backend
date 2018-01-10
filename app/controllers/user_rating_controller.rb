class UserRatingController < ApplicationController
    
    def show
        average_rating = current_user.rate / current_user.raters_no
        render json: average_rating, status: :ok
    end

    def create 
        params[:ratings].each do |rate|
            byebug
            current_user.change_rating(rate[:hh_id], rate[:rating])
        end
    end

    def update
        current_user.change_rating(params[:user_id], params[:rate])
        render json: current_user.rate, status: :ok
    end

end
