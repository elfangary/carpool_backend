json.array! @trips do |trip|
  json.extract!( trip, :id, :car_id, :driver_id, :day, :all_seats, :specific_gender, :smooking )
end
