json.array! @trips do |trip|
  json.extract!(trip, :day, :status, :id)
  json.driver trip.driver, :id, :first_name, :last_name, :phone, :profile_pic, :rate
  byebug
  json.car trip.car, :model, :color, :number
  byebug

  json.stop_points trip.stop_points do |stop_point|
    json.extract!(stop_point, :start_time, :end_time)
    json.location stop_point.location.name
    json.hh stop_point.hh_stop_points do |hh|
      if hh.hh_id == @current_user.id
        json.extract!(hh, :booked_seats, :confirm)
        json.request hh.stop_point.location.name
      end
    end
  end
end