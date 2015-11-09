class AddDefaultValueToBookings < ActiveRecord::Migration
  def change
    change_column :bookings, :accepted, :boolean, default: false
  end
end
