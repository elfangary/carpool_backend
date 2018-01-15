class StopPointsController < ApplicationController
  before_action :set_stop_point, only: [:show]
  before_action :set_trip, only: [:index]

  def index
    @stopPoints = @trip.stop_points
    render json: @stopPoints
  end

  def show
    render json: @stopPoint
  end

  def create
    @stopPoint = StopPoint.build stop_point_params
    if @stopPoint.save
      render :show, status: :ok, location: @stop_point
    else
      render json: @stopPoint.errors, status: :unprocessable_entity
    end
  end

  private
  def set_stop_point
    @stopPoint = StopPoint.find params[:id]
  end

  def set_trip
    @trip = Trip.find params[:trip_id]
  end

  def stop_point_params
    params.permit(:location_id, :start_time, :end_time)
  end
end
