class AlterUserStructure < ActiveRecord::Migration
  def change
    remove_column :users, :grad_year, :integer
    add_column :users, :name, :string
    add_column :users, :phone, :string
    add_column :users, :bannerID, :string
    add_column :users, :room, :string
  end

end
