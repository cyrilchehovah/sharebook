class User < ActiveRecord::Base

  has_many :offers
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
      user.picture = auth.info.image
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  geocoded_by :address1
  before_validation :geocode, if: :address1_changed?

  # after_validation :geocode_or_reset_coordinates, if: :address1_changed?


  # private

  #   def geocode_or_reset_coordinates
  #     if geocode.nil?
  #       self.latitude = nil
  #       self.longitude = nil
  #     end
  #   end

end
