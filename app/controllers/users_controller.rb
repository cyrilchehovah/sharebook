class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @offers = @user.offers


    @books = []

    @offers.each do |offer|
      id = offer[:book_id]
      book = Book.find(id)
      @books << book
    end

  end
end
