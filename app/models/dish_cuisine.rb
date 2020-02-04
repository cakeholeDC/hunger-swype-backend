class DishCuisine < ApplicationRecord
  belongs_to :dish
  belongs_to :cuisine
end
