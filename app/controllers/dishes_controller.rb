class DishesController < ApplicationController

	def index
		# byebug
		dishes = Dish.first

		render json:dishes.to_json( include: :recipe)#[recipe: {only: [:id, :title, :rating, :servings, :cook_time, :photo]}])
		
	end

	def match
		#Diet.find_by(name: "vegan").dishes.select do |dish| dish.courses.map do |course| course.name end.include?("dinner") end.length

		diets = params[:dietsFilter]
		courses = params[:coursesFilter]
		cuisines = params[:cuisinesFilter]

		dishes = Dish.joins(:diets).where(diets: {name: diets}).uniq
		
		# newDishes = dishes
		# filteredDishes = Array.new
		dishCuisines = dishes.select do |dish| 
			!(dish.get_cuisines & cuisines).empty? 
		end

		dishCourses = dishCuisines.select do |dish|
			!(dish.get_courses && courses).empty?
		end

		while dishCourses.length < 50 do
			
			add = dishes.sample
			
			if !dishCourses.include?(add) 
				dishCourses << add
			end

		end

		render json:dishCourses.to_json( include: [recipe: {only: [:id, :title, :rating, :servings, :cook_time, :photo]}])
	end
end
