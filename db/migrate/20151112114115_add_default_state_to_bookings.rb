class AddDefaultStateToBookings < ActiveRecord::Migration
  def change
    change_column :bookings, :state, :string, :default => "pending"
  end
end
