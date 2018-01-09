class DriverTripsTrackingController < ApplicationController

  def index
    trips = current_user.driver_trips_tracking(params[:time])
    render json: trips.to_json(:include => {:stop_points => {:include => [:location, :hh_stop_points => {:include => :hh}]}, :driver => {}}), status: :ok
  end

end
