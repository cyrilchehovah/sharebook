class BookingsController < ApplicationController

  def index
    @borrow_bookings = Booking.where(user: current_user)
    @lend_bookings = Booking.where(offer: current_user.offers)
  end

  def show
    @booking = Booking.find(params[:id])
    @message = Message.new
    @owner = @booking.offer.user

    @messages = []
    @booking.messages.each do |message|
      @messages << message
      if message.user != current_user
        message.read_at = DateTime.now
        message.save
      end
    end
    @messages.sort_by!(&:created_at).reverse


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
    @owner = @booking.offer.user

    if @booking.state == "accepted"
      @booking.offer.published = false
      @booking.offer.save
    elsif @booking.state == "ended"
      @booking.offer.published = true
      @booking.offer.save
    end


    respond_to do |format|
      format.html{redirect_to booking_path(@booking)}
      format.js{}
    end

    create_auto_message(@booking)
  end

  private
  def params_booking
    params.require(:booking).permit(:state)
  end

  def create_auto_message(booking)
    @message = Message.create(content: "Le prêt est accepté", booking: booking, user: current_user, auto_generated: true) if (booking.state == "accepted")
    @message = Message.create(content: "Le booking est ", booking: booking, user: current_user, auto_generated: true) if (booking.state == "canceled" && current_user = @booking.offer.user)
    @message = Message.create(content: "Le prêt est accepté", booking: booking, user: current_user, auto_generated: true) if (booking.state == "canceled" && current_user = @booking.user)
    @message = Message.create(content: "Le livre est de retour", booking: booking, user: current_user, auto_generated: true) if (booking.state == "ended" && current_user = @booking.user)
  end
end


