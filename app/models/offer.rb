class Offer < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  has_many :bookings, dependent: :destroy

  validates :book, presence: true
  validates :user, presence: true
  validates_uniqueness_of :user_id, :scope => [:book_id]
end


