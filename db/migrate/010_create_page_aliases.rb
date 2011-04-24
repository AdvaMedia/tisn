# To change this template, choose Tools | Templates
# and open the template in the editor.

class CreatePageAliases < ActiveRecord::Migration
  def self.up
    create_table :pagealiases, :force=>true do |t|
      t.column    :page_id, :integer
      t.column    :url, :string
    end
  end

  def self.down
  drop_table :pagealiases
  end
end
