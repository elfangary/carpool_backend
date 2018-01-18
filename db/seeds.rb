# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


users = User.create!([
 {first_name: 'Alaa', last_name: 'Tohamy', email: 'alaatohamy4@gmail.com', phone: '0121111134', password: 'password', password_confirmation: 'password', gender: 'female'},
 {first_name: 'Dina', last_name: 'Hamamo', email: 'dinamhamamo@gmail.com', phone: '0121222134', password: 'password', password_confirmation: 'password', gender: 'female'},
 {first_name: 'Ahmed', last_name: 'Fangary', email: 'ahmedfangary@gmail.com', phone: '0121777134', password: 'password', password_confirmation: 'password', gender: 'male'}
  ])

cars = Car.create!([
  {user_id: 1, model: 'Toyota Yaris', color: 'Black', number: '1234'},
  {user_id: 2, model: 'Opel Astra', color: 'Red', number: '123466'},
  {user_id: 3, model: 'Hyundai Accent.', color: 'Blue', number: '132'}
  ])

locations = Location.create!([
  {name: 'Heliopolis'},
  {name: 'Nasr City'},
  {name: '6 October'},
  {name: 'Remaya'},
  {name: 'Maadi'},
  {name: 'Madinaty'},
  {name: 'Al Rehab'},
  {name: 'Giza'},
  {name: 'Duqqi'},
  {name: 'Al Haram'},
  {name: 'Mokattam'},
  {name: 'Marj'},
  {name: 'El Shorouk'}
  ])
