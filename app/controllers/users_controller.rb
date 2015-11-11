class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @offers = @user.offers
    @bookings = @user.bookings
    @lendings = Booking.where(offer: @offers)
  end

end
