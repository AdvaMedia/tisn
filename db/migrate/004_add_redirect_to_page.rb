class AddRedirectToPage < ActiveRecord::Migration
  def self.up
    puts "Редиркект перенесен в настройки контента"
    #add_column :pages, :redirect, :string
    #add_column :pages, :status_code, :integer, :default=>301
  end

  def self.down
    #remove_column(:pages, :redirect)
    #remove_column(:pages, :status_code)
  end
end
