class User < ApplicationRecord
	has_many :favorites
	has_many :dishes, through: :favorites

	has_many :user_diets
	has_many :diets, through: :user_diets

	has_secure_password
	validates :username, uniqueness: {case_sensititive: false}
end
