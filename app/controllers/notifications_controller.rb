class NotificationsController < ApplicationController
  after_action :set_read_attribute, only: :index

  def index
    @notifications = current_user.notifications.order(created_at: :DESC)
  end

  def set_read_attribute
    @notifications = current_user.notifications.update_all(read: true)
  end

  # def update
  #   @notification = Notification.find(params[:id])
  #   @notification = @notification.update_attributes(notification_params)
  # end

  private
  def notification_params
    params.permit(:user_id, :body, :hh_stop_point_id, :read)
  end

end
