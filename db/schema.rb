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

ActiveRecord::Schema[7.1].define(version: 2024_06_05_044540) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.bigint "menu_section_id", null: false
    t.string "name"
    t.string "description"
    t.integer "price"
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_section_id"], name: "index_menu_items_on_menu_section_id"
  end

  create_table "menu_sections", force: :cascade do |t|
    t.bigint "menu_id", null: false
    t.string "name"
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_menu_sections_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.bigint "business_id", null: false
    t.string "name", null: false
    t.boolean "published", default: false, null: false
    t.boolean "demo", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "locale"
    t.index ["business_id"], name: "index_menus_on_business_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "business_id"
    t.string "stripe_subscription_id", null: false
    t.string "stripe_checkout_session_id"
    t.datetime "expired_at", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_subscriptions_on_business_id"
    t.index ["stripe_checkout_session_id"], name: "index_subscriptions_on_stripe_checkout_session_id", unique: true
    t.index ["stripe_subscription_id"], name: "index_subscriptions_on_stripe_subscription_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at"
    t.string "unlock_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "businesses", "users"
  add_foreign_key "menu_items", "menu_sections"
  add_foreign_key "menu_sections", "menus"
  add_foreign_key "menus", "businesses"
  add_foreign_key "subscriptions", "businesses"
end
