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

ActiveRecord::Schema.define(version: 20161008220140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "account_users", force: :cascade do |t|
    t.string   "role"
    t.integer  "account_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_users_on_account_id", using: :btree
    t.index ["user_id"], name: "index_account_users_on_user_id", using: :btree
  end

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.string   "type"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "name"
    t.string   "about"
    t.string   "link"
    t.integer  "position"
    t.string   "link_text"
    t.string   "text_align"
    t.hstore   "style",              default: {}, null: false
    t.index ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type", using: :btree
    t.index ["style"], name: "attachments_style_idx", using: :gin
    t.index ["type", "attachable_id", "attachable_type"], name: "index_attachments_on_type_and_attachable_id_and_attachable_type", using: :btree
    t.index ["type"], name: "index_attachments_on_type", using: :btree
  end

  create_table "blocks", force: :cascade do |t|
    t.string   "name"
    t.text     "about"
    t.integer  "website_id"
    t.string   "block_type"
    t.string   "location"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "position"
    t.boolean  "front_page"
    t.integer  "block_id"
    t.string   "link"
    t.string   "link_text"
    t.string   "bg_color"
    t.string   "text_align"
    t.integer  "columns",     default: 3
    t.integer  "category_id"
    t.index ["block_id"], name: "index_blocks_on_block_id", using: :btree
    t.index ["category_id"], name: "index_blocks_on_category_id", using: :btree
    t.index ["website_id"], name: "index_blocks_on_website_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "about"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "website_id"
    t.string   "slug"
    t.string   "subtitle"
    t.text     "description"
    t.index ["category_id"], name: "index_categories_on_category_id", using: :btree
    t.index ["slug"], name: "categories_slug_idx", using: :btree
    t.index ["website_id"], name: "index_categories_on_website_id", using: :btree
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "position"
    t.index ["block_id"], name: "index_page_blocks_on_block_id", using: :btree
    t.index ["page_id"], name: "index_page_blocks_on_page_id", using: :btree
  end

  create_table "page_categories", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_page_categories_on_category_id", using: :btree
    t.index ["page_id"], name: "index_page_categories_on_page_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name"
    t.text     "about"
    t.integer  "website_id"
    t.integer  "page_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "slug"
    t.integer  "position"
    t.boolean  "is_published",      default: false
    t.boolean  "show_sub_menu",     default: true
    t.boolean  "show_in_menu",      default: false
    t.integer  "redirectable_id"
    t.string   "redirectable_type"
    t.string   "redirectable_url"
    t.string   "subtitle"
    t.text     "description"
    t.index ["name"], name: "index_pages_on_name", using: :btree
    t.index ["page_id"], name: "index_pages_on_page_id", using: :btree
    t.index ["redirectable_id", "redirectable_type"], name: "index_pages_on_redir_id_and_redir_type", using: :btree
    t.index ["slug"], name: "index_pages_on_slug", using: :btree
    t.index ["website_id"], name: "index_pages_on_website_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "unconfirmed_email"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "confirmation_token"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
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
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "theme"
    t.text     "css_override"
    t.text     "description"
    t.hstore   "style",            default: {},    null: false
    t.boolean  "random_hero",      default: false
    t.string   "subtitle"
    t.index ["account_id"], name: "index_websites_on_account_id", using: :btree
    t.index ["domain_url"], name: "index_websites_on_domain_url", using: :btree
    t.index ["name"], name: "index_websites_on_name", using: :btree
    t.index ["style"], name: "websites_style_idx", using: :gin
    t.index ["theme"], name: "index_websites_on_theme", using: :btree
  end

  add_foreign_key "account_users", "accounts"
  add_foreign_key "account_users", "users"
  add_foreign_key "blocks", "blocks"
  add_foreign_key "blocks", "categories"
  add_foreign_key "blocks", "websites"
  add_foreign_key "categories", "categories"
  add_foreign_key "categories", "websites"
  add_foreign_key "page_blocks", "blocks"
  add_foreign_key "page_blocks", "pages"
  add_foreign_key "page_categories", "categories"
  add_foreign_key "page_categories", "pages"
  add_foreign_key "pages", "pages"
  add_foreign_key "pages", "websites"
  add_foreign_key "websites", "accounts"
end
