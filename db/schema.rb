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

ActiveRecord::Schema.define(version: 20211212070616) do

  create_table "comments", force: :cascade do |t|
    t.string "comment_content"
    t.integer "user_id"
    t.string "posted_id"
    t.string "integer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "faves", force: :cascade do |t|
    t.integer "faved_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_faves_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "res", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_res_on_post_id"
    t.index ["user_id"], name: "index_res_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "uid"
    t.string "provider"
    t.string "username"
    t.string "profile"
    t.string "activity"
    t.integer "style"
    t.integer "survivor_lank"
    t.integer "killer_lank"
    t.boolean "steam", default: false, null: false
    t.boolean "ps", default: false, null: false
    t.boolean "switch", default: false, null: false
    t.boolean "xbox", default: false, null: false
    t.string "image"
    t.boolean "discord", default: false, null: false
    t.boolean "ptvc", default: false, null: false
    t.boolean "skype", default: false, null: false
    t.boolean "novc", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
