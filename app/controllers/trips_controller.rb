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
      render :show, status: :created, location: @trip
    else
      render json: @trip.errors, status: :unprocessable_entity 
    end
  end

  private
  def set_trip
    @trip = Trip.find params[:id]
  end

  def trip_params
    params.require(:trip).permit(:car_id, :driver_id, :day, :all_seats, :specific_gender, :smooking)
  end
end
