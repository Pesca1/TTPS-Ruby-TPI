class Sale < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_many :items, as: :saleable
  has_one :reservation
end
