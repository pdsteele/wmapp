class AddWorkerId < ActiveRecord::Migration
  def change
    add_column :workorders, :worker_id, :integer
end
end
