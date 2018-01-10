class AddChargedPointsController < ApplicationController
  def charge
      current_user.addChargedPoints(params[:chargedPoints])
      current_user.save

      render json: current_user.points, status: :ok
  end
end
