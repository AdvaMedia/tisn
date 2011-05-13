class AddLockField < ActiveRecord::Migration
  def self.up
    add_column :publicationitems, :lock, :boolean, :default=>false
  end
  
  def self.down
    remove_column :publicationitems, :lock
  end
end