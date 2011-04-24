# To change this template, choose Tools | Templates
# and open the template in the editor.

class AddPageTypeColumn < ActiveRecord::Migration
  def self.up
    add_column :pages, :contenttype, :string, :default=>"html"
  end

  def self.down
    remove_column :contenttype, :type
  end
end
