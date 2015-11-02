class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :book, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :published

      t.timestamps null: false
    end
  end
end
