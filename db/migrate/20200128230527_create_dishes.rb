class CreateDishes < ActiveRecord::Migration[6.0]
  def change
    create_table :dishes do |t|
      t.string :api_id
      t.string :photo
      t.boolean :is_recipe ## is_recipe ? Dish.recipe_id : Dish.restaurant_id
      t.references :recipe, null: true, foreign_key: true
      t.references :restaurant, null: true, foreign_key: true

      t.timestamps
    end
  end
end

