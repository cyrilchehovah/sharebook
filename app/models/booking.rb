class Booking < ActiveRecord::Base
  belongs_to :offer
  belongs_to :user

  has_many :messages

  validates_inclusion_of :accepted, :in => [true, false]

  after_create :send_first_message

  private

  def send_first_message
    Message.create(content: "Salut, untel veut t'emprunter ce livre", user: user, booking: self)
  end

end


