class CreateDishDiets < ActiveRecord::Migration[6.0]
  def change
    create_table :dish_diets do |t|
      t.references :dish, null: false, foreign_key: true
      t.references :diet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
