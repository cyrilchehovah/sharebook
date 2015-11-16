class Book < ActiveRecord::Base

  has_many :offers

  after_create :fetch_amazon_fields

  include AlgoliaSearch

  algoliasearch do
    attribute :title, :author
  end

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
