class Booking < ActiveRecord::Base
  belongs_to :offer
  belongs_to :user

  has_many :messages, dependent: :destroy
  has_many :owner_to_reader_reviews, dependent: :destroy
  validates_inclusion_of :accepted, :in => [true, false]
  validates :offer, presence: true
  validates :user, presence: true



  after_create :send_first_message

  private

  def send_first_message
    Message.create(content: "Salut, #{user.first_name} veut t'emprunter ce livre", user: user, booking: self)
  end

end


