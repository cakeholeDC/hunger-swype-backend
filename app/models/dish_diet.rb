class DishDiet < ApplicationRecord
  belongs_to :dish
  belongs_to :diet
end
