class CreateYandexMapsExtensionTables < ActiveRecord::Migration
  def self.up
    create_table :map_regions, :force => true do |t|
      t.string      :title, :null=>false
      t.integer     :position, :default=>0
      t.timestamps
    end
    
    create_table :map_addresses, :force => true do |t|
      t.integer     :map_region_id
      t.string      :country                  #страна
      t.string      :name, :null => false     #Наименование организации. Обязательное поле
      t.string      :federation               #субъект федерации
      t.string      :area                     #район
      t.string      :city, :null => false     #город
      t.string      :street                   #улица
      t.string      :post_index               #почтовый индекс
      t.string      :house                    #Дом, строение и т.д.
      t.string      :office                   #Офис, 
      t.string      :phones                   #Телефоны, формата +7(8452)50-05-18
      t.string      :work_times               #Время работы формата: пн-ср 09:00 -  18:00
      t.boolean     :is_primary, :default=>false #Является ли этот офис главным?
      t.integer     :position, :default => 0
      t.float       :lng, :default=>0.0
      t.float       :lat, :default=>0.0
      t.timestamps
    end
    
    create_table :office_images, :force => true do |t|
      t.integer     :map_address_id
      t.integer     :position, :default=>0
      t.string      :image
      t.string      :alt_text
      t.integer     :im_x, :default=>0
      t.integer     :im_y, :default=>0
      t.integer     :im_w, :default=>120
      t.integer     :im_h, :default=>80
      t.timestamps
    end
  end

  def self.down
    drop_table :office_images
    drop_table :map_addresses
    drop_table :map_regions

  end
end
