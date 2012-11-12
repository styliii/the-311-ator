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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121110224411) do

  create_table "datasets", :force => true do |t|
    t.integer  "unique_key"
    t.datetime "created_date"
    t.string   "complaint_type"
    t.string   "descriptor"
    t.string   "location_type"
    t.string   "incident_zip"
    t.string   "incident_address"
    t.string   "street_name"
    t.string   "cross_street_1"
    t.string   "cross_street_2"
    t.string   "city"
    t.float    "lattitude"
    t.float    "longitude"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.float    "latitude"
  end

end
