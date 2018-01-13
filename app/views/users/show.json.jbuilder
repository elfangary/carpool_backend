
json.profile_pic "http://localhost:3001/#{@current_user.profile_pic.url}"
json.extract!(@current_user, :first_name, :last_name, :email, :gender, :password, :phone, :profile_pic, :rate, :raters_no, :points)



#   json.cars do
#     json.array! current_user.cars do |car|
#       json.model car.model
#       json.color car.color
#       json.number car.number
#     end
#   end