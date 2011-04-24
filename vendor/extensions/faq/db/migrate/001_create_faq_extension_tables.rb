class CreateFaqExtensionTables < ActiveRecord::Migration
  def self.up
    create_table :faqs, :force=>true do |t|
      t.string      :querist
      t.string      :querytitle
      t.text        :query
      t.text        :answer
      t.timestamps
    end
  end

  def self.down
    drop_table :faqs, :force=>true
  end
end