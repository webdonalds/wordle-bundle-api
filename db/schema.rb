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

ActiveRecord::Schema[7.0].define(version: 2022_04_13_142204) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_tokens", force: :cascade do |t|
    t.bigint "user_id"
    t.string "access_key", null: false
    t.string "refresh_key", null: false
    t.datetime "expire_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_key"], name: "index_api_tokens_on_access_key", unique: true
    t.index ["refresh_key"], name: "index_api_tokens_on_refresh_key", unique: true
    t.index ["user_id"], name: "index_api_tokens_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "type"
    t.bigint "user_id"
    t.text "raw_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_games_on_type"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "user_authentications", force: :cascade do |t|
    t.bigint "user_id"
    t.string "type", null: false
    t.string "auth_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type", "auth_id"], name: "index_user_authentications_on_type_and_auth_id", unique: true
    t.index ["user_id"], name: "index_user_authentications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "display_name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_users_on_uuid"
  end

end
