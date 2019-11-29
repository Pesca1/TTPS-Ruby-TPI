class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.has_one :reservation, optional: true
      t.has_many :items, optinal: true
      t.belongs_to :client
      t.belongs_to :user

      t.timestamps
    end
  end
end