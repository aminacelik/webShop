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

ActiveRecord::Schema.define(version: 20141222115645) do

  create_table "addresses", force: true do |t|
    t.string   "street_name"
    t.integer  "street_number"
    t.integer  "user_id"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "details"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "shipping",      default: false
    t.boolean  "billing",       default: false
    t.boolean  "default",       default: false
  end

  add_index "addresses", ["city_id"], name: "index_addresses_on_city_id", using: :btree
  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_translations", force: true do |t|
    t.integer  "language_id"
    t.integer  "category_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_translations", ["category_id"], name: "index_category_translations_on_category_id", using: :btree
  add_index "category_translations", ["language_id"], name: "index_category_translations_on_language_id", using: :btree

  create_table "cities", force: true do |t|
    t.string   "name"
    t.string   "postal_code"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["country_id"], name: "index_cities_on_country_id", using: :btree

  create_table "colors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: true do |t|
    t.string   "name"
    t.string   "unit"
    t.decimal  "exchange_rate", precision: 8, scale: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_name"
  end

  create_table "line_items", force: true do |t|
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",           default: 1
    t.integer  "product_variant_id"
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  add_index "line_items", ["product_variant_id"], name: "index_line_items_on_product_variant_id", using: :btree

  create_table "order_addresses", force: true do |t|
    t.string  "street_name"
    t.integer "street_number"
    t.integer "user_id"
    t.integer "city_id"
    t.string  "details"
    t.string  "first_name"
    t.string  "last_name"
  end

  add_index "order_addresses", ["city_id"], name: "index_order_addresses_on_city_id", using: :btree
  add_index "order_addresses", ["user_id"], name: "index_order_addresses_on_user_id", using: :btree

  create_table "order_product_images", force: true do |t|
    t.integer  "order_product_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "order_product_images", ["order_product_id"], name: "index_order_product_images_on_order_product_id", using: :btree

  create_table "order_product_variants", force: true do |t|
    t.integer "order_product_id"
    t.integer "size_id"
    t.integer "color_id"
    t.integer "quantity"
    t.integer "order_id"
  end

  add_index "order_product_variants", ["color_id"], name: "index_order_product_variants_on_color_id", using: :btree
  add_index "order_product_variants", ["order_id"], name: "index_order_product_variants_on_order_id", using: :btree
  add_index "order_product_variants", ["order_product_id"], name: "index_order_product_variants_on_order_product_id", using: :btree
  add_index "order_product_variants", ["size_id"], name: "index_order_product_variants_on_size_id", using: :btree

  create_table "order_products", force: true do |t|
    t.string  "title"
    t.text    "description"
    t.decimal "price",       precision: 8, scale: 2
    t.integer "category_id"
  end

  add_index "order_products", ["category_id"], name: "index_order_products_on_category_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.decimal  "price",               precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "shipped",                                     default: false
    t.integer  "shipping_address_id"
    t.integer  "billing_address_id"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "product_images", force: true do |t|
    t.integer  "product_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_images", ["product_id"], name: "index_product_images_on_product_id", using: :btree

  create_table "product_translations", force: true do |t|
    t.integer "language_id"
    t.integer "product_id"
    t.string  "title"
    t.text    "description"
  end

  add_index "product_translations", ["language_id"], name: "index_product_translations_on_language_id", using: :btree
  add_index "product_translations", ["product_id"], name: "index_product_translations_on_product_id", using: :btree

  create_table "product_variants", force: true do |t|
    t.integer  "product_id"
    t.integer  "size_id"
    t.integer  "color_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_variants", ["color_id"], name: "index_product_variants_on_color_id", using: :btree
  add_index "product_variants", ["product_id"], name: "index_product_variants_on_product_id", using: :btree
  add_index "product_variants", ["size_id"], name: "index_product_variants_on_size_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",       precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.decimal  "sale_price",  precision: 8, scale: 2
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sizes", force: true do |t|
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "email"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

end
