class Product < ApplicationRecord
  validates :code, presence: true, uniqueness: { case_sensitive: true }
  validates :description, presence: true, length: { maximum: 200 }
  validates :detail, presence: true
  validates :price, presence: true
  validates_each :code do |record, attr, value|
    record.errors.add(attr, 'must have 3 letters and 6 numbers') if !(value =~ /^[a-zA-Z]{3}\d{6}$/)
  end

  has_many :items

  def stock
    items.where(product_id: self.id, saleable_id: nil).count
  end

  def self.in_stock
    joins(:items).where(items: {saleable_id: nil}).group(:product_id)
  end

  def self.scarce
    Product.find Item.joins(:product).group(:product_id).count(:product_id).select {| key, value | value <= 5}.keys
  end

  def add_items(amount)
    new_items = []
    amount.times { new_items.push Item.create(product: self) }
    reload
    new_items
  end

  def reserve(amount, reservation)
    items.select(&:is_in_stock).first(amount).each do |i|
      i.saleable= reservation
      reservation.items << i
      i.save!
    end
    reservation.save!
  end

  def sell(amount, sale)
    items.select(&:is_in_stock).first(amount).each do |i|
      sale.items << i
      i.saleable= sale
      i.price= self.price
      i.save
    end
    sale.save
  end

end
