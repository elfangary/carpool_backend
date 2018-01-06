class Trip < ApplicationRecord
  has_many :stop_points
  accepts_nested_attributes_for :stop_points
  belongs_to :driver, class_name: 'User'
  belongs_to :car
  validates :day, :all_seats, :driver_id, :car_id, presence: true

  scope :upcoming, ->{ where('day > ?', Time.zone.now.midnight) }
  scope :ongoing, ->{ where('day = ?', Time.zone.now.midnight) }
  scope :history, ->{ where('day < ?', Time.zone.now.midnight) }
  #scope :ongoing, ->{ joins(:stop_points).where("? BETWEEN start_time AND end_time", Time.now.strftime("%H:%M"))}

  def available_seats
    seats = self.stop_points.joins(:hh_stop_points).sum :booked_seats
    self.all_seats - seats
  end

  def self.filter_by_day_and_location(day, location_id, start_time, end_time)
    self.where(
      day: day
    ).joins(:stop_points).where(
      'stop_points.location_id': location_id, 
      'stop_points.start_time': [start_time, end_time]
    )
  end
  
  def change_available_seats
    self.all_seats = self.available_seats
    self
  end

end

