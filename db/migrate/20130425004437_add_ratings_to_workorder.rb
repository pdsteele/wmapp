class AddRatingsToWorkorder < ActiveRecord::Migration
  def change
    add_column :workorders, :rating, :integer
  end
end
