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

ActiveRecord::Schema.define(version: 20160709235653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer  "{:polymorphic=>true, :index=>true}_id"
    t.string   "type"
    t.index ["{:polymorphic=>true, :index=>true}_id"], name: "index_attachments_on_{:polymorphic=>true, :index=>true}_id", using: :btree
  end

  create_table "blocks", force: :cascade do |t|
    t.string   "name"
    t.text     "about"
    t.integer  "website_id"
    t.string   "block_type"
    t.string   "position"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["website_id"], name: "index_blocks_on_website_id", using: :btree
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

  create_table "page_blocks", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "block_id"
    t.string   "location"
    t.string   "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_page_blocks_on_block_id", using: :btree
    t.index ["page_id"], name: "index_page_blocks_on_page_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name"
    t.text     "about"
    t.integer  "website_id"
    t.string   "position"
    t.integer  "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.index ["name"], name: "index_pages_on_name", using: :btree
    t.index ["page_id"], name: "index_pages_on_page_id", using: :btree
    t.index ["slug"], name: "index_pages_on_slug", unique: true, using: :btree
    t.index ["website_id"], name: "index_pages_on_website_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "role"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_users_on_account_id", using: :btree
  end

  create_table "websites", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "name"
    t.text     "about"
    t.string   "domain_url"
    t.string   "google_analytics"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "tags"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "theme"
    t.index ["account_id"], name: "index_websites_on_account_id", using: :btree
    t.index ["domain_url"], name: "index_websites_on_domain_url", using: :btree
    t.index ["name"], name: "index_websites_on_name", using: :btree
    t.index ["theme"], name: "index_websites_on_theme", using: :btree
  end

  add_foreign_key "blocks", "websites"
  add_foreign_key "page_blocks", "blocks"
  add_foreign_key "page_blocks", "pages"
  add_foreign_key "pages", "pages"
  add_foreign_key "pages", "websites"
  add_foreign_key "users", "accounts"
  add_foreign_key "websites", "accounts"
end
