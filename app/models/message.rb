class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :booking

  validates :booking, presence: true
  validates :content, presence: true
end
