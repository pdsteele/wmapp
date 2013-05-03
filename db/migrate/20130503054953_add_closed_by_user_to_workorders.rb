class AddClosedByUserToWorkorders < ActiveRecord::Migration
  def change
    add_column :workorders, :closed_by_user, :boolean
  end

  def up
    change_column :closed_by_user, :boolean, :default => false
  end

  def down
    change_column :closed_by_user, :boolean, :default => nil
  end

end
