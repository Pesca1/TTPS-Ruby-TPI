class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.belongs_to :product
      t.belongs_to :reservation, optional: true

      t.timestamps
    end
  end
end