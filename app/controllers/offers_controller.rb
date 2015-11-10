class OffersController < ApplicationController
  before_action :set_book, only: [:create, :show]
  before_action :set_user, only: [:create, :new]

  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end


  def create
    @offer = @book.offers.new(params_offer)
    @offer.book = @book
    @offer.user = @user

    if @offer.valid?
      @offer.save
      redirect_to books_path()
    else
      render :new
    end
  end

  def create_book_and_offer
    # how to create a new book while creating a new offer????
  end

  private
  def set_book
    @book = Book.find(params[:offer][:book_id])
  end
  def set_user
    @user = current_user
  end

  def params_offer
    params.require(:offer).permit(:user_id, :book_id)
  end

end
