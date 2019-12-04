class SerializableItem < JSONAPI::Serializable::Resource
  type 'items'
  attributes :code, :description, :detail, :price, :stock
end