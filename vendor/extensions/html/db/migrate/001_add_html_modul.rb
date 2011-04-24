class AddHtmlModul < ActiveRecord::Migration
  def self.up
    create_table :html_blocks, :force=>true do |t|
      t.integer   :pageblock_id
      t.text      :content
      t.timestamps
    end
  end

  def self.down
    drop_table :html_blocks
  end
end
