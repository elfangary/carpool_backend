class Trip < ApplicationRecord
  has_many :stop_points
  has_many :hh_stop_points, through: :stop_points
  accepts_nested_attributes_for :stop_points
  belongs_to :driver, class_name: 'User'
  belongs_to :car
  validates :day, :all_seats, :driver_id, :car_id, presence: true

  now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
  scope :upcoming, ->{ where('status = ?', "pending") }
  scope :ongoing, ->{ where('status = ?', "started") }
  scope :history, ->{ where('status = ?', "ended") }

  def available_seats
    seats = self.stop_points.joins(:hh_stop_points).where('confirm = ?', "accepted").sum :booked_seats
    self.all_seats - seats
  end

  def self.filter_by_day_and_location(day, location_id_start, location_id_end, start_time, end_time)
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
      hh_trips.upcoming.uniq
    elsif time == "ongoing"
      hh_trips.ongoing.uniq
    elsif time == "history"
      hh_trips.history.uniq
    end
  end

  def change_trip_status(new_status)
    self.status = new_status
    self.save
  end

  def get_on_hold_points
    onhold_points = self.stop_points.joins(:hh_stop_points).sum :points_on_hold
    self.driver.add_points(onhold_points)
  end

end

