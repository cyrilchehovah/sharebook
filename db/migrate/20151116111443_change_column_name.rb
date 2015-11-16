class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :books, :isbn, :isbn_10
  end
end
