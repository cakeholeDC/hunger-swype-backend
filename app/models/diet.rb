class Diet < ApplicationRecord
	has_many :dish_diets
	has_many :dishes, through: :dish_diets

	has_many :user_diets
	has_many :users, through: :user_diets
end
