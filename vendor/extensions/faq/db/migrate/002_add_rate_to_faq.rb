class AddRateToFaq < ActiveRecord::Migration
  def self.up
    add_column :questions, :rate, :integer, :default=>0
    add_column :questions, :vip, :boolean, :default=>false
  end
  
  def self.down
    remove_column :questions, :vip
    remove_column :questions, :rate
    
  end
end