class HhTripsTrackingController < ApplicationController

def index
    trips = current_user.hh_trips_tracking(params[:time])
    render json: trips.to_json(:include =>  {:stop_points => {:include => :location}, :driver => {}}), status: :ok
end

end
