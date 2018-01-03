# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171230010929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.bigint "user_id"
    t.string "model", null: false
    t.string "color", null: false
    t.string "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "hh_stop_points", force: :cascade do |t|
    t.integer "booked_seats"
    t.integer "confirm"
    t.bigint "hh_id"
    t.bigint "stop_point_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hh_id"], name: "index_hh_stop_points_on_hh_id"
    t.index ["stop_point_id"], name: "index_hh_stop_points_on_stop_point_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stop_points", force: :cascade do |t|
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.bigint "trip_id"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_stop_points_on_location_id"
    t.index ["trip_id"], name: "index_stop_points_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "car_id"
    t.bigint "driver_id"
    t.date "day"
    t.integer "all_seats"
    t.string "specific_gender"
    t.boolean "smoking"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_trips_on_car_id"
    t.index ["driver_id"], name: "index_trips_on_driver_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "phone", null: false
    t.string "profile_pic"
    t.string "gender"
    t.integer "rate", default: 0
    t.integer "points", default: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "hh_stop_points", "users", column: "hh_id"
  add_foreign_key "trips", "users", column: "driver_id"
end
