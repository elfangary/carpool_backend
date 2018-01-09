class ChangeHhStopPointStatusController < ApplicationController
    before_action :set_hh_stop_point, only: [:update]
    after_action :set_read_attribute

    def update
        hh_stop_point = @hh_stop_point.accept_or_reject_hhStopPoint(params[:confirm])
        render json: hh_stop_point, status: :ok
    end

    def set_read_attribute
      @notifications = current_user.notifications.update_all(read: true)
    end

    private
    def set_hh_stop_point
      @hh_stop_point = HhStopPoint.find params[:id]
    end
end
