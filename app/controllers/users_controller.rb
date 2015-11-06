class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @offers = @user.offers
    @bookings = @user.bookings
    # @bookings = @accepted.bookings

    @bookings = params[:accepted_bookings] == "1"

    @books = []

    @offers.each do |offer|
      id = offer[:book_id]
      book = Book.find(id)
      @books << book
    end

  end
end
