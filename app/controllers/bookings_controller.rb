class BookingsController < ApplicationController


  def create

    @booking = current_user.bookings.build(booking_params)
    @booking = offer.booking
  end

  private

  def booking_params
   params.require(:booking).permit(:user_id, :offer_id, :accepted, :starts_on, :ends_on)
  end

end
