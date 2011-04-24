class CreatePublicationsTables < ActiveRecord::Migration
  def self.up
    create_table :publicationgroups, :force=>true do |t|
      t.string    :name
      t.timestamps
    end

    create_table :publicationitems, :force=>true do |t|
      t.integer   :publicationgroup_id
      t.string    :title
      t.text      :descriptions
      t.text      :content
      t.string    :image_url
      t.timestamps
    end

    create_table :publicationpages, :force=>true do |t|
      t.integer   :publicationgroup_id
      t.integer   :page_id
      t.text      :template_all
      t.text      :template_one
    end

    create_table :publicationblocks, :force=>true do |t|
      t.integer   :publicationgroup_id
      t.integer   :pageblock_id
      t.text      :template
    end
  end

  def self.down
  drop_table  :publicationblocks, :force=>true
  drop_table  :publicationpages, :force=>true
  drop_table  :publicationitems, :force=>true
  drop_table  :publicationgroups, :force=>true
  end
end