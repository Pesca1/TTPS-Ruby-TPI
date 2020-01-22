require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  
  test "client has all attributes" do
    c = Client.new()
    assert_not c.valid?
    [:iva_condition, :phones, :name, :email, :cuit].each do | field |
      assert_includes c.errors.details[field], error: :blank
    end
    c = Client.new(name: 'a', email: 'a@mail.com', iva_condition: iva_conditions(:one), cuit: '11111')
    c.phones << Phone.new(number: 1111)
    assert c.valid?
  end

  test "email is valid" do
    c = Client.new(email: 'amail.com')
    c.valid?
    assert_includes c.errors.details[:email], {error: :invalid, value: 'amail.com'}
    c.email = 'a@mail.com'
    c.valid?
    assert_empty c.errors.details[:email]
  end

end
