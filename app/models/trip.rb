class Trip < ApplicationRecord
  has_many :stop_points
  has_many :hh_stop_points, through: :stop_points
  accepts_nested_attributes_for :stop_points
  belongs_to :driver, class_name: 'User'
  belongs_to :car
  validates :day, :all_seats, :driver_id, :car_id, presence: true

  now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
  scope :upcoming, ->{ where('day > ? AND status = ?', Time.now.strftime("%Y-%m-%d"), "pending") }
  scope :ongoing, ->{ where('day = ? AND status = ?', Time.now.strftime("%Y-%m-%d"), "started") }
  scope :history, ->{ where('day < ? AND status = ?', Time.now.strftime("%Y-%m-%d"), "ended") }
  #scope :upcoming, ->{ where('day >= ?', Time.current.midnight).joins(:stop_points).where("start_time > ?", Time.now.advance(hours: 4).strftime("%I:%M:%S %p")) }
  #scope :ongoing, ->{ where('day = ?', Time.current.midnight).joins(:stop_points).where('start_time > ? AND end_time < ?', Time.now.strftime("%I:%M:%S %p"), Time.now.advance(hours: 3).strftime("%I:%M:%S %p")) }
  #scope :history, ->{ where('day <= ?', Time.current.midnight).joins(:stop_points).where("end_time < ?", Time.current }
  #scope :upcoming, ->{ joins(:stop_points).where("start_time > ?", now) }
  #scope :ongoing, ->{ joins(:stop_points).where('start_time < ? AND end_time > ?', now, now) }
  #scope :history, ->{ joins(:stop_points).where("end_time < ?", now) }
  #scope :upcoming, ->{ joins(:stop_points).where("start_time > ?", Time.now.advance("hours": 2).strftime("%Y-%m-%d %H:%M:%S")) }
  #scope :ongoing, ->{ joins(:stop_points).where('start_time < ? AND end_time > ?', Time.now.strftime("%Y-%m-%d %H:%M:%S"), Time.now.advance("hours": 1).strftime("%Y-%m-%d %H:%M:%S")) }
  #scope :history, ->{ joins(:stop_points).where("end_time < ?", Time.now.strftime("%Y-%m-%d %H:%M:%S")) }

  def available_seats
    seats = self.stop_points.joins(:hh_stop_points).sum :booked_seats
    self.all_seats - seats
  end

  def self.filter_by_day_and_location(day, location_id_start, location_id_end,  start_time, end_time)
    self.where(day: day).joins('INNER JOIN stop_points a ON trips.id = a.trip_id')
                        .joins('INNER JOIN stop_points b ON trips.id = b.trip_id')
                        .where('a.location_id': location_id_start, 'a.start_time': [start_time, end_time], 'b.location_id': location_id_end)
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

  def get_on_hold_points
    onhold_points = self.stop_points.joins(:hh_stop_points).sum :points_on_hold
    self.driver.add_points(onhold_points)
  end


end

