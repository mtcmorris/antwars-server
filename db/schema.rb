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

ActiveRecord::Schema.define(:version => 20120112235736) do

  create_table "bots", :force => true do |t|
    t.string   "player_name"
    t.string   "bot_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source_file_name"
    t.string   "source_content_type"
    t.integer  "source_file_size"
    t.datetime "source_updated_at"
  end

  create_table "matches", :force => true do |t|
    t.integer  "bot_1_id"
    t.integer  "bot_2_id"
    t.string   "status"
    t.integer  "winner_id"
    t.text     "replay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
