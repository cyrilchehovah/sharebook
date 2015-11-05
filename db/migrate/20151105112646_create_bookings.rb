class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :offer, index: true, foreign_key: true
      t.boolean :accepted
      t.date :starts_on
      t.date :ends_on

      t.timestamps null: false
    end
  end
end
