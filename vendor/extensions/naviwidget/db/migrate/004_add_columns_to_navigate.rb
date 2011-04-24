# To change this template, choose Tools | Templates
# and open the template in the editor.

class AddColumnsToNavigate < ActiveRecord::Migration
  def self.up
    add_column :navigates, :description, :text
    add_column :navigates, :enabled, :boolean
  end

  def self.down
    delete_column :navigates, :description
    delete_column :navigates, :enabled
  end
end
