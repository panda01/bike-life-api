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

ActiveRecord::Schema.define(version: 20141013171120) do

  create_table "parkings", force: true do |t|
    t.string   "name"
    t.boolean  "isRack"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.string   "address"
    t.integer  "racks"
    t.float    "longitude"
  end

  add_index "parkings", ["latitude"], name: "index_parkings_on_latitude"
  add_index "parkings", ["longitude"], name: "index_parkings_on_longitude"

  create_table "stores", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "boro"
    t.string   "hours"
    t.string   "website"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "storetype"
    t.string   "foursquare_name"
    t.string   "phone"
    t.string   "foursquare_id"
  end

  add_index "stores", ["foursquare_id"], name: "index_stores_on_foursquare_id", unique: true
  add_index "stores", ["latitude"], name: "index_stores_on_latitude"
  add_index "stores", ["longitude"], name: "index_stores_on_longitude"

end
