class NotificationCreationEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(*args)
    notification = args[0]
    ActionCable
      .server
      .broadcast("notifications:#{notification.user_id}", json_notify(notification))
  end

  def json_notify(notification)
    builder = JbuilderTemplate.new(ApplicationController.new.view_context)
    builder.partial!("notifications/notification", notification: notification)
    ActiveSupport::JSON.decode(builder.target!)
  end
end