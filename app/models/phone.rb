class Phone < ApplicationRecord
  belongs_to :client

  validates :number, presence: true, uniqueness: true
end
