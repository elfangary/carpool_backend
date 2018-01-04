class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :hh_stop_point

  validates :body, :user_id,  presence: true
end
