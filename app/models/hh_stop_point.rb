class HhStopPoint < ApplicationRecord
  has_many :notifications
  belongs_to :stop_point
  belongs_to :hh, class_name: 'User'

  validates :hh, associated: true
  validates :stop_point, :hh, :booked_seats, presence: true
  before_create :charge_user

  def accept_or_reject_hhStopPoint(val)
      self.confirm = val
      self.save
  end

  def charge_user
    amount = self.booked_seats * 5
    if self.hh.withdraw(amount)
      self.points_on_hold = amount
    end
  end
end
