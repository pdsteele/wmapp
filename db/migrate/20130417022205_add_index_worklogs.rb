class AddIndexWorklogs < ActiveRecord::Migration
  def change
    add_index :worklogs, [:workorder_id, :created_at]
  end
end
