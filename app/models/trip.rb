class Trip < ApplicationRecord
  # has_many :stop_points
  belongs_to :driver, class_name: 'User'
  belongs_to :car

  validates :day, :all_seats, :driver_id, :car_id, presence: true
end
