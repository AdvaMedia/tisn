class AddComplaintsTable < ActiveRecord::Migration
  def self.up
    create_table :complaints, :force => true do |t|
      t.string      :number         #Номер договора
      t.datetime    :dog_created    #Дата заключения договора
      t.string      :owner          #На кого оформлен
      t.string      :contacts       #Контактные данные      
      t.text        :content        #Текст претензии
      t.timestamps
    end
  end
  
  def self.down
    drop_table :complaints
    
  end
end