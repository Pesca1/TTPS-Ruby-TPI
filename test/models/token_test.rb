require 'test_helper'

class TokenTest < ActiveSupport::TestCase

  test "user is valid, token is present" do
    t = Token.new
    assert_not t.valid?
    [:user, :token].each do | field |
      assert_includes t.errors.details[field], error: :blank
    end
    t.user= User.new
    assert_not t.valid?
    assert_includes t.errors.details[:user], { error: :invalid, value: t.user }
    t.user= users(:one)
    t.token= 'aaa'
    assert t.valid? 
  end

  test "generate creates one token at a time per user" do
    token1 = Token.generate(users(:one))
    token2 = Token.generate(users(:one))
    assert_equal token1, token2
  end

  test "has_valid_token is correct" do
    assert_not Token.has_valid_token(users(:one))
    Token.generate(users(:one))
    assert Token.has_valid_token(users(:one))
    t = Token.find_by(user: users(:one))
    t.created_at = 31.minutes.ago
    t.save!
    assert_not Token.has_valid_token(users(:one))
  end

  test "get_user is correct" do
    t = Token.generate(users(:one))
    assert_equal users(:one), Token.get_user(t.token)
    t.delete
    assert_nil Token.get_user(t.token)
  end

  test "is_valid is correct" do
    t = Token.generate(users(:one))
    assert Token.is_valid(t.token)
    t.created_at= 31.minutes.ago
    t.save!
    assert_not Token.is_valid(t.token)
  end

end
