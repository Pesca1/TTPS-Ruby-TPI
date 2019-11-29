class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :code
      t.string :description
      t.text :detail
      t.float :price

      t.timestamps
    end
    add_index :products, :code
  end
end
