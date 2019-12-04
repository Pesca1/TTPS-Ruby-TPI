class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_many :items, as: :saleable
end
