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

ActiveRecord::Schema.define(version: 2018_12_01_140449) do

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "category1", limit: 100, null: false
    t.integer "is_open", null: false
    t.integer "disp_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "color_code", limit: 30, null: false
    t.string "color_name", limit: 100, null: false
    t.integer "is_available", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fields", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "user_id_seq", null: false
    t.string "color_code", limit: 30, null: false
    t.string "category1", limit: 100
    t.string "category2", limit: 100
    t.integer "is_available", null: false
    t.integer "disp_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "studies_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "users_id"
    t.integer "users_id_seq"
    t.string "color_code", limit: 100
    t.string "category1", limit: 100
    t.string "category2", limit: 100
    t.text "content"
    t.integer "is_open", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "categry_id"
    t.string "category2", limit: 100, null: false
    t.string "color_code", limit: 30, null: false
    t.integer "is_open", null: false
    t.integer "disp_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "user_name", limit: 40, null: false
    t.datetime "birth", null: false
    t.string "job", limit: 100
    t.integer "is_open", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
