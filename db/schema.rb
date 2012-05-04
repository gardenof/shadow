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

ActiveRecord::Schema.define(:version => 20120504014854) do

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perception"
    t.string   "surprise"
    t.integer  "current_karma"
    t.integer  "lifetime_karma"
    t.integer  "current_cash"
    t.string   "play_style"
    t.integer  "game_setting_id"
    t.boolean  "commlink_status"
  end

  create_table "game_assets", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount"
    t.boolean  "equipped"
    t.string   "legality"
  end

  create_table "game_expenses", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pay_cycle"
  end

  create_table "game_settings", :force => true do |t|
    t.string "name"
    t.string "in_world_geography"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
