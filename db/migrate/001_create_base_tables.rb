class CreateBaseTables < ActiveRecord::Migration
  def self.up
    create_table :users, :force=>true do |t|
      t.column :login, :string, :unique=>true
      t.column :hashed_password, :string
      t.column :salt, :string
      t.timestamps
    end

    create_table :roles, :force=>true do |t|
      t.column :name, :string, :unique=>true
      t.column :description, :string
      t.timestamps
    end

    create_table :roles_users,:force=>true, :id=>false do |t|
      t.column :user_id, :integer
      t.column :role_id, :integer
    end

    create_table :pages, :force=>true do |t|
      t.column      :title, :string
      t.column      :segment, :string
      t.column      :keywords, :string
      t.column      :full_url, :string
      t.column      :description, :string
      t.column      :template, :string #template_folder
      t.timestamps
    end

    create_table :pageblocks, :force=>true do |t|
      t.string    :region_name
      t.string    :blocktype
      t.string    :css_prefix
      t.text      :css_text
      t.integer   :weight, :default=>0
      t.text      :description
      t.string    :title
      t.boolean   :filter_type, :default=>true  #true - include; false - exclude
      t.text      :filter
      t.text      :template
    end

    create_table :pageblocks_pages, :id => false do |t|
      t.integer     :page_id
      t.integer     :pageblock_id
    end

  end

  def self.down
    drop_table :pageblocks_pages
    drop_table :pageblocks
    drop_table :pages
    drop_table :roles_users
    drop_table :roles
    drop_table :users
  end
end
