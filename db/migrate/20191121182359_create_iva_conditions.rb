class CreateIvaConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :iva_conditions do |t|
      t.string :name

      t.timestamps
    end
    add_index :iva_conditions, :name
  end
end
