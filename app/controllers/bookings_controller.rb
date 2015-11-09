class BookingsController < ApplicationController

  def create
    @offer = Offer.find(params[:offer_id])
    @booking = Booking.create(user: current_user, offer: @offer)
    redirect_to user_path(current_user)
  end

end



