class SerializableItem < JSONAPI::Serializable::Resource
  type 'items'
  attributes :price, :state
  belongs_to :product
end