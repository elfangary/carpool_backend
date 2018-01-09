class Trip < ApplicationRecord
  has_many :stop_points
  has_many :hh_stop_points, through: :stop_points
  accepts_nested_attributes_for :stop_points
  belongs_to :driver, class_name: 'User'
  belongs_to :car
  validates :day, :all_seats, :driver_id, :car_id, presence: true

  scope :upcoming, ->{ where('day > ?', Time.zone.now.midnight) }
  #scope :ongoing, ->{ where('day = ?', Time.zone.now.midnight) }
  scope :history, ->{ where('day < ?', Time.zone.now.midnight) }
  #scope :upcoming, ->{ where('day >= ?', Time.zone.now.midnight).joins(:stop_points).where("start_time > ?", Time.now.strftime("%H:%M:%S")) }
  scope :ongoing, ->{ where('day = ?', Time.zone.now.midnight).joins(:stop_points).where('start_time > ? AND end_time < ?', Time.now.strftime("%H:%M:%S"), Time.now.strftime("%H:%M:%S")) }
  #scope :history, ->{ where('day <= ?', Time.zone.now.midnight).joins(:stop_points).where("start_time < ?", Time.now.strftime("%H:%M:%S")) }

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

  def self.hh_trips_tracking(time, current_user)
    hh_trips = self.joins(stop_points: {hh_stop_points: :hh}).where('hh_id = ?', current_user.id)
    if time == "upcoming"
      hh_trips.upcoming
    elsif time == "ongoing"
      hh_trips.ongoing
    elsif time == "history"
      hh_trips.history
    end
  end


end

