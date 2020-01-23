class AddIvaConditionToClients < ActiveRecord::Migration[6.0]
  def change
    add_reference :clients, :iva_condition, foreign_key: true#, null: false
  end
end
