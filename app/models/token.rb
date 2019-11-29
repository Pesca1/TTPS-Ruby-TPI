class Token < ApplicationRecord
  belongs_to :user
  validates :token, uniqueness: true

  def self.generate(user)
    t = [*('a'..'z'),*('0'..'9')].shuffle[0,50].join
    token = new(token: t, user: user)
    while not token.save do
      t = [*('a'..'z'),*('0'..'9')].shuffle[0,50].join
      token = new(token: t, user: user)
    end
    token
  end

  def self.has_valid_token(user)
    where(" user_id = ? ", user.id).where(" created_at >= ? ", 30.minutes.ago).any?
  end

end
