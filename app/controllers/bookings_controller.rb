class BookingsController < ApplicationController
  def create
    @offer = Offer.find(params[:offer_id])
    @offer.bookings.create(user_id: current_user.id)
    redirect_to user_path(current_user)
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end
end
