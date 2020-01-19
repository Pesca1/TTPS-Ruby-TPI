class SerializableSale < JSONAPI::Serializable::Resource
  type 'sales'
  belongs_to :user
  belongs_to :client
  attributes :price
  attribute :date do
    @object.created_at
  end
  has_one :reservation
  has_many :items
end