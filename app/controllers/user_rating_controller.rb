class UserRatingController < ApplicationController
    
    def show
        average_rating = current_user.rate / current_user.raters_no
        render json: average_rating, status: :ok
    end

    def update 
        params[:ratings].each do |rate|
            User.find(rate[:user_id]).change_rating(rate[:rating])
        end
    end
end
