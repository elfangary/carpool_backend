class HhStopPoint < ApplicationRecord
  has_many :notifications
  belongs_to :stop_point
  belongs_to :hh, class_name: 'User'
  has_one :trip, through: :stop_point

  validates :hh, associated: true
  validates :stop_point, :hh, :booked_seats, presence: true
  validate :check_hh, on: :create
  before_create :charge_user

  def check_hh
    if self.trip.hitch_hikers.pluck(:id).include? self.hh_id
      errors.add('Cannot join trip more than once.')
    end
  end

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

    def add_points_to_hh
        amount = self.points_on_hold
        self.hh.add_points(amount)
        self.reset_points
    end

    def reset_points
        self.points_on_hold = 0
        self.save
    end
end
