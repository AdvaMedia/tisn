class AddNavigateWidgetTables < ActiveRecord::Migration
  def self.up
    create_table :navigates, :force=>true do |t|
      t.column      :name, :string
      t.timestamps
    end

    create_table :navinodes, :force=>true do |t|
      t.column      :parent_id, :integer    # У рутовых элементов соответственно, нет
      t.column      :navigate_id, :integer  # Только у рутовых элементов (а почему... может и нет...)
      t.column      :link_url, :string      # URL                     \ Может быть только одно
      t.column      :page_id, :integer      # Либо выбранная страница / Либо URL либо назначена страница
      t.column      :name, :string          # Наименование пункта меню
      t.timestamps
    end
  end

  def self.down
    drop_table :navinodes, :force=>true
    drop_table :navigates, :force=>true
  end
end
