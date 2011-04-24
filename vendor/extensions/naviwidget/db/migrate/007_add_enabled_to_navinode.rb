# To change this template, choose Tools | Templates
# and open the template in the editor.

class AddEnabledToNavinode < ActiveRecord::Migration
  def self.up
    add_column :navinodes, :description, :text
    add_column :navinodes, :enabled, :boolean
    add_column :navinodes, :aexpanded, :boolean
  end

  def self.down
    delete_column :navinodes, :description
    delete_column :navinodes, :enabled
    delete_column :navinodes, :aexpanded
  end
end
