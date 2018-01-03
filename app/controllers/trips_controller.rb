class TripsController < ApplicationController
  before_action :set_trip, only: [:show]
  before_action :set_user, only: [:driverTripsTracking, :hhTripsTracking]
  
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

  #filter trips by day and location

  def filter_by_day_and_location
    @filtered_trips = Trip.where(
      day: params[:day]
    ).joins(:stop_points).where(
      'stop_points.location_id': params[:location_id], 
      'stop_points.start_time': [params[:start_time], params[:end_time]]
    )
    ff = @filtered_trips.map do |trip|
      trip.all_seats = trip.available_seats
      trip
    end
    render json: ff.to_json(:include =>  {:stop_points => {:include => :location}, :driver => {}}), status: :ok
  end

  #driver trips tracking

  def driverTripsTracking
    if params[:time] == "upcoming"
      @driver_trips = @user.trips
      @driver_upcoming_trips = @driver_trips.upcoming
      render json: @driver_upcoming_trips.to_json(:include =>  {:stop_points => {:include => :location}, :driver => {}}), status: :ok
    
    elsif params[:time] == "ongoing"
      @driver_trips = @user.trips
      @driver_ongoing_trips = @driver_trips.ongoing
      render json: @driver_ongoing_trips.to_json(:include =>  {:stop_points => {:include => :location}, :driver => {}}), status: :ok
    
    elsif params[:time] == "history"
      @driver_trips = @user.trips
      @driver_history_trips = @driver_trips.history
      render json: @driver_history_trips.to_json(:include =>  {:stop_points => {:include => :location}, :driver => {}}), status: :ok
    end
  end

  #hitch-hiker trips tracking

  def hhTripsTracking
    if params[:time] == "upcoming"
      @hitch_hiker_trips = Trip.upcoming.joins(stop_points: {hh_stop_points: :hh}).where('hh_id = ?', params[:id])
      render json: @hitch_hiker_trips.to_json(:include =>  {:stop_points => {:include => :location}, :driver => {}}), status: :ok
    elsif params[:time] == "ongoing"
      @hitch_hiker_trips = Trip.ongoing.joins(stop_points: {hh_stop_points: :hh}).where('hh_id = ?', params[:id])
      render json: @hitch_hiker_trips.to_json(:include =>  {:stop_points => {:include => :location}, :driver => {}}), status: :ok
    elsif params[:time] == "history"
      @hitch_hiker_trips = Trip.history.joins(stop_points: {hh_stop_points: :hh}).where('hh_id = ?', params[:id])
      render json: @hitch_hiker_trips.to_json(:include =>  {:stop_points => {:include => :location}, :driver => {}}), status: :ok
    end
  end


  private
  def set_trip
    @trip = Trip.find params[:id]
  end

  def set_user
    @user = User.find params[:id]
  end

  def trip_params
    params.permit(:car_id, :driver_id, :day, :all_seats, :specific_gender, :smoking, stop_points_attributes: [:location_id, :start_time, :end_time])
  end
end
