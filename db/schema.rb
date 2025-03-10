# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_01_040620) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "circles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "following_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["following_id"], name: "index_circles_on_following_id"
    t.index ["user_id", "following_id"], name: "index_circles_on_user_id_and_following_id", unique: true
    t.index ["user_id"], name: "index_circles_on_user_id"
  end

  create_table "sleep_histories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "clock_in"
    t.datetime "clock_out"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "clock_in", "duration"], name: "index_sleep_histories_on_user_id_and_clock_in_and_duration"
    t.index ["user_id", "created_at"], name: "index_sleep_histories_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_sleep_histories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "circles", "users"
  add_foreign_key "circles", "users", column: "following_id"
  add_foreign_key "sleep_histories", "users"
end
