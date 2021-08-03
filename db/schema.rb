# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_03_101858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_abilities", force: :cascade do |t|
    t.string "title", limit: 120, null: false
    t.string "slug"
    t.string "controller_name", limit: 120, default: ""
    t.string "action_name", limit: 120, default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_admin_abilities_on_slug", unique: true
  end

  create_table "admin_profiles", force: :cascade do |t|
    t.string "title", limit: 120, null: false
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_admin_profiles_on_slug", unique: true
  end

  create_table "audit_logs", force: :cascade do |t|
    t.string "user_ip", limit: 30
    t.text "description"
    t.string "module_title"
    t.integer "tag", default: 0
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

  create_table "parameters", force: :cascade do |t|
    t.string "name", limit: 120, null: false
    t.text "value", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profile_abilities", force: :cascade do |t|
    t.bigint "admin_profile_id", null: false
    t.bigint "admin_ability_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admin_ability_id"], name: "index_profile_abilities_on_admin_ability_id"
    t.index ["admin_profile_id"], name: "index_profile_abilities_on_admin_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "msisdn", limit: 30
    t.string "firstname", limit: 120
    t.string "lastname", limit: 50
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "profile_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "audit_logs", "users"
  add_foreign_key "profile_abilities", "admin_abilities"
  add_foreign_key "profile_abilities", "admin_profiles"
  add_foreign_key "users", "admin_profiles", column: "profile_id"
end
