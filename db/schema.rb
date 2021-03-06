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

ActiveRecord::Schema.define(version: 20170506235805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movie_theaters", force: :cascade do |t|
    t.string   "name",                 null: false
    t.string   "address"
    t.string   "city",                 null: false
    t.integer  "state_id",             null: false
    t.string   "zipcode",    limit: 5
    t.string   "website"
    t.integer  "user_id",              null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["state_id"], name: "index_movie_theaters_on_state_id", using: :btree
    t.index ["user_id"], name: "index_movie_theaters_on_user_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title",            null: false
    t.string   "body",             null: false
    t.integer  "movie_theater_id", null: false
    t.integer  "user_id",          null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "rating",           null: false
    t.index ["movie_theater_id", "user_id"], name: "index_reviews_on_movie_theater_id_and_user_id", unique: true, using: :btree
    t.index ["movie_theater_id"], name: "index_reviews_on_movie_theater_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",                   null: false
    t.string   "abbreviation", limit: 2, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["abbreviation"], name: "index_states_on_abbreviation", unique: true, using: :btree
    t.index ["name"], name: "index_states_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.string   "username",                               null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.datetime "deleted_at"
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "review_id",  null: false
    t.integer  "user_id",    null: false
    t.boolean  "helpful"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_votes_on_review_id", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
  end

end
