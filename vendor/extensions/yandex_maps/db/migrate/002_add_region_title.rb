class AddRegionTitle < ActiveRecord::Migration
  def self.up
    add_column :map_regions, :tab, :string
  end
  
  def self.down
    remove_column :map_regions, :tab
  end
end