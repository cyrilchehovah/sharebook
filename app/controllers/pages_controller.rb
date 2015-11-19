class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @books = Offer.last(4).reverse.map do |offer|
      offer.book
    end
  end
end
