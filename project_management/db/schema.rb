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

ActiveRecord::Schema.define(version: 2018_07_20_103205) do

  create_table "clients_projects", id: false, force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "project_id", null: false
    t.index ["client_id"], name: "index_clients_projects_on_client_id"
    t.index ["project_id"], name: "index_clients_projects_on_project_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "commenter"
    t.text "body"
    t.integer "ticket_id"
    t.integer "user_id"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["ticket_id"], name: "index_comments_on_ticket_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "employee_roles", id: false, force: :cascade do |t|
    t.integer "employee_id", null: false
    t.integer "role_id", null: false
    t.index ["employee_id"], name: "index_employee_roles_on_employee_id"
    t.index ["role_id"], name: "index_employee_roles_on_role_id"
  end

  create_table "project_workers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_workers_on_project_id"
    t.index ["role_id"], name: "index_project_workers_on_role_id"
    t.index ["user_id", "project_id", "role_id"], name: "index_project_workers_on_user_id_and_project_id_and_role_id", unique: true
    t.index ["user_id"], name: "index_project_workers_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_projects_on_client_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "attachment"
    t.integer "owner_id"
    t.integer "dev_id"
    t.integer "tester_id"
    t.integer "task_id"
    t.string "status"
    t.string "priority"
    t.datetime "created_at", null: false
    t.datetime "completed_at"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "updated_at", null: false
    t.index ["dev_id"], name: "index_tickets_on_dev_id"
    t.index ["owner_id"], name: "index_tickets_on_owner_id"
    t.index ["task_id"], name: "index_tickets_on_task_id"
    t.index ["tester_id"], name: "index_tickets_on_tester_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "type", default: "", null: false
    t.string "nickname", default: ""
    t.string "address", default: ""
    t.string "position", default: ""
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
