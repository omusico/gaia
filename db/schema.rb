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

ActiveRecord::Schema.define(:version => 20130522160138) do

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.string   "name_en"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "areas", ["name"], :name => "index_areas_on_name"

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "area_id"
    t.boolean  "is_enabled"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cities", ["area_id"], :name => "index_cities_on_area_id"
  add_index "cities", ["is_enabled"], :name => "index_cities_on_is_enabled"
  add_index "cities", ["name"], :name => "index_cities_on_name", :unique => true

  create_table "city_name_aliases", :force => true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.boolean  "is_enabled"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "city_name_aliases", ["city_id", "name"], :name => "index_city_name_aliases_on_city_id_and_name", :unique => true
  add_index "city_name_aliases", ["city_id"], :name => "index_city_name_aliases_on_city_id"
  add_index "city_name_aliases", ["is_enabled"], :name => "index_city_name_aliases_on_is_enabled"

  create_table "dist_name_aliases", :force => true do |t|
    t.string   "name"
    t.integer  "dist_id"
    t.boolean  "is_enabled"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "dist_name_aliases", ["dist_id", "name"], :name => "index_dist_name_aliases_on_dist_id_and_name", :unique => true
  add_index "dist_name_aliases", ["dist_id"], :name => "index_dist_name_aliases_on_dist_id"
  add_index "dist_name_aliases", ["is_enabled"], :name => "index_dist_name_aliases_on_is_enabled"

  create_table "dists", :force => true do |t|
    t.integer  "city_id"
    t.integer  "area_id"
    t.string   "name"
    t.integer  "zipcode"
    t.boolean  "is_enabled"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "dists", ["area_id"], :name => "index_dists_on_area_id"
  add_index "dists", ["city_id"], :name => "index_dists_on_city_id"
  add_index "dists", ["is_enabled"], :name => "index_dists_on_is_enabled"
  add_index "dists", ["name", "city_id"], :name => "index_dists_on_name_and_city_id", :unique => true
  add_index "dists", ["zipcode"], :name => "index_dists_on_zipcode"

end
