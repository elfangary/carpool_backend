class Trip < ApplicationRecord
  has_many :stop_points
  accepts_nested_attributes_for :stop_points
  belongs_to :driver, class_name: 'User'
  belongs_to :car
  validates :day, :all_seats, :driver_id, :car_id, presence: true

  scope :upcoming, ->{ where('day > ?', Time.zone.now.midnight) }
  scope :ongoing, ->{ where('day = ?', Time.zone.now.midnight) }
  scope :history, ->{ where('day < ?', Time.zone.now.midnight) }

  def available_seats
    seats = self.stop_points.joins(:hh_stop_points).sum :booked_seats
    self.all_seats - seats
  end
end

