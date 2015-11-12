class AddDefaultPublishToOffers < ActiveRecord::Migration
  def change
    change_column :offers, :published, :boolean, :default => "true"
  end
end
