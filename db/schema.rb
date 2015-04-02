# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150402222454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "restaurants", force: true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "source_name"
    t.string   "source_url"
    t.string   "logo_url"
    t.string   "yelp_url"
    t.integer  "delivery_hours_start"
    t.integer  "delivery_hours_end"
    t.integer  "redis_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "interval_rank"
  end

  create_table "tags", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "restaurant_id"
  end

  create_table "yelp_infos", force: true do |t|
    t.float    "rating"
    t.string   "rating_image_url"
    t.integer  "review_count"
    t.string   "snippet_text"
    t.string   "snippet_image_url"
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
