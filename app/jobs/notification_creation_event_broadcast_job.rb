class NotificationCreationEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(*args)
    notification = args[0]
    ActionCable
      .server
      .broadcast("notifications:#{notification.user_id}", notification)
  end
end