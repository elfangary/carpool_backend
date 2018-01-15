.# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
 {first_name: 'Alaa', last_name: 'Tohamy', email: 'alaatohamy4@gmail.com', phone: '0121111134', password: 'password', password_confirmation: 'password', gender: 'female'},

 {first_name: 'Dina', last_name: 'hamamo', email: 'dinamhamamo@gmail.com', phone: '0121222134', password: 'password', password_confirmation: 'password', gender: 'female'},
 {first_name: 'ahmed', last_name: 'fangary', email: 'ahmedfangary@gmail.com', phone: '0121777134', password: 'password', password_confirmation: 'password', gender: 'male'}
  ])

cars = Car.create([
  {user_id: 2, model: 'Toyota Yaris', color: 'black', number: '123456'},
  {user_id: 2, model: 'opel astra', color: 'red', number: '123466'},
  {user_id: 1, model: 'Hyundai Accent.', color: 'blue', number: '132'}
  ])

locations = Location.create([
  {name: 'carrefour maadi'},
  {name: 'Naser city'},
  {name: '6 october'}
  ])

trips = Trip.create([
  {car_id: 1, driver_id: 1, day: "2018-01-03", all_seats: 4},
  {car_id: 1, driver_id: 1, day: "2018-01-04", all_seats: 4}
  ])


stop_points = StopPoint.create([
  {start_time: '02:00', end_time: '02:30', location_id: 1, trip_id:1},
  {start_time: '04:00', end_time: '04:30', location_id: 2, trip_id:1},
  {start_time: '02:00', end_time: '02:30', location_id: 1, trip_id:2}
  ])

hh_stop_points = HhStopPoint.create([
  {hh_id: 3, booked_seats: 1, stop_point_id: 1},
  {hh_id: 2, booked_seats: 2, stop_point_id: 2}
  ])

hh_stop_points = HhStopPoint.create!([
  {hh_id: 3, booked_seats: 1, stop_point_id: 1},
  {hh_id: 2, booked_seats: 2, stop_point_id: 2}
  ])

notifications = Notification.create!([
  # Driver Notification examples(user_id = driver_id)
  {body: 'you have a new request for yor trip', user_id: 2, hh_stop_point_id: 1},
  {body: 'you have a new request for yor trip', user_id: 2, hh_stop_point_id: 2},
  # HichHicker Notification examples(user_id = HichHicker_id)
  {body: 'your request has been accepted', user_id: 1, hh_stop_point_id: 2},
  {body: 'your request has been accepted', user_id: 1, hh_stop_point_id: 2},
  {body: 'your request has been refused But you can try again', user_id: 1, hh_stop_point_id: 2},
  {body: 'your request has been refused But you can try again', user_id: 1, hh_stop_point_id: 2},
  {body: 'your request has been refused But you can try again', user_id: 1, hh_stop_point_id: 1}
  ])
