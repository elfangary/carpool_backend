class TripsController < ApplicationController
  before_action :set_trip, only: :show
  
  def index
    @trips = Trip.all
  end

  def show
    render json: @trip
  end

  def create
    @trip = Trip.new trip_params
    if @trip.save
      render json: @trip, status: :created, location:[ @trip, @stop_point ]
    else
      render json: @trip.errors, status: :unprocessable_entity 
    end
  end

  def filter_by_day_and_location
    @filtered_trips = Trip.where(
      day: params[:day]
    ).joins(:stop_points).where(
      'stop_points.location_id': params[:location_id], 
      'stop_points.start_time': [params[:start_time], params[:end_time]]
    )
    render json: @filtered_trips, status: :ok
  end



  private
  def set_trip
    @trip = Trip.find params[:id]
  end

  def trip_params
    params.permit(:car_id, :driver_id, :day, :all_seats, :specific_gender, :smoking, stop_points_attributes: [:location_id, :start_time, :end_time])
  end
end
