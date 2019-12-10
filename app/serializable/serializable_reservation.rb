class SerializableReservation < JSONAPI::Serializable::Resource
  type 'reservations'
  belongs_to :user
  belongs_to :client
  attribute :date do
    @object.created_at
  end
  attributes :price
  has_many :items
  belongs_to :sale
end