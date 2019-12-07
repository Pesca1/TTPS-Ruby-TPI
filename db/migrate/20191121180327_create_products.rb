class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :code, null: false
      t.string :description, null: false
      t.text :detail, null: false
      t.float :price, null: false

      t.timestamps
    end
    add_index :products, :code
  end
end
