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
    @offer = @book.offers
    @user = User.find(params[:id])
  end

  # si un book a au moins 1 offer, il s'affiche
  #sinon il ne s'affiche pas

end


