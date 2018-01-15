require 'rails_helper'

RSpec.describe StopPoint, type: :model do
  context "can not be created without validations on" do
    it "valid stop point" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip = user.trips.create(:car_id => 1, :day => 3, :all_seats => 3)
      location = Location.create(:id => 1, :name => "Maadi")
      stop_point = trip.stop_points.create!(:start_time => "02:00", :end_time => "02:30", :location_id => 1)
      
      expect(user.valid?).to eq(true)
      expect(car.valid?).to eq(true)
      expect(trip.valid?).to eq(true)
      expect(location.valid?).to eq(true)
      expect(stop_point.valid?).to eq(true)
    end

    it "start time exist" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip = user.trips.create!(:id => 1, :car_id => 1, :day => 3, :all_seats => 3)
      location = Location.create!(:id => 1, :name => "Maadi")
      stop_point = StopPoint.create(:end_time => "02:30", :location_id => 1, :trip_id => 1)
      
      expect(user.valid?).to eq(true)
      expect(car.valid?).to eq(true)
      expect(location.valid?).to eq(true)
      expect(trip.valid?).to eq(true)
      expect(stop_point.valid?).to eq(false)
    end

    it "end time exists" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip = user.trips.create!(:id => 1, :car_id => 1, :day => 3, :all_seats => 3)
      location = Location.create!(:id => 1, :name => "Maadi")
      stop_point = StopPoint.create(:start_time => "02:30", :location_id => 1, :trip_id => 1)
      
      expect(user.valid?).to eq(true)
      expect(car.valid?).to eq(true)
      expect(location.valid?).to eq(true)
      expect(trip.valid?).to eq(true)
      expect(stop_point.valid?).to eq(false)
    end

    it "location exists" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :assword => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip = user.trips.create!(:id => 1, :car_id => 1, :day => 3, :all_seats => 3)
      location = Location.create!(:id => 1, :name => "Maadi")
      stop_point = StopPoint.create(:start_time => "02:00", :end_time => "02:00", :trip_id => 1)
      
      expect(user.valid?).to eq(true)
      expect(car.valid?).to eq(true)
      expect(location.valid?).to eq(true)
      expect(trip.valid?).to eq(true)
      expect(stop_point.valid?).to eq(false)
    end

    it "location exists and valid" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip = user.trips.create!(:id => 1, :car_id => 1, :day => 3, :all_seats => 3)
      stop_point = StopPoint.create(:start_time => "02:00", :end_time => "02:00", :location_id => 1, :trip_id => 1)
      
      expect(user.valid?).to eq(true)
      expect(car.valid?).to eq(true)
      expect(trip.valid?).to eq(true)
      expect(stop_point.valid?).to eq(false)
    end

    it "trip exists" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip = user.trips.create(:id => 1, :car_id => 1, :day => 3, :all_seats => 3)
      location = Location.create(:id => 1, :name => "Maadi")
      stop_point = StopPoint.create(:start_time => "02:00", :end_time => "02:30", :location_id => 1)
      
      expect(user.valid?).to eq(true)
      expect(car.valid?).to eq(true)
      expect(location.valid?).to eq(true)
      expect(trip.valid?).to eq(true)
      expect(stop_point.valid?).to eq(false)
    end

    it "trip exists and valid" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      location = Location.create(:id => 1, :name => "Maadi")
      stop_point = StopPoint.create(:start_time => "02:00", :end_time => "02:30", :location_id => 1, :trip_id => 1)
      
      expect(user.valid?).to eq(true)
      expect(car.valid?).to eq(true)
      expect(location.valid?).to eq(true)
      expect(stop_point.valid?).to eq(false)
    end


  end
end
