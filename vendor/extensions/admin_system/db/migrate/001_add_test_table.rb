class AddTestTable < ActiveRecord::Migration
  def self.up
    create_table :testtables, :force=>true do |t|
      t.column  :testcol, :string
    end
  end

  def self.down
    drop_table :testtables
  end
end