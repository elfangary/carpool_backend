class HhStopPointsController < ApplicationController
    attr_accessor :hh_id
    before_action :set_stop_point
    before_action :set_hh_stop_point, :only [:update]

    def create
        @hh_id = current_user.id
        @hh_stop_point = @stop_point.hh_stop_points.build hh_stop_point_params
        if @hh_stop_point.save
            render json: @hh_stop_point , status: :ok
        else
            render json: @_hh_stop_point.errors, status: :unprocessable_entity
        end
    end

    private
 
    def set_stop_point
        @stop_point = StopPoint.find params[:stop_point_id]
    end
    
    def hh_stop_point_params
        params.permit(:stop_point_id, :booked_seats, :confirm)
    end
    
end