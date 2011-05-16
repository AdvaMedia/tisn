class ChangeToFileColumn < ActiveRecord::Migration
  def self.up
    rename_column :publicationitems, :image_url, :image
  end
  
  def self.down
    rename_column :publicationitems, :image, :image_url
  end
end