class TripsController < ApplicationController
  attr_accessor :driver_id
  before_action :set_trip, only: [:show, :update]

  def index
    @trips = Trip.all
  end

  def show
    render json: @trip
  end

  def create
    @driver_id = current_user.id
    @trip = Trip.new trip_params
    if @trip.save
      render json: @trip, status: :created, location:[ @trip, @stop_point ]
    else
      render json: @trip.errors, status: :unprocessable_entity
    end
  end

  def update
    @trip.change_trip_status(params[:status])

    @trip.get_on_hold_points if params[:status] == "ended"

    render json: {trip: @trip, points: current_user.points}, status: :ok
  end
  private
  def set_trip
    @trip = Trip.find params[:id]
  end

  def trip_params
    params.permit(:car_id, :day, :all_seats, :specific_gender, :smoking, :status, stop_points_attributes: [:location_id, :start_time, :end_time]).merge(driver_id: @driver_id)
  end
end