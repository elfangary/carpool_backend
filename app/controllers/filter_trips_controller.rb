class FilterTripsController < ApplicationController
    def index
        @filtered_trips = Trip.filter_by_day_and_location(params[:day], params[:location_id_start], params[:location_id_end], params[:start_time], params[:end_time])
        @ff = @filtered_trips.map do |trip|
            trip.change_available_seats
        end
        render json: @ff.to_json(:include =>  {:stop_points => {:include => :location}, :driver => {}}), status: :ok

    end
end
