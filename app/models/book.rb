class Book < ActiveRecord::Base
  has_many :offers

  # after_create :fetch_amazon_fields

  def fetch_amazon_fields
    item = Amazon::Ecs.item_lookup(self.isbn, { :response_group => 'Large' }).items.first

    self.image = item.get_hash('MediumImage')['URL']
    self.publisher = item.get('ItemAttributes/Publisher')
    self.pages_number = item.get('ItemAttributes/NumberOfPages')
    self.isbn item.get('ItemAttributes/ISBN')
  end
end
