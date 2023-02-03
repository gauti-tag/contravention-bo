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

ActiveRecord::Schema.define(version: 2023_02_03_115310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_abilities", force: :cascade do |t|
    t.string "title", limit: 120, null: false
    t.string "slug"
    t.string "controller_name", limit: 120, default: ""
    t.string "action_name", limit: 120, default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tag", default: 0
    t.index ["slug"], name: "index_admin_abilities_on_slug", unique: true
  end

  create_table "admin_profiles", force: :cascade do |t|
    t.string "title", limit: 120, null: false
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "author_id"
    t.index ["slug"], name: "index_admin_profiles_on_slug", unique: true
  end

  create_table "agents", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "grade"
    t.string "identifier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "author_id"
    t.string "region"
    t.index ["identifier"], name: "index_agents_on_identifier", unique: true
  end

  create_table "audit_logs", force: :cascade do |t|
    t.string "user_ip", limit: 30
    t.text "description"
    t.string "module_title"
    t.integer "tag", default: 0
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "identifier"
    t.index ["identifier"], name: "index_audit_logs_on_identifier", unique: true
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

  create_table "contravention_groups", force: :cascade do |t|
    t.string "code", limit: 120, null: false
    t.string "label"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "author_id"
    t.index ["code"], name: "index_contravention_groups_on_code", unique: true
  end

  create_table "contravention_notebooks", force: :cascade do |t|
    t.string "number", limit: 120, null: false
    t.string "label"
    t.integer "sheets", default: 1
    t.bigint "contravention_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "author_id"
    t.index ["contravention_group_id"], name: "index_contravention_notebooks_on_contravention_group_id"
    t.index ["number"], name: "index_contravention_notebooks_on_number"
  end

  create_table "contravention_types", force: :cascade do |t|
    t.string "code", limit: 120, null: false
    t.string "label"
    t.bigint "contravention_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "author_id"
    t.float "amount"
    t.integer "status", default: 1
    t.index ["code"], name: "index_contravention_types_on_code", unique: true
    t.index ["contravention_group_id"], name: "index_contravention_types_on_contravention_group_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "parameters", force: :cascade do |t|
    t.string "name", limit: 120, null: false
    t.text "value", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug", limit: 50
    t.index ["slug"], name: "index_parameters_on_slug", unique: true
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
    t.integer "account_status", default: 0
    t.integer "author_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admin_profiles", "users", column: "author_id"
  add_foreign_key "agents", "users", column: "author_id"
  add_foreign_key "audit_logs", "users"
  add_foreign_key "contravention_groups", "users", column: "author_id"
  add_foreign_key "contravention_notebooks", "contravention_groups"
  add_foreign_key "contravention_notebooks", "users", column: "author_id"
  add_foreign_key "contravention_types", "contravention_groups"
  add_foreign_key "contravention_types", "users", column: "author_id"
  add_foreign_key "profile_abilities", "admin_abilities"
  add_foreign_key "profile_abilities", "admin_profiles"
  add_foreign_key "users", "admin_profiles", column: "profile_id"
  add_foreign_key "users", "users", column: "author_id"
end
