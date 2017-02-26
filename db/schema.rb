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

ActiveRecord::Schema.define(version: 20170224174654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "addressable_type", null: false
    t.integer  "addressable_id",   null: false
    t.integer  "country_id",       null: false
    t.string   "first_name",       null: false
    t.string   "last_name",        null: false
    t.string   "street",           null: false
    t.string   "city",             null: false
    t.string   "zip",              null: false
    t.string   "phone",            null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree
    t.index ["country_id"], name: "index_addresses_on_country_id", using: :btree
  end

  create_table "authors", force: :cascade do |t|
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authorships", force: :cascade do |t|
    t.integer  "book_id",    null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_authorships_on_author_id", using: :btree
    t.index ["book_id"], name: "index_authorships_on_book_id", using: :btree
  end

  create_table "books", force: :cascade do |t|
    t.string   "title",                                                 null: false
    t.text     "description",                              default: ""
    t.decimal  "price",            precision: 8, scale: 2,              null: false
    t.integer  "publication_year"
    t.string   "materials"
    t.float    "height"
    t.float    "width"
    t.float    "depth"
    t.integer  "category_id"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.index ["category_id"], name: "index_books_on_category_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "code",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_countries_on_name", unique: true, using: :btree
  end

  create_table "coupons", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "code",       null: false
    t.float    "discount",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_coupons_on_order_id", using: :btree
  end

  create_table "covers", force: :cascade do |t|
    t.integer  "book_id",    null: false
    t.string   "file",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_covers_on_book_id", using: :btree
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "number",          null: false
    t.string   "name",            null: false
    t.date     "expiration_date", null: false
    t.integer  "cvv",             null: false
    t.integer  "order_id",        null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["order_id"], name: "index_credit_cards_on_order_id", using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "quantity",   default: 1, null: false
    t.integer  "book_id",                null: false
    t.integer  "order_id",               null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["book_id"], name: "index_order_items_on_book_id", using: :btree
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "state",      null: false
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "autogenerated_password", default: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_admin",               default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "authorships", "authors"
  add_foreign_key "authorships", "books"
  add_foreign_key "books", "categories"
  add_foreign_key "coupons", "orders"
  add_foreign_key "covers", "books"
  add_foreign_key "credit_cards", "orders"
  add_foreign_key "orders", "users"
end
