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

ActiveRecord::Schema.define(version: 2021_05_10_213616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: :cascade do |t|
    t.string "name"
    t.string "text"
    t.string "challenge_type"
    t.string "helpers"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "champions", force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.string "title"
    t.string "tags"
    t.string "stats"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "created_challenges", force: :cascade do |t|
    t.bigint "summoner_id", null: false
    t.bigint "challenge_id", null: false
    t.boolean "attempted"
    t.bigint "game_id"
    t.integer "map_id"
    t.string "participants_json"
    t.string "match_json"
    t.string "timeline_json"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "platform_id"
    t.string "challenge_status"
    t.boolean "challenge_succeeded"
    t.bigint "champion_id"
    t.bigint "item_id"
    t.index ["challenge_id"], name: "index_created_challenges_on_challenge_id"
    t.index ["champion_id"], name: "index_created_challenges_on_champion_id"
    t.index ["item_id"], name: "index_created_challenges_on_item_id"
    t.index ["summoner_id"], name: "index_created_challenges_on_summoner_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.string "maps"
    t.string "tags"
    t.boolean "mythic"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "summoner_spells", force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "summoners", force: :cascade do |t|
    t.string "summoner_id"
    t.string "account_id"
    t.string "puuid"
    t.string "name"
    t.integer "profile_icon_id"
    t.integer "summoner_level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "created_challenges", "challenges"
  add_foreign_key "created_challenges", "champions"
  add_foreign_key "created_challenges", "items"
  add_foreign_key "created_challenges", "summoners"
end
