class Booking < ActiveRecord::Base
  STATES=%w(pending accepted ended canceled)
  belongs_to :offer
  belongs_to :user

  has_many :messages, dependent: :destroy

  validates :offer, presence: true
  validates :user, presence: true
  validates :state, presence: true

  validates :state, inclusion: { in: STATES }
  after_create :send_first_message

  private

  def send_first_message
    Message.create(content: "Salut, #{user.first_name} veut t'emprunter ce livre", user: user, booking: self)
  end

end


