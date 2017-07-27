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

ActiveRecord::Schema.define(version: 20170726113846) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
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
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.string   "keywords"
    t.index ["slug"], name: "index_categories_on_slug", unique: true, using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.integer  "subcategory_id"
    t.string   "city"
    t.integer  "share"
    t.integer  "like"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.float    "lat"
    t.float    "lng"
    t.string   "photo"
    t.string   "address"
    t.float    "rating"
    t.string   "slug"
    t.text     "intro"
    t.text     "description"
    t.string   "url"
    t.index ["slug"], name: "index_companies_on_slug", unique: true, using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "ips", force: :cascade do |t|
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
    t.integer  "share"
    t.integer  "like"
  end

  create_table "nav_links", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.boolean  "active"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "parent_id"
    t.string   "icon"
    t.integer  "depth"
  end

  create_table "pronoun_orders", force: :cascade do |t|
    t.string   "title"
    t.integer  "max_words"
    t.integer  "min_words"
    t.text     "submitted_text"
    t.string   "keywords"
    t.string   "state"
    t.string   "description"
    t.integer  "company_id"
    t.integer  "pronun_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "sub_categories", force: :cascade do |t|
    t.text     "name"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.index ["category_id", "created_at"], name: "index_sub_categories_on_category_id_and_created_at", using: :btree
    t.index ["category_id"], name: "index_sub_categories_on_category_id", using: :btree
    t.index ["slug"], name: "index_sub_categories_on_slug", unique: true, using: :btree
  end

  add_foreign_key "sub_categories", "categories"
end
