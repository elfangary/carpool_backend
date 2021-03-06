class StopPoint < ApplicationRecord
  belongs_to :trip
  belongs_to :location
  has_many :hh_stop_points, dependent: :destroy

  validates :start_time, :end_time, presence: true
  validates :trip, associated: true
end
