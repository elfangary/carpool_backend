# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create( [
 {first_name: 'Alaa', last_name: 'Tohamy', email: 'alaatohamy4@gmail.com', phone: '0121111134', hashed_password: 'weee',gender: 'female' },
 {first_name: 'Dina', last_name: 'hamamo', email: 'dinamhamamo@gmail.com', phone: '0121222134', hashed_password: 'beeee', gender: 'female'},
  {first_name: 'ahmed', last_name: 'fangary', email: 'ahmedfangary@gmail.com', phone: '0121777134', hashed_password: 'zeeee', gender: 'male'}] )