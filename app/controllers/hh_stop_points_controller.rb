class HhStopPointsController < ApplicationController
    attr_accessor :hh_id
    before_action :set_stop_point, only: [:create]
    before_action :set_hh_stop_point, only: [:update]

    def create
        @hh_id = current_user.id
        @hh_stop_point = @stop_point.hh_stop_points.build hh_stop_point_params
        if @hh_stop_point.save
            render json: @hh_stop_point, status: :ok
        else
            render json: @_hh_stop_point.errors, status: :unprocessable_entity
        end
    end

    def update
        @hh_stop_point.accept_or_reject_hhStopPoint(params[:confirm])

        @hh_stop_point.add_points_to_hh if params[:confirm] == "rejected"

        render json: {hh_stop_point: @hh_stop_point, points: current_user.points}, status: :ok
    end

    private
    def set_stop_point
        @stop_point = StopPoint.find params[:stop_point_id]
    end

    def set_hh_stop_point
        @hh_stop_point = HhStopPoint.find params[:id]
    end

    def hh_stop_point_params
        current_user.id = hh_id
         # notifications_attributes: [:body, :user_id, :read]
        params.permit(:stop_point_id, :booked_seats).merge(hh_id: @hh_id)
    end

end