json.extract!(@current_user, :first_name, :last_name, :email, :gender, :phone, :rate, :raters_no, :points)
json.profile_pic "#{@current_user.profile_pic.url}"

#   json.cars do
#     json.array! current_user.cars do |car|
#       json.model car.model
#       json.color car.color
#       json.number car.number
#     end
#   end