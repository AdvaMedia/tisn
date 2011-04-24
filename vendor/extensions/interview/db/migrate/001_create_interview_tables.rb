class CreateInterviewTables < ActiveRecord::Migration
  def self.up
    create_table :interviews, :force=>true do |t|
      t.string  :name
      t.string  :tag
      t.timestamps
    end

    create_table :interviewvariants, :force=>true do |t|
      t.integer :interview_id
      t.string  :content
      t.integer :vote, :default=>0
      t.timestamps
    end

    create_table :interviewblocks, :force=>true do |t|
      t.integer   :interview_id
      t.integer   :pageblock_id
      t.text      :template
    end
  end

  def self.down
    drop_table :interviews_pageblocks, :force=>true
    drop_table :interviewvariants, :force=>true
    drop_table :interviews, :force=>true
  end
end