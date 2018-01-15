json.array! @trips do |trip|
  json.extract!(trip, :all_seats, :day, :status, :id)
  json.driver trip.driver, :first_name, :last_name, :phone, :profile_pic, :rate
  byebug
  json.car trip.car, :model, :color, :number

  start = false
  booked = 0
  pending = 0
  json.stop_points trip.stop_points do |stop_point|
    json.extract!(stop_point, :location_id, :start_time, :end_time)
    json.location stop_point.location.name
    pending += stop_point.hh_stop_points.length
    json.hh stop_point.hh_stop_points do |hh|
      json.extract!(hh, :id, :hh_id, :booked_seats, :confirm, :stop_point_id)
      json.name "#{hh.hh.first_name} #{hh.hh.last_name}"
      json.profile_pic hh.hh.profile_pic.url
      json.phone hh.hh.phone
      json.rate hh.hh.rate
      json.email hh.hh.email
      json.hh_id hh.hh.id
      start ||= (hh.confirm == 'accepted')
      booked += hh.booked_seats
    end
  end

  json.start start
  json.booked booked
  json.pending pending
end