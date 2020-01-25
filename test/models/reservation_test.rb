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
    r = reservations(:one)
    assert_equal products(:three).items.map(&:price).sum, r.price
  end

  test "sell and is_sold are correct" do
    r = reservations(:one)
    assert_not r.is_sold
    r.sell users(:one)
    assert r.is_sold
    r.items.each do | item |
      assert item.is_sold
    end
  end

  test "not_sold is correct" do
    r = Reservation.new(client: clients(:one), user: users(:one))
    products(:one).reserve 1, r
    r.sell users(:one)
    assert r.is_sold
    assert !reservations(:one).is_sold
    assert_not_includes Reservation.not_sold, r
    assert_includes     Reservation.not_sold, reservations(:one)
  end

end
