class SerializableSale < JSONAPI::Serializable::Resource
  type 'sales'
  belongs_to :user
  belongs_to :client
  attribute :date do
    @object.created_at
  end
  has_one :reservation
end