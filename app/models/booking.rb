class Booking < ActiveRecord::Base
  STATES=%w(pending accepted ended canceled)
  belongs_to :offer
  belongs_to :user
  # belongs_to :owner, class_name: 'User', foreign_key: 'user_id'


  has_many :messages, dependent: :destroy
  # has_many :owner_to_reader_reviews, dependent: :destroy


  validates :offer, presence: true
  validates :user, presence: true
  validates :state, presence: true

  validates :state, inclusion: { in: STATES }
  after_create :send_first_message


  private

  def send_first_message
    Message.create(content: "Demande d'emprunt de #{user.first_name} pour #{self.offer.book.title}", booking: self, user: user, auto_generated: true)
  end

end


