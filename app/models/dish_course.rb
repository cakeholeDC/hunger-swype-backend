class DishCourse < ApplicationRecord
  belongs_to :dish
  belongs_to :course
end
