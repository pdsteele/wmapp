class AddTotalWorkordersCompletedToWorker < ActiveRecord::Migration
  def change
    add_column :workers, :total_workorders_completed, :integer
  end
end
