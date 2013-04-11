class CreateAssignments < ActiveRecord::Migration
  def change
    drop_table :assignments 
    drop_table :workorder_relationships   
    end
  end
