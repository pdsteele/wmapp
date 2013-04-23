class AddWorkerToLogs < ActiveRecord::Migration
  def change
    add_column :worklogs, :worker_id, :integer
  end
end
