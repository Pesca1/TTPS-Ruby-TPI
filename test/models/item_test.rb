require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  
  test "product is valid" do
    i = Item.new
    i.valid?
    assert_includes i.errors.details[:product], error: :blank
    i.product = Product.new
    i.valid?
    assert_includes i.errors.details[:product], { error: :invalid, value: i.product }
    i.product = products(:one)
    i.valid?
    assert_empty i.errors.details[:product]
  end

  test "state is correct" do
    i = Item.new
    assert i.is_in_stock
    i.saleable = Reservation.new
    assert i.is_reserved
    i.saleable = Sale.new
    assert i.is_sold
  end

  test "price is correct" do
    product = products(:one)
    i = Item.new(product: product)
    assert_equal product.price, i.price
    i.saleable = Reservation.new
    product.price= product.price + 1
    assert_equal product.price, i.price
    i.saleable.sell User.new
    product.price= product.price + 1
    product.save
    assert_equal product.price, i.price + 1
  end

end
