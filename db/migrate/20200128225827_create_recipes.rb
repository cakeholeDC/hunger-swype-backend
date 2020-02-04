class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :api_id
      t.string :title
      t.string :photo
      t.float :rating
      t.integer :servings
      t.integer :cook_time
      t.string :ingredients

      t.timestamps
    end
  end
end
