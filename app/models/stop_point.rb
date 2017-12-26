class StopPoint < ApplicationRecord
    belongs_to :trip
    belongs_to :location
    #has_many :hh_stop_points, dependent: :destroy

    validates :trip, :location, :start_time, :end_time, presence: true
end
