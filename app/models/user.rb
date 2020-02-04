class User < ApplicationRecord
	has_many :favorites
	has_many :dishes, through: :favorites
end
