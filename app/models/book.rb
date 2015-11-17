class Book < ActiveRecord::Base

  include AlgoliaSearch

  has_many :offers
  has_many :users, through: :offers

  after_create :fetch_amazon_fields



  algoliasearch do

    attribute :title, :author, :image


    add_attribute :users_addresses

    end



      def users_addresses
         self.offers.select { |offer| offer.valid? }.map do |offer|
          { address1: offer.user.address1, attr: offer.user.address1 }
          end
        end

      # def _geoloc
      #   self.users.select { |user|  }.map do |user|
      #     { lat_attr: user.latitude, lng_attr: user.longitude, attr: user.latitude, attr: user.longitude}
      #   end
      # end



  Book.reindex!


  def fetch_amazon_fields
    item = Amazon::Ecs.item_lookup(self.isbn_10, { :response_group => 'Large' }).items.first
    if item != nil || self.isbn_10.empty? == false
      self.image = item.get_hash('LargeImage')['URL']
      # self.publisher = item.get('ItemAttributes/Publisher')
      self.pages_number = item.get('ItemAttributes/NumberOfPages')
      # self.isbn item.get('ItemAttributes/ISBN')
      self.save
    end
  end



end
