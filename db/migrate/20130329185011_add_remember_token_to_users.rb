class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_token, :string
    add_index  :users, :remember_token
    add_column :workers, :remember_token, :string
    add_index  :workers, :remember_token
  end
end
