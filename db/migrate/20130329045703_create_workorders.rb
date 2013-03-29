class CreateWorkorders < ActiveRecord::Migration
  def change
    create_table :workorders do |t|
      t.string :description
      t.string :building
      t.string :room
      t.string :worker
      t.string :state

      t.timestamps
    end
    add_index :workorders, [:user_id, :created_at]
  end
end
