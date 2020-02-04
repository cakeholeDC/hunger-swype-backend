class CreateDishCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :dish_courses do |t|
      t.references :dish, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
