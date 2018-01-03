class HhStopPoint < ApplicationRecord
    belongs_to :stop_point
    belongs_to :hh, class_name: 'User'

    validates :stop_point, :hh, :booked_seats, presence: true
end
