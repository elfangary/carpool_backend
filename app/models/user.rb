class User < ApplicationRecord
  mount_uploader :profile_pic, ImageUploader

  has_many :cars, dependent: :destroy
  has_many :hh_stop_points, class_name: 'HhStopPoint', foreign_key: :hh_id, dependent: :destroy
  has_many :stop_points, through: :hh_stop_points
  has_many :trips, through: :stop_points
  # has_many :location_requests, dependent: :destroy
  has_many :trips, class_name: 'Trip', foreign_key: :driver_id, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_secure_password

  validates :first_name, :last_name, :email, :phone, :rate, :points, :gender, presence: true
  validates :email, :phone, uniqueness: true
  validates :email, format: { with: /(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/ }


  def addChargedPoints(chargedPoints)
    self.points += chargedPoints
  end

  def change_rating(user_id, val)
    user = User.where('id = ?', user_id)
    user.raters_no += 1
    user.rate += val
    user.save
  end

  def driver_trips_tracking(time)
    driver_trips = self.trips.where('driver_id = ?', self.id)
    if time == "upcoming"
      driver_trips.upcoming
    elsif time == "ongoing"
      driver_trips.ongoing
    elsif time == "history"
      driver_trips.history
    end
  end

  def withdraw(amount)
    if self.points >= amount
      self.points -= amount
      self.save
      return true
    end
      self.errors.add(:points, 'could not withdraw amount')
    return false
  end

  def add_points(amount)
    self.points += amount
    self.save
  end

end
