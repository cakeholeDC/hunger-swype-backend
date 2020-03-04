class DishesController < ApplicationController

	def index
		# byebug
		dishes = Dish.first

		render json:dishes.to_json( include: :recipe)#[recipe: {only: [:id, :title, :rating, :servings, :cook_time, :photo]}])
	end

	def match
		diets = params[:dietsFilter]
		cuisines = params[:cuisinesFilter]
		courses = params[:coursesFilter]

		## IF NO DIETS ARE SELECTED
		if diets.length < 1
			## USE ALL DISHES
			dishes = Dish.all
		else
			## ELSE USE DISHES THAT MATCH DIETS
			dishes = Dish.joins(:diets).where(diets: {name: diets}).uniq
		end

		## IF CUISINES ARE SELECTED
		if cuisines.length > 0
			## FILTER DIET RESULTS BY CUISINES
			dishCuisines = dishes.select do |dish| 
				!(dish.get_cuisines & cuisines).empty? 
			end
		else 
			## ELSE USE DIET RESULTS
			dishCuisines = dishes
		end

		## IF COURSES ARE SELECTED
		if courses.length > 0
			## FILTER CUISINE RESULTS BY COURSES
			dishCourses = dishCuisines.select do |dish|
				!(dish.get_courses && courses).empty?
			end
		else
			## ELSE USE CUISINE RESULTS
			dishCourses = dishCuisines
		end

		## WHILE THERE ARE LESS THAN 50 RESULTS
		while dishCourses.length < 50 do
			
			## PICK A RANDOM DISH (THAT MATCHES THE DIET PREFS)
			add = dishes.sample
			
			## IF IT'S NOT A DUPLICATE, ADD TO RESULTS
			if !dishCourses.include?(add) 
				dishCourses << add
			end

		end

		render json:dishCourses.to_json( include: [recipe: {only: [:id, :title, :rating, :servings, :cook_time, :photo]}])
	end
end
