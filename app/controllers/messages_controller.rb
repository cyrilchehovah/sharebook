class MessagesController < ApplicationController

  before_action :set_booking

  def create
    @message = Message.new(params_message)
    @message.booking = @booking
    @message.user = current_user

    if @message.valid?
      @message.save
      respond_to do |format|
        format.html{}
        format.js{}
      end
      redirect_to booking_path(@booking)
    else
      render "bookings/show"
    end
  end


  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def params_message
    params.require(:message).permit(:content)
  end
end




