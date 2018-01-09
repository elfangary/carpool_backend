class HhStopPoint < ApplicationRecord
  has_many :notifications
  belongs_to :stop_point
  belongs_to :hh, class_name: 'User'

  validates :stop_point, :hh, :booked_seats, presence: true

  def accept_or_reject_hhStopPoint(val)
      self.confirm = val
      self.save
  end

end
