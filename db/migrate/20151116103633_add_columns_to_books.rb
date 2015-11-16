class AddColumnsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :publisher, :string
    add_column :books, :pages_number, :integer
    add_column :books, :subtitle, :string
    add_column :books, :isbn, :integer
  end
end
