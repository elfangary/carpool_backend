class StopPointsController < ApplicationController
  before_action :set_stop_point, only: [:show]
  before_action :set_trip, only: [:index]
  def index
    @stopPoints = StopPoint.all
    render json: @stopPoints
  end

  def show
    render json: @stopPoint
  end

  def create
    @stopPoint = StopPoint.new stop_point_params
    if @stopPoint.save
      render :show, status: :ok
    else
      render json:@stopPoint.errors, status: :unprocessable_entity
    end
  end

  private
  def set_stop_point
    @stopPoint = StopPoint.find params[:id]
  end
  
  def set_trip
    @trip = Trip.find params[:id]
  end

  def stop_point_params
    params.require(:stop_point).permit(:location_id, :trip_id, :start_time, :end_time)
  end
end
