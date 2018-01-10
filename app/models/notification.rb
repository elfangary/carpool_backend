class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :hh_stop_point

  validates :body, :user_id,  presence: true

  after_create_commit do
    NotificationCreationEventBroadcastJob.perform_later(self)
  end

end
