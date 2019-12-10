class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      #t.integer :user_id, null: false
      #t.integer :client_id, null: false
      #t.integer :item_id, optional: true

      t.timestamps
    end
    add_reference :reservations, :user, foreign_key: true, null: false
    add_reference :reservations, :client, foreign_key: true, null: false
    add_reference :reservations, :sale, foreign_key: true
  end
end
