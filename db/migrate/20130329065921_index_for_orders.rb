class IndexForOrders < ActiveRecord::Migration
  
  def change
    add_column :workorders, :user_id, :integer
    add_index :workorders, [:user_id, :created_at]
  end

end
