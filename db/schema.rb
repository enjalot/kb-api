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

ActiveRecord::Schema.define(version: 20150711010206) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "event_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "legacy_id"
    t.integer  "event_type_id"
    t.integer  "year"
    t.date     "date"
    t.geometry "lonlat",        limit: {:srid=>0, :type=>"point"}
  end

  add_index "events", ["event_type_id"], name: "index_events_on_event_type_id", using: :btree
  add_index "events", ["legacy_id"], name: "index_events_on_legacy_id", unique: true, using: :btree

  create_table "landmark_types", force: :cascade do |t|
    t.string "name"
  end

  add_index "landmark_types", ["name"], name: "index_landmark_types_on_name", unique: true, using: :btree

  create_table "landmarks", force: :cascade do |t|
    t.string   "name"
    t.integer  "landmark_type_id"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.geometry "lonlat",           limit: {:srid=>0, :type=>"point"}
  end

  create_table "occupations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "occupations", ["name"], name: "index_occupations_on_name", unique: true, using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "family_name"
    t.string   "given_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "sex"
    t.integer  "birth_year"
    t.integer  "death_year"
    t.string   "legacy_id"
    t.boolean  "birth_est"
    t.boolean  "death_est"
  end

  add_index "people", ["legacy_id"], name: "index_people_on_legacy_id", unique: true, using: :btree

  create_table "person_events", force: :cascade do |t|
    t.integer "person_id"
    t.integer "event_id"
  end

  add_index "person_events", ["event_id", "person_id"], name: "index_person_events_on_event_id_and_person_id", using: :btree
  add_index "person_events", ["person_id", "event_id"], name: "index_person_events_on_person_id_and_event_id", using: :btree

  create_table "person_occupations", force: :cascade do |t|
    t.integer "occupation_id"
    t.integer "person_id"
  end

  add_index "person_occupations", ["occupation_id", "person_id"], name: "index_person_occupations_on_occupation_id_and_person_id", using: :btree
  add_index "person_occupations", ["person_id", "occupation_id"], name: "index_person_occupations_on_person_id_and_occupation_id", using: :btree

  create_table "photographs", force: :cascade do |t|
    t.string   "slug"
    t.geometry "lonlat",     limit: {:srid=>0, :type=>"point"}
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "relations", force: :cascade do |t|
    t.integer "source_id", null: false
    t.integer "target_id", null: false
  end

  add_index "relations", ["source_id", "target_id"], name: "index_relations_on_source_id_and_target_id", using: :btree
  add_index "relations", ["target_id", "source_id"], name: "index_relations_on_target_id_and_source_id", using: :btree

  add_foreign_key "events", "event_types"
  add_foreign_key "landmarks", "landmark_types"
  add_foreign_key "person_events", "events"
  add_foreign_key "person_events", "people"
  add_foreign_key "person_occupations", "occupations"
  add_foreign_key "person_occupations", "people"
  add_foreign_key "relations", "people", column: "source_id"
  add_foreign_key "relations", "people", column: "target_id"
end
