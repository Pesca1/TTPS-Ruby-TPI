class IvaCondition < ApplicationRecord
  has_many :clients

  validates :name, presence: true, uniqueness: { case_sensitive: true }
end
