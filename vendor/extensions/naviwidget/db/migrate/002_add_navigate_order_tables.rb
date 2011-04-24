class AddNavigateOrderTables < ActiveRecord::Migration
  def self.up
    add_column :navinodes, :order_num, :integer, :default=>0
  end

  def self.down
    delete_column :navinodes, :order_num
  end
end
