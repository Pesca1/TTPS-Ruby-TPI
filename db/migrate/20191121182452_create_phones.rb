class CreatePhones < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
      t.integer :number
      t.belongs_to :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
