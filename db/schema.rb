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

ActiveRecord::Schema.define(version: 2019_11_29_213837) do

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "cuit", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "iva_condition_id"
    t.index ["iva_condition_id"], name: "index_clients_on_iva_condition_id"
    t.index ["name"], name: "index_clients_on_name", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.integer "product_id", null: false
    t.float "price"
    t.string "saleable_type"
    t.integer "saleable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_items_on_product_id"
    t.index ["saleable_type", "saleable_id"], name: "index_items_on_saleable_type_and_saleable_id"
  end

  create_table "iva_conditions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_iva_conditions_on_name"
  end

  create_table "phones", force: :cascade do |t|
    t.integer "number", null: false
    t.integer "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_phones_on_client_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "code", null: false
    t.string "description", null: false
    t.text "detail", null: false
    t.float "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_products_on_code"
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "client_id"
    t.integer "sale_id"
    t.index ["client_id"], name: "index_reservations_on_client_id"
    t.index ["sale_id"], name: "index_reservations_on_sale_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_sales_on_client_id"
    t.index ["user_id"], name: "index_sales_on_user_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.string "token", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "password", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "clients", "iva_conditions"
  add_foreign_key "items", "products"
  add_foreign_key "phones", "clients"
  add_foreign_key "reservations", "clients"
  add_foreign_key "reservations", "sales"
  add_foreign_key "reservations", "users"
  add_foreign_key "sales", "clients"
  add_foreign_key "sales", "users"
  add_foreign_key "tokens", "users"
end
