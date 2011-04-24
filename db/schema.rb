# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 13) do

  create_table "assets", :force => true do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 25
    t.string   "type",              :limit => 25
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["assetable_id", "assetable_type", "type"], :name => "ndx_type_assetable"
  add_index "assets", ["assetable_id", "assetable_type"], :name => "fk_assets"
  add_index "assets", ["user_id"], :name => "fk_user"

  create_table "confgroups", :force => true do |t|
    t.string "name"
    t.string "description"
  end

  create_table "confitems", :force => true do |t|
    t.integer "confgroup_id"
    t.string  "ckey"
    t.text    "cvalue"
    t.string  "description"
  end

  create_table "extension_meta", :force => true do |t|
    t.string  "name"
    t.integer "schema_version", :default => 0
    t.boolean "enabled",        :default => true
  end

  create_table "html_blocks", :force => true do |t|
    t.integer  "pageblock_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menublocks", :force => true do |t|
    t.integer "pageblock_id"
    t.integer "menu_id"
  end

  create_table "menutemplates", :force => true do |t|
    t.integer  "navigate_id"
    t.integer  "level"
    t.text     "template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "navigates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.boolean  "enabled"
  end

  create_table "navinodes", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "navigate_id"
    t.string   "link_url"
    t.integer  "page_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_num",    :default => 0
    t.integer  "pageblock_id"
    t.text     "description"
    t.boolean  "enabled"
    t.boolean  "aexpanded"
  end

  create_table "pagealiases", :force => true do |t|
    t.integer "page_id"
    t.string  "url"
  end

  create_table "pageblocks", :force => true do |t|
    t.string  "region_name"
    t.string  "blocktype"
    t.string  "css_prefix"
    t.text    "css_text"
    t.integer "weight",      :default => 0
    t.text    "description"
    t.string  "title"
    t.boolean "filter_type", :default => true
    t.text    "filter"
    t.text    "template"
  end

  create_table "pageblocks_pages", :id => false, :force => true do |t|
    t.integer "page_id"
    t.integer "pageblock_id"
  end

  create_table "pageblocks_tabgroups", :id => false, :force => true do |t|
    t.integer "pageblock_id"
    t.integer "tabgroup_id"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "segment"
    t.string   "keywords"
    t.string   "full_url"
    t.string   "description"
    t.string   "template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "self_title"
    t.integer  "order_num",   :default => 0
    t.string   "contenttype", :default => "html"
  end

  create_table "pages_tabgroups", :id => false, :force => true do |t|
    t.integer "page_id"
    t.integer "tabgroup_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "tabgroups", :force => true do |t|
    t.string "name",     :null => false
    t.text   "template"
  end

  create_table "tabitems", :force => true do |t|
    t.integer  "tabgroup_id"
    t.string   "image_url"
    t.string   "tag"
    t.string   "name"
    t.text     "content"
    t.integer  "level"
    t.boolean  "active"
    t.boolean  "enable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "testtables", :force => true do |t|
    t.string "testcol"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "crypted_password",          :limit => 40
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "plain"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
