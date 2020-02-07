class AddSourceUrlToRecipe < ActiveRecord::Migration[6.0]
  def change
  	add_column :recipes, :source_url, :string
  end
end
