class CreatePagedBlocksTables < ActiveRecord::Migration
  def self.up
    #таблица групп вкладок
    create_table :tabgroups, :force=>true do |t|
      t.string    :name, :null => false #имя категории (русский вариант)
      t.text      :template #Шаблон отображения (и для вкладок и для контента)
    end

    #таблица вкладок
    create_table :tabitems, :force=>true do |t|
      t.integer   :tabgroup_id   #идентификатор группы
      t.string    :image_url    #URL изображения
      t.string    :tag          #тэг для перехода или сегмента URl
      t.string    :name         #Наименование (может быть для разного)
      t.text      :content      #Контент (будет использоваться CKEditor)
      t.integer   :level        #Вес пунккта
      t.boolean   :active       #Если да, то показывается по-умолчанию
      t.boolean   :enable       #Показывать ли?
      t.timestamps    #Дата и время добавления_изменения вкладки
    end

    create_table :pages_tabgroups, :id=>false, :force=>true do |t|
      t.integer   :page_id
      t.integer   :tabgroup_id
    end

    create_table :pageblocks_tabgroups, :id=>false, :force=>true do |t|
      t.integer :pageblock_id
      t.integer :tabgroup_id
    end
  end

  def self.down
    drop_table :pageblocks_tabgroups, :force=>true
    drop_table :pages_tabgroups, :force=>true
    drop_table :tabitems, :force=>true
    drop_table :tabgroups, :force=>true
  end
end