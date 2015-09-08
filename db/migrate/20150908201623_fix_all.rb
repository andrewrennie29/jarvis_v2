class FixAll < ActiveRecord::Migration
  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "details"
    t.integer  "todo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["todo_id"], name: "index_comments_on_todo_id", using: :btree

  create_table "followups", force: true do |t|
    t.boolean  "complete",   default: false
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followups", ["comment_id"], name: "index_followups_on_comment_id", using: :btree

  create_table "projects", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "isactive",    default: true
    t.string   "slug"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "recurs", force: true do |t|
    t.boolean  "recurs",     default: false
    t.string   "frequency"
    t.string   "daypattern"
    t.date     "latestdate"
    t.date     "nextdate"
    t.date     "enddate"
    t.integer  "todo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recurs", ["todo_id"], name: "index_recurs_on_todo_id", using: :btree

  create_table "statuses", force: true do |t|
    t.boolean  "notstarted", default: true
    t.boolean  "inprogress", default: false
    t.boolean  "forreview",  default: false
    t.boolean  "delayed",    default: false
    t.boolean  "complete",   default: false
    t.integer  "todo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statuses", ["todo_id"], name: "index_statuses_on_todo_id", using: :btree

  create_table "todos", force: true do |t|
    t.text     "name"
    t.text     "details"
    t.date     "duedate"
    t.date     "assigneddate"
    t.integer  "importance"
    t.integer  "points"
    t.integer  "category_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "todos", ["category_id"], name: "index_todos_on_category_id", using: :btree
  add_index "todos", ["project_id"], name: "index_todos_on_project_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.text     "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
