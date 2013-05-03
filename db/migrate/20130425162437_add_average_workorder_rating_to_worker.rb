class AddAverageWorkorderRatingToWorker < ActiveRecord::Migration
  def change
    add_column :workers, :average_workorder_rating, :float , :precision => 10, :scale => 2
  end
end
