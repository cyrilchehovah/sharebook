class BookingsController < ApplicationController

  def index
    @borrow_bookings = Booking.where(user: current_user)
    @lend_bookings = Booking.where(offer: current_user.offers)
  end

  def show
    @booking = Booking.find(params[:id])
    @message = Message.new
    @owner = @booking.offer.user

    respond_to do |format|
      format.html{redirect_to booking_path(@booking)}
      format.js{}
    end
  end
  def create
    @offer = Offer.find(params[:offer_id])
    @booking = Booking.create(user: current_user, offer: @offer)
    redirect_to bookings_path
  end

  def update
    # TODO
    # update booking
    @booking = Booking.find(params[:id])
    @booking.update(params_booking)

    respond_to do |format|
      format.html{redirect_to booking_path(@booking)}
      format.js{}
    end
  end

  private
  def params_booking
    params.require(:booking).permit(:accepted)
  end

end

