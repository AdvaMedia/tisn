class AddConfigurationTables < ActiveRecord::Migration
  def self.up
    create_table :confgroups, :force=>true do |t|
      t.column  :name, :string
      t.column  :description, :string
    end

    create_table :confitems, :force=>true do |t|
      t.column  :confgroup_id, :integer
      t.column  :ckey, :string
      t.column  :cvalue, :text
      t.column  :description, :string
    end
  end

  def self.down
    drop_table  :confitems
    drop_table  :confgroups
  end
end
