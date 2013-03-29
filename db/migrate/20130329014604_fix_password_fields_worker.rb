class FixPasswordFieldsWorker < ActiveRecord::Migration
  def change
    remove_column :workers, :crypted_password
    add_column :workers, :crypted_password, :string, :default => "", :null => false
  end
end
