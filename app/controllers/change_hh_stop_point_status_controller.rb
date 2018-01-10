class ChangeHhStopPointStatusController < ApplicationController
    before_action :set_hh_stop_point, only: [:update]
    # after_action :set_read_attribute
    after_action :create_notification, only: :update

    def update
        hh_stop_point = @hh_stop_point.accept_or_reject_hhStopPoint(params[:confirm])
        render json: hh_stop_point, status: :ok
    end

    # def set_read_attribute
    #   @notifications = current_user.notifications.update_all(read: true)
    # end

    private
    def set_hh_stop_point
      @hh_stop_point = HhStopPoint.find params[:id]
    end

    def create_notification
        @notification = @hh_stop_point.notifications.new
        if (params[:confirm] == "accepted")
            @notification.body = 'Your request have been accepted'
        else
            @notification.body = 'Your request have been Reject'
        end
        @notification.user_id = @hh_stop_point.hh_id
        @notification.save!
    end

end
