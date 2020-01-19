class Sale < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_many :items, as: :saleable
  has_one :reservation

  def price
    items.map(&:price).sum
  end
end
