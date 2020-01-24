class User < ApplicationRecord
  has_one :token
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true
end
