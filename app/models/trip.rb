class Trip < ApplicationRecord
  has_many :stop_points
  has_many :hh_stop_points, through: :stop_points
  accepts_nested_attributes_for :stop_points
  belongs_to :driver, class_name: 'User'
  belongs_to :car
  validates :day, :all_seats, presence: true
  validates :all_seats, numericality: { less_than_or_equal_to: 4,  only_integer: true }
  validate :day_cannot_be_in_the_past

  scope :upcoming, ->{ where('status = ?', "pending") }
  scope :ongoing, ->{ where('status = ?', "started") }
  scope :history, ->{ where('status IN (?)', ["ended", "cancelled", "timedout"]) }
  scope :has_seats, ->{where("is_fully_booked=?", false)}


  def day_cannot_be_in_the_past
    errors.add(:day, 'cannot be in the past!') if self.day < Date.current unless day.nil?
  end

  def available_seats
    seats = self.stop_points.joins(:hh_stop_points).where('confirm = ?', "accepted").sum :booked_seats
    self.all_seats - seats
  end
  
  def is_fully_booked?
    self.available_seats == 0
  end

  def self.filter_by_day_and_location(day, location_id_start, location_id_end)
    self.where('day = ? AND status = ? AND all_seats > ?', day, 'pending', 0)
    .joins('INNER JOIN stop_points a ON trips.id = a.trip_id')
    .joins('INNER JOIN stop_points b ON trips.id = b.trip_id')
    .where('a.location_id': location_id_start, 'b.location_id': location_id_end).uniq.select{|t| t.is_fully_booked? == false}
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

  def get_on_hold_points()
    onhold_points = self.stop_points.joins(:hh_stop_points).sum :points_on_hold
    self.driver.add_points(onhold_points)
    self.hh_stop_points.map { |hh_stop_point| hh_stop_point.reset_points }
  end

  def cleanUp
    end_time = self.stop_points.order(end_time: :desc).first.end_time.to_formatted_s(:db)
    time = Time.now.to_formatted_s(:db)

    if (time >= end_time)
      self.hh_stop_points.map { |hh_stop_point|
        puts "inside hh"
        if (self.status == "pending" || hh_stop_point.confirm == "pending")
          hh_stop_point.add_points_to_hh
          hh_stop_point.confirm = "timedout"
          hh_stop_point.save
        end
      }
      self.status = "timedout" if self.status == "pending"
      self.save
    end
  end
end

