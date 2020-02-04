class CoursesController < ApplicationController

	def index
		courses = Course.all.map do |course|
			course.name
		end

		render json: courses
	end

end
