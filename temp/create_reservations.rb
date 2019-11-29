class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.has_many :items
      t.has_one :sale, optional: true
      t.belongs_to :user
      t.belongs_to :client
      
      t.timestamps
    end
  end
end