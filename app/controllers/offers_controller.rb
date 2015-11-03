class OffersController < ApplicationController
  before_action :set_book

  def new
    @offer = @book.offers.build
  end

  def create
  end

  private
  def set_book
    @book = Book.find(params[:book_id])
  end

end
