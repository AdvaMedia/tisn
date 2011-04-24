# To change this template, choose Tools | Templates
# and open the template in the editor.

class AddColumnsForPartItems < ActiveRecord::Migration
  def self.up
    puts "Данная возможность была удалена программистом"
    #add_column :part_items, :extclass, :string
    #add_column :part_items, :extcss, :text
  end

  def self.down
    #remove_column(:part_items, :extclass)
    #remove_column(:part_items, :extcss)
  end
end
