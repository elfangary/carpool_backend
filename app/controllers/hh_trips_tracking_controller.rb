class HhTripsTrackingController < ApplicationController

def index
    @trips = Trip.hh_trips_tracking(params[:time], current_user)
end

end
