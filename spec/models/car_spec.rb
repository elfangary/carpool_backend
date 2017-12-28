require 'rails_helper'

RSpec.describe Car, type: :model do

  context "can not be created without validations on " do
    it "model exist" do
      car = Car.new(:color => "red", :number => "123")
      expect(car.valid?).to eq(false)
    end

    it "color exist" do
      car = Car.new(:model => "opel", :number => "123")
      expect(car.valid?).to eq(false)
    end

    it "number exist" do
      car = Car.new(:model => "opel", :color => "red")
      expect(car.valid?).to eq(false)
    end

    it "number is unique" do
      user = User.create!(:id => 1, :first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      car1 = Car.create(:user_id => 1, :model => "opel", :color => "red",:number => "123")
      car2 = Car.create(:user_id => 1, :model => "opel", :color => "black",:number => "123")
      expect(car1.valid?).to eq(true)
      expect(car2.valid?).to eq(false)
    end

    it "can not created without user" do
      car = Car.create(:model => "opel", :color => "red",:number => "123")
      expect(car.valid?).to eq(false)
    end
    
    it "car belongs to user" do
      user = User.create!(:id => 1, :first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create(:model => "opel", :color => "red",:number => "123")
      expect(car.valid?).to eq(true)
      expect(user.reload.cars).to eq([car])
    end
  end

  context "has many trips" do
    it "has 2 or more trips" do
      user = User.create!(:id => 1, :first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create(:model => "opel", :color => "red",:number => "123")
      trip1 = car.trips.create!(:driver_id => 1, :day => 1, :all_seats => 3)
      trip2 = car.trips.create!(:driver_id => 1, :day => 1, :all_seats => 3)
      expect(car.reload.trips).to eq([trip1, trip2])
    end
  end

end
