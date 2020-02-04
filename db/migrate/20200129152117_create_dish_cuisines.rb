class CreateDishCuisines < ActiveRecord::Migration[6.0]
  def change
    create_table :dish_cuisines do |t|
      t.references :dish, null: false, foreign_key: true
      t.references :cuisine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
