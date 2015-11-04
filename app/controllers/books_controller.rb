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
      @users << offer.user
    end
    @markers = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
    end
  end
end


