require 'test_helper'

class SaleTest < ActiveSupport::TestCase

  test "has all valid attributes" do
    s = Sale.new
    assert_not s.valid?
    [:user, :client, :items].each do | field |
      assert_includes s.errors.details[field], error: :blank
    end
    s.user= users(:one)
    s.client= clients(:one)
    s.items << products(:one).items.first
    assert s.valid?
  end

  test "price is correct" do
    s = Sale.new(user: users(:one), client: clients(:one))
    s.items << products(:one).items.first(2)
    assert_equal products(:one).price*2, s.price
  end

end
