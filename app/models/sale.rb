class Sale < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_many :items, as: :saleable
  has_one :reservation

  validates :user, presence: true
  validates :client, presence: true
  validates :items, presence: true
  validates_associated :reservation, :user, :client

  def price
    items.map(&:price).sum
  end
end
