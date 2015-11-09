class BookingsController < ApplicationController

  def create
    @offer = Offer.find(params[:offer_id])
    @booking = Booking.create(user: current_user, offer: @offer)
    redirect_to user_path(current_user)
  end

  def update
    # TODO
    # update booking
    @booking = Booking.find(params[:id])
    if @booking.update(params_booking)
      redirect_to user_path(current_user)
    # redirect_to
    else
      render user_path
    end
  end

  private
  def params_booking
    params.require(:booking).permit(:accepted)
  end

end

