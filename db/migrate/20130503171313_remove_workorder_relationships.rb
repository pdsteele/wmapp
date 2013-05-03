class RemoveWorkorderRelationships < ActiveRecord::Migration
  def self.up
    drop_table :workorder_relationships
  end

  def down
  end
end
