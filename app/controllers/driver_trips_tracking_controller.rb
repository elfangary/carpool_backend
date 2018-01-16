class DriverTripsTrackingController < ApplicationController

  def index
    @trips = current_user.driver_trips_tracking(params[:time])
  end

end
