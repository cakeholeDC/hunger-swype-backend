class Course < ApplicationRecord
	has_many :dish_courses
	has_many :dishes, through: :dish_courses
end
