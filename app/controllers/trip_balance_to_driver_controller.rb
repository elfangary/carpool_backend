class TripBalanceToDriverController < ApplicationController
  before_action :set_trip
  def update
    @trip.get_on_hold_points
    render json: current_user.points, status: :ok
  end

  private
  def set_trip
    @trip = Trip.find params[:trip_id]
  end
end
