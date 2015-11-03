class OffersController < ApplicationController
  before_action :set_book, only: [:create]
  before_action :set_user, only: [:create]

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(params_offer)
    @offer.book = @book
    @offer.user = @user

      if @offer.valid?
        @offer.save
        # redirect_to cocktail_path(@cocktail)
      else
        render :new
      end
  end

  private
  def set_book
    @book = Book.find(params[:book_id])
  end
  def set_user
    @user = User.find(params[:user_id])
  end

  def params_offer
    params.require(:offer).permit(:user_id, :book_id)
  end

end
