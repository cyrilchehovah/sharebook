class ChangeColumnAccepted < ActiveRecord::Migration
  def change
    remove_column :bookings, :accepted, :boolean
    add_column :bookings, :state, :string
  end
end
