class Token < ApplicationRecord
  include Tokenable
  belongs_to :user
  validates :token, uniqueness: true, presence: true
  validates :user,  uniqueness: true, presence: true
  validates_associated :user

  def self.generate(user)
    if has_valid_token(user)
      return find_by(user: user)
    end
    where(user_id: user.id).delete_all
    token = new(token: generate_token(), user: user)
    while not token.save do
      token = new(token: generate_token(), user: user)
    end
    return token
  end

  def self.has_valid_token(user)
    where(" user_id = ? ", user.id).where(" created_at >= ? ", 30.minutes.ago).any?
  end

  def self.is_valid(token)
    ! Token.where(" created_at >= ? ", 30.minutes.ago).find_by(token: token).nil?
  end

  def self.get_user(token)
    t = Token.find_by(token: token)
    return t.user if !t.nil?
    return nil
  end

end
