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

ActiveRecord::Schema.define(version: 2018_08_12_181902) do

  create_table "chats", force: :cascade do |t|
    t.integer "user_id"
    t.integer "room_id"
    t.integer "team_id"
    t.integer "stage_id"
    t.string "content", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stage_id"], name: "index_chats_on_stage_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
    t.integer "room_id"
    t.integer "invite_accepted", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_invitations_on_room_id"
    t.index ["team_id"], name: "index_invitations_on_team_id"
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "room_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_likes_on_room_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "room_cals", force: :cascade do |t|
    t.integer "room_id"
    t.integer "user_id"
    t.integer "team_id"
    t.integer "last_stage_level", default: 0
    t.integer "startTime"
    t.integer "endTime"
    t.integer "try", default: 0
    t.integer "is_pass", default: 0
    t.integer "mode", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_room_cals_on_room_id"
    t.index ["user_id"], name: "index_room_cals_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "title", default: ""
    t.text "content", default: ""
    t.float "difficulty", default: 0.0
    t.integer "likes", default: 0
    t.integer "clearcount", default: 0
    t.string "image"
    t.integer "user_id"
    t.integer "publish_stage_id", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "stage_cals", force: :cascade do |t|
    t.integer "room_cal_id"
    t.integer "user_id"
    t.integer "stage_id"
    t.integer "usedhint1", default: 0
    t.integer "usedhint2", default: 0
    t.integer "usedhint3", default: 0
    t.integer "useditem", default: 0
    t.integer "selection_try"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_cal_id"], name: "index_stage_cals_on_room_cal_id"
    t.index ["stage_id"], name: "index_stage_cals_on_stage_id"
    t.index ["user_id"], name: "index_stage_cals_on_user_id"
  end

  create_table "stages", force: :cascade do |t|
    t.integer "room_id"
    t.string "title", default: ""
    t.text "content", default: ""
    t.string "video"
    t.integer "try", default: 0
    t.integer "pass", default: 0
    t.string "answer", default: ""
    t.string "answer2"
    t.string "answer3"
    t.string "answer4"
    t.string "answer5"
    t.string "selection_num1"
    t.string "selection_num2"
    t.string "selection_num3"
    t.string "selection_num4"
    t.string "selection_num5"
    t.string "pattern_num1"
    t.string "pattern_num2"
    t.string "pattern_num3"
    t.string "pattern_num4"
    t.string "pattern_num5"
    t.string "hint1"
    t.string "hint2"
    t.string "hint3"
    t.integer "laststage", default: 0
    t.integer "mode", default: 0
    t.float "partial_difficulty", default: 5.0
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_stages_on_room_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "user_id"
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_teams_on_room_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "item_freehint", default: 0
    t.integer "item_2018likelion", default: 0
    t.float "rank_point", default: 0.0
    t.string "applying_award", default: ""
    t.integer "award_try", default: 0
    t.integer "award_fail", default: 0
    t.integer "award_clear", default: 0
    t.integer "award_make", default: 0
    t.integer "award_edit", default: 0
    t.integer "award_distribute", default: 0
    t.integer "award_delete", default: 0
    t.integer "award_single", default: 0
    t.integer "award_multi", default: 0
    t.integer "awardtitle_A1", default: 0
    t.integer "awardtitle_A2", default: 0
    t.integer "awardtitle_A3", default: 0
    t.integer "awardtitle_A4", default: 0
    t.integer "awardtitle_B1", default: 0
    t.integer "awardtitle_B2", default: 0
    t.integer "awardtitle_B3", default: 0
    t.integer "awardtitle_B4", default: 0
    t.integer "awardtitle_C1", default: 0
    t.integer "awardtitle_C2", default: 0
    t.integer "awardtitle_C3", default: 0
    t.integer "awardtitle_C4", default: 0
    t.integer "awardtitle_C5", default: 0
    t.integer "awardtitle_D1", default: 0
    t.integer "awardtitle_D2", default: 0
    t.integer "awardtitle_D3", default: 0
    t.integer "awardtitle_D4", default: 0
    t.integer "awardtitle_E1", default: 0
    t.integer "awardtitle_E2", default: 0
    t.integer "awardtitle_E3", default: 0
    t.integer "awardtitle_E4", default: 0
    t.integer "awardtitle_E5", default: 0
    t.integer "awardtitle_E6", default: 0
    t.integer "awardtitle_E7", default: 0
    t.integer "awardtitle_E8", default: 0
    t.integer "awardtitle_E9", default: 0
    t.integer "awardtitle_F1", default: 0
    t.integer "awardtitle_F2", default: 0
    t.integer "awardtitle_F3", default: 0
    t.integer "awardtitle_F4", default: 0
    t.integer "awardtitle_G1", default: 0
    t.integer "awardtitle_G2", default: 0
    t.integer "awardtitle_G3", default: 0
    t.integer "awardtitle_G4", default: 0
    t.integer "awardtitle_H1", default: 0
    t.integer "awardtitle_H2", default: 0
    t.integer "awardtitle_S0_1", default: 0
    t.integer "awardtitle_S0_2", default: 0
    t.integer "awardtitle_S0_3", default: 0
    t.integer "awardtitle_S0_4", default: 0
    t.integer "awardtitle_S0_5", default: 0
    t.integer "awardtitle_S0_6", default: 0
    t.integer "awardtitle_Z1", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
