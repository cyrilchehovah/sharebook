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

ActiveRecord::Schema.define(version: 20151112110121) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "offer_id"
    t.date     "starts_on"
    t.date     "ends_on"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "state",      default: "pending"
  end

  add_index "bookings", ["offer_id"], name: "index_bookings_on_offer_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "category"
    t.string   "author"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "read_at"
  end

  add_index "messages", ["booking_id"], name: "index_messages_on_booking_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "offers", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.boolean  "published",  default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "offers", ["book_id"], name: "index_offers_on_book_id", using: :btree
  add_index "offers", ["user_id"], name: "index_offers_on_user_id", using: :btree

  create_table "owner_to_reader_reviews", force: :cascade do |t|
    t.integer  "booking_id"
    t.integer  "reader_rating"
    t.string   "reader_comment"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "owner_to_reader_reviews", ["booking_id"], name: "index_owner_to_reader_reviews_on_booking_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "description"
    t.string   "address1"
    t.string   "address2"
    t.string   "provider"
    t.string   "uid"
    t.string   "profil_img"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bookings", "offers"
  add_foreign_key "bookings", "users"
  add_foreign_key "messages", "bookings"
  add_foreign_key "messages", "users"
  add_foreign_key "offers", "books"
  add_foreign_key "offers", "users"
  add_foreign_key "owner_to_reader_reviews", "bookings"
end
