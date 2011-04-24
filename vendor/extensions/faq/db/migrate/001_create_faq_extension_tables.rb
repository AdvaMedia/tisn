class CreateFaqExtensionTables < ActiveRecord::Migration
  def self.up
    create_table :questions, :force => true do |t|
      t.integer     :position                 #позиция в списке
      t.string      :title, :null=>false      #Тема
      t.text        :content, :null=>false    #Сам вопрос
      t.string      :mail                     #Почта, если есть
      t.string      :contact                  #Контактные данные (телефон или что-нидь еще)
      t.string      :name, :null=>false       #Имя отправителя
      t.text        :answer                   #Ответ администрации
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end