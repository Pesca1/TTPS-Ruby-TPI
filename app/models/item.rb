class Item < ApplicationRecord
  belongs_to :product
  belongs_to :saleable, polymorphic: true, optional: true

  def state
    if true#reservation.nil?
      'in_stock'
    else

    end
  end
end
