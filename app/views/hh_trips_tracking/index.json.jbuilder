json.array! @trips do |trip|
  json.extract!(trip, :day, :status, :id)
  json.driver trip.driver, :first_name, :last_name, :phone, :profile_pic, :rate

  json.stop_points trip.stop_points do |stop_point|
    json.extract!(stop_point, :start_time, :end_time)
    json.location stop_point.location.name
    json.hh stop_point.hh_stop_points do |hh|
      if hh.hh_id == @current_user.id
        json.extract!(hh, :booked_seats, :confirm)
      end
    end
  end
end