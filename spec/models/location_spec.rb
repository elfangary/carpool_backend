require 'rails_helper'

RSpec.describe Location, type: :model do
  context "can not be created without validations on " do
    it "name exist" do
      location = Location.new()
      expect(location.valid?).to eq(false)
    end
  end

  context "has many stop points" do
    it "test with 2 or more stop points" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip1 = user.trips.create!(:id => 1, :car_id => 1, :day => 1, :all_seats => 3)
      location = Location.create(:name => "Maadi")
      stop_point1 = location.stop_points.create(:start_time => "02:00", :end_time => "02:30", :trip_id => 1)
      stop_point2 = location.stop_points.create(:start_time => "04:00", :end_time => "04:30", :trip_id => 1)
      expect(location.reload.stop_points).to eq([stop_point1, stop_point2])
    end

    it "test stop points dependent destroy" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip1 = user.trips.create!(:id => 1, :car_id => 1, :day => 1, :all_seats => 3)
      location = Location.create(:name => "Maadi")
      location_cloned = location
      stop_point1 = location.stop_points.create(:start_time => "02:00", :end_time => "02:30", :trip_id => 1)
      stop_point2 = location.stop_points.create(:start_time => "04:00", :end_time => "04:30", :trip_id => 1)
      
      expect { location.destroy }.to change(StopPoint, :count).by(-2)
    end
  end
end
