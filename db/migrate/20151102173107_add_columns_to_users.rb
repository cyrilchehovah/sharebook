class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :string
    add_column :users, :address1, :string
    add_column :users, :address2, :string
  end
end
