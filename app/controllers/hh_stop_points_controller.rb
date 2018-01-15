class HhStopPointsController < ApplicationController
    attr_accessor :hh_id
    before_action :set_stop_point, only: [:create]
    before_action :set_hh_stop_point, only: [:update]
    after_action :create_notification, only: :create
    after_action :create_notification_after_update, only: :update

    def create
        @hh_id = current_user.id
        @hh_stop_point = @stop_point.hh_stop_points.build hh_stop_point_params
        if @hh_stop_point.save
            render json: @hh_stop_point, status: :ok
        else
            render json: @_hh_stop_point.errors.full_messages, status: :unprocessable_entity
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
        params.permit(:stop_point_id, :booked_seats).merge(hh_id: @hh_id)
    end

    def create_notification
        @notification = @hh_stop_point.notifications.new 
        @notification.body = 'You have a new request'
        @notification.user_id = @hh_stop_point.stop_point.trip.driver_id
        @notification.save!
    end

    def create_notification_after_update
        @notification = @hh_stop_point.notifications.new
        if (params[:confirm] == "pending")
            @notification.body = 'Your request have been sent, wait for answer'
        elsif (params[:confirm] == "accepted")
            @notification.body = 'Your request have been accepted'
        elsif (params[:confirm] == "rejected")
            @notification.body = 'Your request have been rejected'
        elsif (params[:confirm] == "cancelled")
            @notification.body = 'Sorry,The Trip have been cancelled'
        else
            @notification.body = 'You got your points back, check your points'
        end
        @notification.user_id = @hh_stop_point.hh_id
        @notification.save!
    end

end