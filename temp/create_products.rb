class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.has_many :items, index: true
      t.string :code
      t.string :description
      t.text :detail
      t.float :price

      t.timestamps
    end
    add_index :products, :code, unique: true
  end
end
