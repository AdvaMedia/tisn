class AddAuthToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :crypted_password, :string, :limit => 40
    add_column :users, :remember_token, :string, :limit => 40
    add_column :users, :remember_token_expires_at, :datetime

    add_index :users, :login, :unique => true
  end

  def self.down
    remove_column(:users, :crypted_password, :remember_token, :remember_token_expires_at)

    remove_index :users, :login
  end
end
