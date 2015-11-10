class BookingsController < ApplicationController

  def index
    @borrow_bookings = Booking.where(user: current_user)
    @lend_bookings = Booking.where(offer: current_user.offers)
  end

  def show
    @booking = Booking.find(params[:id])
    @message = Message.new

    respond_to do |format|
      format.html{}
      format.js{}
    end
  end
  def create
    @offer = Offer.find(params[:offer_id])
    @booking = Booking.create(user: current_user, offer: @offer)
    redirect_to offer_bookings_path(@offer)
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

