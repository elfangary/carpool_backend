json.extract!(notification, :id, :body, :hh_stop_point_id, :read, :user_id, :created_at, :updated_at)
json.user_first_name notification.user.first_name
json.user_last_name notification.user.last_name
json.stop_point_name notification.hh_stop_point.stop_point.location.name
# json.trip notification.hh_stop_point.stop_point.trip
if(notification.body.split(' ')[0] == "You")
  json.type "driving"
else
  json.type "hitch-hiking"
end
