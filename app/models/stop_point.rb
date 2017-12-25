class StopPoint < ApplicationRecord
    belongs_to :trip
    belongs_to :location
    #has_many :hh_stop_points, dependent: :destroy

    validates :trip_id, :location_id, :start_time, :end_time, presence: true
end
