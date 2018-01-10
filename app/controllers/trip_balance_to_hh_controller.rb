class TripBalanceToHhController < ApplicationController
  before_action :set_hh_stop_point
  def create
    @hh_stop_point.add_points_to_hh
    render json: current_user.points, status: :ok
  end

  private
  def set_hh_stop_point
    @hh_stop_point = HhStopPoint.find params[:hh_stop_point_id]
  end

end
