class User < ActiveRecord::Base

  has_many :offers
  has_many :bookings
  has_many :messages
  has_many :offers_bookings, through: :offers, source: :bookings
  has_many :books, through: :offers

   has_attached_file :picture,
   styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://placehold.it/200x200"

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.profil_img = auth.info.image
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  def messages_sent_to_you
    messages = []
    my_offers_bookings = Booking.where(offer: offers)
    other_bookings = bookings
    bkgs = (my_offers_bookings + other_bookings).flatten
    bkgs.each do |bkg|
      messages << bkg.messages
    end
    messages.flatten.select { |message| self != message.user }
  end

  def unread_messages
    messages_sent_to_you.select { |message| message.read_at.nil? }
  end

  def unread_messages_count
    unread_messages.count
  end

  geocoded_by :address1
  before_validation :geocode, if: :address1_changed?

  after_update :algoliaReindex
  def algoliaReindex
    Book.reindex!
  end

  # after_validation :geocode_or_reset_coordinates, if: :address1_changed?


  # private

  #   def geocode_or_reset_coordinates
  #     if geocode.nil?
  #       self.latitude = nil
  #       self.longitude = nil
  #     end
  #   end

end
