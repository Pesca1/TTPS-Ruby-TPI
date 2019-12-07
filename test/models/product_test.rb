require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "code is unique" do
    assert Product.new(code: 'ABC123456', description:'', detail:'', price: 0).save
    assert_not Product.new(code: 'ABC123456', description:'', detail:'', price: 0).valid?, "product code repeats"
  end

  test "description in less than 200 chars" do
    description = [*('a'..'z')].shuffle[0, 210].join
    assert_not Product.new(code: 'ABC234567', description: description, detail:'', price: 0).valid?, "description is too long"
    description = [*('a'..'z')].shuffle[0, 200].join
    assert Product.new(code: 'ABC234567', description: description, detail:'', price: 0).valid?, "description is too short"
  end

  test "code is valid" do
    assert Product.new(code: 'BCD123456', description:'', detail:'', price: 0).valid?
    assert_not Product.new(code: 'BCD1234567', description:'', detail:'', price: 0).valid?
    assert_not Product.new(code: 'BC2347', description:'', detail:'', price: 0).valid?
  end

  test "product has all attributes" do
    assert_not Product.new.valid?
    assert_not Product.new(code: 'ABC123456').valid?
    assert_not Product.new(code: 'ABC123456', description:'').valid?
    assert_not Product.new(code: 'ABC123456', description:'', detail: '').valid?
    assert Product.new(code: 'ABC123456', description:'', detail: '', price: 0).valid?
  end

  test "stock is correct" do
    assert_equal Product.find_by(code: 'QWE123456').stock, 6
    assert_equal Product.find_by(code: 'QWE123457').stock, 5
  end

  test "in_stock is correct" do
    assert_not Product.in_stock.include? Product.find_by(code: 'QWE123456')
    assert_not Product.in_stock.include? Product.find_by(code: 'QWE123457')
    assert     Product.in_stock.include? Product.find_by(code: 'QWE123458')
  end

  test "scarce is correct" do
    assert     Product.scarce.include? Product.find_by(code: 'QWE123456')
    assert_not Product.scarce.include? Product.find_by(code: 'QWE123457')
    assert_not Product.scarce.include? Product.find_by(code: 'QWE123458')
  end
end
