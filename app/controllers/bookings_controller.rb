class BookingsController < ApplicationController

  def create
    raise
    @offer = Offer.find(params[:offer_id])
    @offer.bookings.create(user_id: current_user.id)
    redirect_to user_path(current_user)
  end

end

