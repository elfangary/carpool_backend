class UserRatingController < ApplicationController
    
    def index
        average_rating = current_user.rate / current_user.raters_no
        render json: average_rating, status: :ok
    end

    def update(params[:user_id], params[:rate])
        current_user.change_rating(params[:user_id], params[:rate])
    end
end
