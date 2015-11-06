class Booking < ActiveRecord::Base
  belongs_to :offer
  belongs_to :user

  validates_inclusion_of :accepted, :in => [true, false]
end


