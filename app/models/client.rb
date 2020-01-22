class Client < ApplicationRecord
  belongs_to :iva_condition
  has_many :phones
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: true }, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :iva_condition, presence: true
  validates :phones, presence: true
  validates :cuit, presence: true
end
