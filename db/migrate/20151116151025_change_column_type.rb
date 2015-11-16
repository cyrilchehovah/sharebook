class ChangeColumnType < ActiveRecord::Migration
  def change
    change_column(:books, :isbn_10, :string)
  end
end
