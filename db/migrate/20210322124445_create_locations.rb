class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :difficulty
      t.text :condition
      t.string :direction

      t.timestamps
    end
  end
end
