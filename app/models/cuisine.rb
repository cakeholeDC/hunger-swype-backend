class Cuisine < ApplicationRecord
	has_many :dish_cuisines
	has_many :dishes, through: :dish_cuisines
end
