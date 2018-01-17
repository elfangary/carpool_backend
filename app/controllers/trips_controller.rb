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
      end_time = Time.zone.at(params[:time_in_seconds] / 1000)
      TripStatusJob.set(wait_until: end_time).perform_later(@trip)
      render json: @trip, status: :created, location:[ @trip, @stop_point ]
    else
      render json: @trip.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @trip.change_trip_status(params[:status])

    if params[:status] == "ended"
      @trip.get_on_hold_points
    elsif params[:status] == "cancelled"
      @trip.hh_stop_points.map { |hh_stop_point|
      hh_stop_point.confirm = "cancelled"
      hh_stop_point.add_points_to_hh }
    end

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