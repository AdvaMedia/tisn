class AddPageTitleAndPageorders < ActiveRecord::Migration
  def self.up
    add_column :pages, :self_title, :string
    add_column :pages, :order_num, :integer, :default=>0
  end

  def self.down
    remove_column(:pages, :self_title)
    remove_column(:pages, :order_num)
  end
end
