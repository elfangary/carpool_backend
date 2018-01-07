class HhTripsTrackingController < ApplicationController

def index
    @trips = Trip.hh_trips_tracking(params[:time], current_user)
    render json: @trips.to_json(:include => {:stop_points => {:include => [:location, :hh_stop_points => {:include => :hh}]}, :driver => {}}), status: :ok
end

end
