# To change this template, choose Tools | Templates
# and open the template in the editor.

class AddMenuBlockContent < ActiveRecord::Migration
  def self.up
    create_table :menublocks, :force=>true do |t|
      t.integer   :pageblock_id
      t.integer   :menu_id
    end
  end

  def self.down
    drop_table :menublocks
  end
end
