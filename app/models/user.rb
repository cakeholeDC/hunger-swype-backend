class User < ApplicationRecord
	has_many :favorites
	has_many :recipes, through: :favorites

	has_many :user_diets
	has_many :diets, through: :user_diets

	has_secure_password
	validates :username, uniqueness: {case_sensititive: false}

	def favorite_recipes
		self.favorites.map do |favorite|
			favorite.recipe
		end		
	end
end
