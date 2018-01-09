class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications
  end

  def create
    @notification = Notification.new notification_params
    if @notification.save!
      render :show
    else
      render json: {message: 'notification error'}, status: :unprocessable_entity
    end
  end

  def update
    @notification = Notification.find(params[:id])
    @notification = @notification.update_attributes(notification_params)
  end

  private
  def notification_params
    params.permit(:user_id, :body, :hh_stop_point_id, :read)
  end

end
