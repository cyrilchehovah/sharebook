class Book < ActiveRecord::Base
  include AlgoliaSearch
  CATEGORIES = %w(développement graphisme ux webdesign webmarketing)

  has_many :offers, dependent: :destroy
  has_many :users, through: :offers

  after_create :fetch_amazon_fields

  algoliasearch do

      attribute :title, :author, :image, :category
      add_attribute :_geoloc

      attributesForFaceting [:category]

    end

    algoliasearch per_environment: true do
        attributesForFaceting ['category']
      end

    def _geoloc
       self.offers.select { |offer| offer.valid? }.map do |offer|
        { lat: offer.user.latitude, lng: offer.user.longitude }
        end
    end

  Book.reindex!

  validates :category, inclusion: { in: CATEGORIES }

  def fetch_amazon_fields
    item = Amazon::Ecs.item_lookup(self.isbn_10, { :response_group => 'Large' }).items.first
    if item != nil && self.isbn_10.empty? == false
      self.image = item.get_hash('LargeImage')['URL']
      # self.publisher = item.get('ItemAttributes/Publisher')
      self.pages_number = item.get('ItemAttributes/NumberOfPages')
      # self.isbn item.get('ItemAttributes/ISBN')
      self.save
    end
  end
end
