require 'rails_helper'

RSpec.describe User, type: :model do
    
  context "can not be created without validations on " do
    it "first_name exist" do
      user = User.new(:last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      expect(user.valid?).to eq(false)
    end

    it "last_name exist" do
      user = User.new(:first_name => "abdelrhman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      expect(user.valid?).to eq(false)
    end

    it "email exist" do
      user = User.new(:first_name => "abdelrhman", :last_name => "Taman", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      expect(user.valid?).to eq(false)
    end

    it "can not create 2 users with same email" do
      user1 = User.create(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      user2 = User.create(:first_name => "lina", :last_name => "elshrife", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghhhh", :phone => "01277765378", :gender => "female")
      expect(user1.valid?).to eq(true)
      expect(user2.valid?).to eq(false)
    end

    it "hashed_password exist" do
      user = User.new(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :phone => "01223765378", :gender => "male")
      expect(user.valid?).to eq(false)
    end

    it "can not create 2 users with same hashed_password" do
      user1 = User.create(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      user2 = User.create(:first_name => "lina", :last_name => "elshrife", :email => "linaElshrif@gmail.com", :hashed_password => "ghgh22", :phone => "01277765378", :gender => "female")
      expect(user1.valid?).to eq(true)
      expect(user2.valid?).to eq(false)
    end

    it "phone exist" do
      user = User.new(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :gender => "male")
      expect(user.valid?).to eq(false)
    end

    it "can not create 2 users with same phone" do
      user1 = User.create(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      user2 = User.create(:first_name => "lina", :last_name => "elshrife", :email => "linaElshrif@gmail.com", :hashed_password => "ghhhh", :phone => "01223765378", :gender => "female")
      expect(user1.valid?).to eq(true)
      expect(user2.valid?).to eq(false)
    end

    it "put default rate" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      expect(user.rate).to eq(0)
    end

    it "put default points" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      expect(user.points).to eq(100)
    end

    it "specific format for email" do
      user = User.new(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTamangmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      expect(user.valid?).to eq(false)
    end
  end

  context "user has many cars" do
    it "test with 2 or more cars" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      car1 = user.cars.create(:model => "opel", :color => "red", :number => "123")
      car2 = user.cars.create(:model => "opel", :color => "red", :number => "12311")
      expect(user.reload.cars).to eq([car1, car2])
    end

    it "test cars dependent destroy" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create!(:id => 1, :model => "opel", :color => "red", :number => "123")
      expect { user.destroy }.to change(Car, :count).by(-1)
    end
  end

  context "user has many trips" do
    it "test trip has valid user and valid car" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip1 = user.trips.create!(:car_id => 1, :day => 1, :all_seats => 3)
      expect(trip1.valid?).to eq(true)
    end

     it "test with 2 or more trip" do
      user = User.create!(:first_name => "abdelrhman", :last_name => "Taman", :email => "abdelrhmanTaman@gmail.com", :hashed_password => "ghgh22", :phone => "01223765378", :gender => "male")
      car = user.cars.create(:id => 1, :model => "opel", :color => "red", :number => "123")
      trip1 = user.trips.create!(:car_id => 1, :day => 1, :all_seats => 3)
      trip2 = user.trips.create!(:car_id => 1, :day => 1, :all_seats => 3)
      expect(user.reload.trips).to eq([trip1, trip2])
    end
  end
end
