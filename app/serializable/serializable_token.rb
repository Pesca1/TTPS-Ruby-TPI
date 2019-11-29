class SerializableToken < JSONAPI::Serializable::Resource
  type 'tokens'
  attributes :token, :created_at
  belongs_to :user
end