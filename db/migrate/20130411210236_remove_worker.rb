class RemoveWorker < ActiveRecord::Migration
  def change
    remove_column :workorders, :worker
end
end
