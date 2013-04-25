class AddReviewToWorkorder < ActiveRecord::Migration
  def change
    add_column :workorders, :review, :string
  end
end
