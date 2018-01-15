require 'rails_helper'

RSpec.describe Trip, type: :model do
  context "can not be created without validation on " do
    it "valid trip" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip = user.trips.create(:car_id => 1, :day => 3, :all_seats => 3)
      expect(trip.valid?).to eq(true)
    end
    it "day exists" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip = user.trips.create(:car_id => 1, :all_seats => 3)
      expect(trip.valid?).to eq(false)
    end

    it "all seats exists" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip = user.trips.create(:car_id => 1, :day => 1)
      expect(trip.valid?).to eq(false)
    end

    it "specific gender null valid" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip = user.trips.create(:car_id => 1, :day => 1, :all_seats => 3)
      expect(trip.valid?).to eq(true)
    end

     it "add specific gender" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip1 = user.trips.create(:car_id => 1, :day => 1, :all_seats => 3, :specific_gender => "male")
      trip2 = user.trips.create(:car_id => 1, :day => 1, :all_seats => 3, :specific_gender => "female")
      expect(trip1.valid?).to eq(true)
      expect(trip2.valid?).to eq(true)
    end

    it "add smoking" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip1 = user.trips.create(:car_id => 1, :day => 1, :all_seats => 3, :smoking => true)
      trip2 = user.trips.create(:car_id => 1, :day => 1, :all_seats => 3, :specific_gender => "male", :smoking => false)
      expect(trip1.valid?).to eq(true)
      expect(trip2.valid?).to eq(true)
    end
  end

  context "belongs to" do
    it "valid car" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      trip = user.trips.create(:car_id => 1, :day => 1, :all_seats => 3, :specific_gender => "male", :smoking => false)
      expect(trip.valid?).to eq(false)
    end

    it "valid user" do
      car = Car.create(:user_id => 1, :model => "opel", :color => "red", :number => "123")
      trip = car.trips.new(:day => 1, :all_seats => 3, :specific_gender => "male", :smoking => false)
      expect(trip.valid?).to eq(false)
    end
  end

  context "has many stop points " do
    it "test with 2 or more stop point" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip = user.trips.create(:car_id => 1, :day => 1, :all_seats => 3, :specific_gender => "male")
      location1 = Location.create(:id => 1, :name => "Maadi")
      location2 = Location.create(:id => 2, :name => "Naser city")
      stop_point1 = trip.stop_points.create(:start_time => "02:00", :end_time => "02:30", :location_id => 1)
      stop_point2 = trip.stop_points.create(:start_time => "04:00", :end_time => "04:30", :location_id => 2)
      
      expect(trip.valid?).to eq(true)
      expect(location1.valid?).to eq(true)
      expect(location2.valid?).to eq(true)
      expect(stop_point1.valid?).to eq(true)
      expect(trip.reload.stop_points).to eq([stop_point1, stop_point2])
    end

    it "accepts nested attributes for stop points" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      location1 = Location.create!(:id => 1, :name => "Maadi")
      location2 = Location.create!(:id => 2, :name => "Naser city")
      car = user.cars.create(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip = user.trips.create(:car_id => 1, :day => 1, :all_seats => 3, :specific_gender => "male",
       :stop_points_attributes => [{:start_time => "02:00", :end_time => "02:30", :location_id => 1},
       {:start_time => "04:00", :end_time => "04:30", :location_id => 2}])
      
      expect(user.valid?).to eq(true)
      expect(car.valid?).to eq(true)
      expect(location1.valid?).to eq(true)
      expect(location2.valid?).to eq(true)
      expect(trip.valid?).to eq(true)
    end
  end
end
