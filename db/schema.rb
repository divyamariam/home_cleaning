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

ActiveRecord::Schema.define(version: 20140417113332) do

  create_table "areas", force: true do |t|
    t.string   "areacode"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.text     "description"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "contact_info"
    t.string   "additional_info"
    t.integer  "pay_scale"
    t.string   "comments"
    t.string   "customer_feedback"
    t.string   "working_hours"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "password"
    t.integer  "position",          default: 0
  end

  create_table "event_series", force: true do |t|
    t.integer  "frequency",     default: 1
    t.string   "period",        default: "monthly"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "area_code"
    t.integer  "team_lead"
    t.integer  "employee_name"
    t.text     "home_details"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "event_series_id"
    t.string   "area_code"
    t.integer  "team_lead"
    t.integer  "employee_name"
    t.text     "home_details"
  end

  add_index "events", ["event_series_id"], name: "index_events_on_event_series_id", using: :btree

  create_table "team_members", force: true do |t|
    t.integer  "team_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "team_name"
    t.integer  "team_lead",  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "theme"
  end

  create_table "themes", force: true do |t|
    t.string   "name"
    t.string   "theme"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
