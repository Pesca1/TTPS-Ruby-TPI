require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "code is unique" do
    assert Product.new(code: 'ABC123456', description:'a', detail:'a', price: 0).save
    assert_not Product.new(code: 'ABC123456', description:'a', detail:'a', price: 0).valid?, "product code repeats"
  end

  test "description in less than 200 chars" do
    description = (0...210).map { (65 + rand(26)).chr }.join
    assert_not Product.new(code: 'ABC234567', description: description, detail:'a', price: 0).valid?, "description is too long"
    description = (0...200).map { (65 + rand(26)).chr }.join
    assert Product.new(code: 'ABC234567', description: description, detail:'a', price: 0).valid?
  end

  test "code is valid" do
    assert Product.new(code: 'BCD123456', description:'a', detail:'a', price: 0).valid?
    assert_not Product.new(code: 'BCD1234567', description:'a', detail:'a', price: 0).valid?
    assert_not Product.new(code: 'BC2347', description:'a', detail:'a', price: 0).valid?
  end

  test "product has all attributes" do
    assert_not Product.new.valid?
    assert_not Product.new(code: 'ABC123456').valid?
    assert_not Product.new(code: 'ABC123456', description:'a').valid?
    assert_not Product.new(code: 'ABC123456', description:'a', detail: 'a').valid?
    assert Product.new(code: 'ABC123456', description:'a', detail: 'a', price: 0).valid?
  end

  test "stock is correct" do
    assert_equal 5, products(:one).stock
    assert_equal 6, products(:two).stock
    assert_equal 0, products(:three).stock
  end

  test "in_stock is correct" do
    assert     Product.in_stock.include? products(:one)
    assert     Product.in_stock.include? products(:two)
    assert_not Product.in_stock.include? products(:three)
  end

  test "scarce is correct" do
    assert_includes     Product.scarce, products(:one)
    assert_includes     Product.scarce, products(:three)
    assert_not_includes Product.scarce, products(:two)
  end

  test "add_items, reserve and sell are correct" do
    p = products(:four)
    old_stock = p.stock
    p.add_items(5)
    assert_equal old_stock + 5, p.stock
    p.reserve(2, reservations(:one))
    assert_equal old_stock + 3, p.stock
    p.sell(3, sales(:one))
    assert_equal old_stock, p.stock
  end

end
