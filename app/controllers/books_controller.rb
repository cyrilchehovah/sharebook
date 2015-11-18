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
    @booking = Booking.new
    @offers = @book.offers

    @markers = Gmaps4rails.build_markers(@offers) do |offer, marker|
      marker.lat offer.user.latitude
      marker.lng offer.user.longitude
      marker.json({:id => offer.id })
      marker.picture url: ActionController::Base.helpers.asset_path("marker.png"), width: 100, height: 100
      marker.infowindow render_to_string(:partial => "/books/infowindowcontent", :locals => { :object => offer})

      # "<strong>#{offer.user.first_name} #{offer.user.last_name}</strong>
      # <br>"
    end
  end

  private

  def params_book
    params.require(:book).permit(:title, :description, :category, :author, :image)
  end

end
