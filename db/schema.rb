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

ActiveRecord::Schema.define(version: 20171029200546) do

  create_table "flags", force: :cascade do |t|
    t.integer "reporter_id"
    t.integer "infected_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["infected_id"], name: "index_flags_on_infected_id"
    t.index ["reporter_id"], name: "index_flags_on_reporter_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.integer "points"
    t.integer "survivor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survivor_id"], name: "index_resources_on_survivor_id"
  end

  create_table "survivors", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "gender"
    t.string "last_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "infected", default: false
  end

end
