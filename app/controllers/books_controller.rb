class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @books = Book.all

    @array = []
    @books.each do |book|
      if book.offers[0] != nil
        @array << book
      end
    end

  end

  def show
    @book = Book.find(params[:id])
    @offers = @book.offers
    @users = []

    @offers.each do |offer|
      id = offer[:user_id]
      user = User.find(id)
      @users << user
    end
  end
end


