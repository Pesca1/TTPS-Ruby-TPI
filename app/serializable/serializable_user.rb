class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'
  attributes :name, :password
end