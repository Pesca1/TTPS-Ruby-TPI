require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  
  test "has all valid attributes" do
    r = Reservation.new
    r.valid?
    [:client, :user, :items].each do | field |
      assert_includes r.errors.details[field], error: :blank
    end
    r.user = users(:one)
    r.client = clients(:one)
    r.items << items(:fix_1)
    assert r.valid?
  end

  test "price is correct" do
    r = Reservation.new
    r.items << products(:one).items
    assert_equal products(:one).items.map(&:price).sum, r.price
  end

  test "sell is correct" do
    r = Reservation.new(client: clients(:one), user: users(:one))
    products(:one).reserve(2, r)
    assert_not r.is_sold
    r.sell users(:one)
    assert r.is_sold
    r.items.each do | item |
      assert item.is_sold
    end
  end

  test "not_sold is correct" do
    flunk
  end

end
