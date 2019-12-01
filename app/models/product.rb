class Product < ApplicationRecord
  has_many :items

  def stock
    items.count
  end

  def self.in_stock
    self.select { |p| p.stock > 0 }
  end

  def self.scarce
    self.select { |p| p.stock > 0 and p.stock <= 5 }
  end
end
