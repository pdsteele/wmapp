class CreateWorkorderRelationships < ActiveRecord::Migration
  def change
    create_table :workorder_relationships do |t|
      t.integer :worker_id
      t.integer :workorder_id

      t.timestamps
    end
  end
end
