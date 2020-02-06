class DishesController < ApplicationController

	def index
		# byebug
		dishes = Dish.first

		render json:dishes.to_json( include: :recipe)#[recipe: {only: [:id, :title, :rating, :servings, :cook_time, :photo]}])
		
	end

	def match
		# byebug
		## find the dishes
		# dishes = []
		
		## that have cuisine types matching any of the items in params[:cuisinesFilter]
		# params[:cuisinesFilter].each do |cuisine|
		# 	dishes += Cuisine.find_by(name: cuisine).dishes
		# end
		
		# ## that have course types matching any of the items in params[:coursesFilter]
		# params[:coursesFilter].each do |course|
		# 	dishes += Course.find_by(name: course).dishes
		# end

		# ## that have diets matching any of the items in params[:dietsFilter]
		# params[:dietsFilter].each do |diet|
		# 	# dishes += Diet.find_by(name: diet).dishes
			
		# 	filteredDishes += dishes.filter do |dish|
		# 		dish.getDiets.include?(diet)
		# 	end
		# end

		## now remove any of the matches that contain any of the keywords in params[:keywords]
		## @TODO


		## first, get all the courses
		## then, filter those results by cuisine
		## then, filter those results by diet

		## IF there's not enough results, 
		## remove the cuisine filter

		dishes = Dish.joins(:diets, :cuisines, :courses).where(courses: {name: params[:coursesFilter]}).where(cuisines: {name: params[:cuisinesFilter]}).where(diets: {name: params[:dietsFilter]}).uniq	

		# byebug
		if dishes.length < 10	
			dishes = dishes + Dish.joins(:diets).where(diets: {name: params[:dietsFilter]}).limit(25)
		end

		dishes.uniq!

		render json:dishes.to_json( include: [recipe: {only: [:id, :title, :rating, :servings, :cook_time, :photo]}])
	end
end
