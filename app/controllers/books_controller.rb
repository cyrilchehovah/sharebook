class BooksController < ApplicationController

  def index
    @books = Book.all

    @array = []
    @books.each do |book|
      if book.offers[0] != nil
        @array << book
      end
    end

  end

  # si un book a au moins 1 offer, il s'affiche
  #sinon il ne s'affiche pas
end
