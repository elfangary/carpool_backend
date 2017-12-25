json.extract!(@user, :first_name, :last_name, :email, :gender, :hashed_password, :phone, :profile_pic, :rate, :points)

  # json.cars do
  #   json.array! @user.cars do |car|
  #     json.model car.model
  #     json.color car.color
  #     json.number car.number
  #   end
  # end
