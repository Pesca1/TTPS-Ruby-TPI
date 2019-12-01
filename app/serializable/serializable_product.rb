class SerializableProduct < JSONAPI::Serializable::Resource
  type 'products'
  attributes :code, :description, :detail, :price, :stock
end