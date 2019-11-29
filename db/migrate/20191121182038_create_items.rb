class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :reservation, optional: true, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
