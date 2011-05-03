class AddMailField < ActiveRecord::Migration
  def self.up
    [:questions, :complaints].each do |tbl|
      add_column tbl, :mailme, :boolean, :default=>false
    end
  end
  
  def self.down
    [:questions, :complaints].each do |tbl|
      remove_column tbl, :mailme
    end    
  end
end