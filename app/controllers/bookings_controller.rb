class BookingsController < ApplicationController
  before_action :set_book, only: [:create, :show]
  before_action :set_user, only: [:create, :new]

  def create
    @offer = Offer.find(params[:offer_id])
    @offer.bookings.create(user_id: current_user.id)
    redirect_to user_path(current_user)
  end

  def show
    @booking = Booking.find(params[:id])
  end


  private
  def set_book
    @book = Book.find(params[:booking][:offer_id, :book_id])
  end
  def set_offer
    @user = current_user
  end
  def params_booking
    params.require(:booking).permit(:user_id, :offer_id)
  end

end

