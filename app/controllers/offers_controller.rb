class OffersController < ApplicationController
  before_action :set_book, only: [:create, :update, :show]
  before_action :set_user, only: [:create, :create_book_and_offer, :new, :destroy]

  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
    @book  = Book.new
  end


  # def create
  #   @offer = @book.offers.new(params_offer)
  #   @offer.book = @book
  #   @offer.user = @user

  #   if @offer.valid?
  #     @offer.save
  #     redirect_to books_path()
  #   else
  #     render :new
  #   end
  # end

  def create_book_and_offer
    @book = Book.find_by(title: params[:book][:title])

    if @book == nil
      # créer le book, puis l'offer
      @book = Book.new(params_book)
      @book.save
      # @book.sync_with_amazon
    end

    @offer      = @book.offers.new
    @offer.user = current_user
    @offer.book = @book

    if @offer.save
      Book.reindex!
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy
    redirect_to user_path(@user)
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

  def params_book
    params.require(:book).permit(:title, :description, :category, :author, :image, :publisher, :pages_number, :subtitle, :isbn_10)
  end

end
