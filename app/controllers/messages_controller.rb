class MessagesController < ApplicationController

  before_action :set_booking

  def create
    @message = Message.new(params_message)
    @message.booking = @booking
      if @message.valid?
        @message.save
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




