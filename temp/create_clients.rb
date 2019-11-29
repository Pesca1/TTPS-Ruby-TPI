class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.has_one :iva_condition
      t.has_many :phones
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end