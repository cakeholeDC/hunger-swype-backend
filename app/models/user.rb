class User < ApplicationRecord
	has_many :favorites
	has_many :dishes, through: :favorites

	has_secure_password
	validates :username, uniqueness: {case_sensititive: false}
end
