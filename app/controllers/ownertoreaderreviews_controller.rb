class OwnerToReaderReviewsController < ApplicationController
  before_action :find_booking, only: [:new, :create]

  def new
    @owner_to_reader_reviews = OwnerToReaderReview.new
  end

  def create
    @owner_to_reader_review = @booking.owner_to_reader_reviews.build(owner_to_reader_review_params)
    @owner_to_reader_review.save
  end

  private

  def owner_to_reader_review_params
    params.require(:owner_to_reader_review).permit(:content)
  end
  def find_booking

    @booking = Booking.find(params[:booking_id])
  end
end
