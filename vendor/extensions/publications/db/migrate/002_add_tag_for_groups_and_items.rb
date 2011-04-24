# To change this template, choose Tools | Templates
# and open the template in the editor.

class AddTagForGroupsAndItems < ActiveRecord::Migration
  def self.up
    [:publicationgroups, :publicationitems].each do |table|
      add_column  table, :tag, :string
    end
  end

  def self.down
    [:publicationgroups, :publicationitems].each do |table|
      remove_column table, :tag
    end
  end
end
