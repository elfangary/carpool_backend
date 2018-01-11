json.extract!(notification, :id, :body, :hh_stop_point_id, :read, :user_id, :created_at, :updated_at)
json.user_first_name notification.user.first_name
json.user_last_name notification.user.last_name
json.hh_stop_point notification.hh_stop_point
json.stop_point_name notification.hh_stop_point.stop_point.location.name
json.trip notification.hh_stop_point.stop_point.trip
