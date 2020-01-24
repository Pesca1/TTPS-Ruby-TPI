class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :token, unique: true, null: false
      t.belongs_to :user, null: false, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
