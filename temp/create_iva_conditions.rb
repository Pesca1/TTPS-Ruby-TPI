class CreateIvaConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :iva_conditions do |t|
      t.string :name, null: false
    end
  end
end