class OwnerToReaderReviewsController < ApplicationController
  before_action :set_booking, only: [:new, :create]

  def new
    @owner_to_reader_review = @booking.owner_to_reader_reviews.build
  end

  def create
    @owner_to_reader_review = OwnerToReaderReviews.create(owner_to_reader_review_params)
    @owner_to_reader_review.booking = @booking
    @owner_to_reader_review.save
    redirect_to booking_path(@booking)
  end

  private

  def owner_to_reader_review_params
    params.require(:owner_to_reader_review).permit(:reader_comment)
  end
  def set_booking
    @booking = Booking.find(params[:booking_id])
  end
end
