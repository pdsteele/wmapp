class AddDormAndYearToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dorm, :string
    add_column :users, :grad_year, :integer
  end
end
