class OwnerToReaderReview < ActiveRecord::Base
  belongs_to :booking

  validates_inclusion_of :reader_rating, :in (0..5)
  validates :reader_comment, presence: true

end
