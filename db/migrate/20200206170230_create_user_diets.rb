class CreateUserDiets < ActiveRecord::Migration[6.0]
  def change
    create_table :user_diets do |t|
      t.references :diet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
