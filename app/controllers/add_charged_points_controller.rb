class AddChargedPointsController < ApplicationController
  def create
    current_user.addChargedPoints(params[:chargedPoints])
    current_user.save(validate: false)

    render json: current_user.points, status: :ok
  end
end
