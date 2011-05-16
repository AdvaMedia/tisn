class CreateCampaignsExtensionTables < ActiveRecord::Migration
  def self.up
    create_table :campaigns, :force => true do |t|
      t.string      :name
      t.text        :content
      t.integer     :map_address_id   
      t.datetime    :date_on
      t.datetime    :date_off      
      t.timestamps
    end
  end

  def self.down
    drop_table :campaigns

  end
end