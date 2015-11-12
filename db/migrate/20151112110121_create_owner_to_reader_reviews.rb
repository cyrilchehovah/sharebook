class CreateOwnerToReaderReviews < ActiveRecord::Migration
  def change
    create_table :owner_to_reader_reviews do |t|
      t.references :booking, index: true, foreign_key: true
      t.integer :reader_rating
      t.string :reader_comment

      t.timestamps null: false
    end
  end
end
