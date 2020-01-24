class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :client
  belongs_to :sale, optional: true
  has_many :items, as: :saleable

  validates :user, presence: true
  validates :client, presence: true
  validate  :item_presence

  private def item_presence
    if sale.nil? && items.empty?
      errors.add(:items, :blank)
    end
  end

  def self.not_sold
    self.select { |r | !r.is_sold }
  end

  def is_sold
    !sale.nil?
  end

  def price
    items.map(&:price).sum
  end

  def sell(user)
    self.sale= Sale.create(user: user, client: client)
    items.each do |i|
      i.price= i.price
      self.sale.items << i
      i.saleable= self.sale
      i.save!
    end
    self.sale.save!
    self.save!
  end

end
