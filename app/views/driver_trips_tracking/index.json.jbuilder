json.array! @trips do |trip|
  json.extract!(trip, :all_seats, :day, :status, :id)
  json.driver trip.driver, :first_name, :last_name, :phone, :profile_pic, :rate

  start = false
  json.stop_points trip.stop_points do |stop_point|
    json.extract!(stop_point, :location_id, :start_time, :end_time)
    json.location stop_point.location.name
    json.hh stop_point.hh_stop_points do |hh|
      json.extract!(hh, :id, :hh_id, :booked_seats, :confirm, :stop_point_id)
      json.name "#{hh.hh.first_name} #{hh.hh.last_name}"
      json.hh_id hh.hh.id
      start ||= (hh.confirm == 'accepted')
    end
  end

  json.start start
end