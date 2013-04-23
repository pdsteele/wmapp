class SolicitedWorklogs < ActiveRecord::Migration
  def change
    add_column :worklogs, :unsolicited, :boolean
  end
end
