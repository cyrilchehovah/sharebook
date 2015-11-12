class Book < ActiveRecord::Base
  has_many :offers

  def sync_with_amazon

  end
end
