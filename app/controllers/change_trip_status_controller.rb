class ChangeTripStatusController < ApplicationController
    before_action :set_trip, only: [:update]

    def update
        trip = @trip.change_trip_status(params[:status])
        render json: @trip, status: :ok
    end

    private
    def set_trip
        @trip = Trip.find params[:trip_id]
    end
end
