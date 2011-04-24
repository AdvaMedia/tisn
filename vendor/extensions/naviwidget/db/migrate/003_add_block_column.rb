class AddBlockColumn < ActiveRecord::Migration
  def self.up
    add_column :navinodes, :pageblock_id, :integer
  end

  def self.down
    delete_column :navinodes, :pageblock_id
  end
end