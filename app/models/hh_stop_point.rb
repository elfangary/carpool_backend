class HhStopPoint < ApplicationRecord
    belongs_to :stop_point
    belongs_to :hh, class_name: 'User'
    # accepts_nested_attributes_for :notifications

    validates :stop_point, :hh, :booked_seats, presence: true

    def accept_or_reject_hhStopPoint(val)
        self.confirm = val
        self
    end
end