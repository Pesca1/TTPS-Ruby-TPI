require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "name is unique, password is present" do
    u = User.new
    assert_not u.valid?
    assert_includes u.errors.details[:name],     error: :blank
    assert_includes u.errors.details[:password], error: :blank
    u.name= users(:one).name
    assert_not u.valid?
    assert_includes u.errors.details[:name], { error: :taken, value: u.name }
    u.password= "aaa"
    u.name= "aaa"
    assert u.valid?
  end

end
