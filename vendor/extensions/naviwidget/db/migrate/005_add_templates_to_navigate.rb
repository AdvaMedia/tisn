# To change this template, choose Tools | Templates
# and open the template in the editor.

class AddTemplatesToNavigate < ActiveRecord::Migration
  def self.up
    create_table :menutemplates, :firce=>true do |t|
      t.integer     :navigate_id
      t.integer     :level
      t.text        :template
      t.timestamps
    end
  end

  def self.down
    drop_table    :menutemplates
  end
end
