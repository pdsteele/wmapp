class CreateWorklogs < ActiveRecord::Migration
  def change
    create_table :worklogs do |t|
      t.string :state
      t.string :description
      t.boolean :fac_man_only
      t.string :name
      t.integer :workorder_id

      t.timestamps
    end
  end
end
