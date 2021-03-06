# require_relative '../../api-data/apiDataToSeed.rb' ## imports API_DATA
files = [
  'KETOGENIC',
  'DAIRYFREE',
  'DINNERS',
  'FODMAP',
  'GLUTEN',
  'PALEOLITHIC',
  'PESCATARIAN',
  'RECIPES',
  'SUSTAINABLE',
  "VEGAN",
  "VEGETARIAN",
  "WHOLE"
]

API_DATA = {
  "recipes": []
}

files.each do |file|
  require_relative "./source/spoonacular-100-random-#{file.downcase}.rb"
  Object.const_get(file)[:recipes].each do |recipe|
    API_DATA[:recipes] << recipe
  end
end

API_DATA[:recipes].uniq! 

DishDiet.destroy_all
DishCuisine.destroy_all
DishCourse.destroy_all
UserDiet.destroy_all
Favorite.destroy_all
Diet.destroy_all
Cuisine.destroy_all
Course.destroy_all
Dish.destroy_all
Recipe.destroy_all

# require_relative '../API/spoonacular-100-random-vegan.json.rb'  ##imports VEGAN

## IMPORT DIETS, CUISINE, and COURSES first
diets = [
	"vegetarian",
	"vegan",
	"gluten free",
	"dairy free",
	"fodmap friendly",
	"whole 30",
	"ketogenic",
	"pescatarian",
	"paleolithic"


] 

diets.each do |item|
  Diet.create(name: item.downcase)
end

courses = [
	"starter",
	"appetizer",
	"antipasto",
	"lunch",
	"snack",
	"main dish",
	"side dish",
	"dinner",
	"soup",
	"seasoning",
	"marinade"
] 

courses.each do |item|
  Course.create(name: item.downcase)
end

cuisines = [
	"American",
	"Indian",
	"Vietnamese",
	"Asian",
	"Mediterranean",
	"Italian",
	"Eastern European",
	"European",
	"Greek",
	"French",
	"Mexican",
	"Spanish",
	"South American",
	"Latin American",
	"Southern",
	"German",
	"Japanese",
	"Thai"
] 

cuisines.each do |item|
  Cuisine.create(name: item.downcase)
end

API_DATA[:recipes].each do |recipe|
  
  #iterate through recipe.extendedIngredients and store as a string
  ingredients = recipe[:extendedIngredients].map do |ingredient|
    ingredient[:originalString]
  end
  #iterate through recipe.analyzedInstructions and reduce to the required data
  if recipe[:analyzedInstructions].length > 0
	  instructions = recipe[:analyzedInstructions][0][:steps].map do |instruction|
      instruction[:step]
	  end
  else
  	instructions = [recipe[:instructions]]
  end

  importRecipe = Recipe.find_or_create_by(
    api_id: recipe[:id],
    title: recipe[:title],
    photo: recipe[:image],
    rating: recipe[:spoonacularScore],
    servings: recipe[:servings],
    cook_time: recipe[:readyInMinutes],
    source_url: recipe[:sourceUrl],
    ingredients: ingredients.join('; '),
  )

  importRecipe.directions = instructions
  importRecipe.save

  dish = Dish.find_or_create_by(
    api_id: recipe[:id],
    photo: recipe[:image],
    is_recipe: true,
    recipe_id: importRecipe.id,
    restaurant_id: nil
  )

  ## DIET RELATIONSHIPS
  diets.each do |diet|
  	if diet.downcase == "ketogenic"
		recipe[diet.to_sym] == true
  		DishDiet.create(
  			dish_id: dish.id,
  			diet_id: Diet.find_or_create_by(name: diet.downcase).id
  		)
	elsif recipe[:diets].include?(diet.downcase)
		DishDiet.create(
			dish_id: dish.id,
			diet_id: Diet.find_or_create_by(name: diet.downcase).id
		)
	end
  end

  ## COURSE RELATIONSHIPS
  courses.each do |course| 
  	if recipe[:dishTypes].include?(course.downcase)  
  		course = "antipasto" if course.downcase == "antipasti"
  		course = "main dish" if course.downcase == "main course" 
  		DishCourse.create(
  			dish_id: dish.id,
  			course_id: Course.find_or_create_by(name: course.downcase).id
		)
  		# dish.courses.build(name: Course.find_or_create_by(name: course))
  	end
  end

  ## CUISINE RELATIONSHIPS
  cuisines.each do |cuisine|
  	if recipe[:cuisines].include?(cuisine)  
  		DishCuisine.create(
  			dish_id: dish.id,
  			cuisine_id: Cuisine.find_or_create_by(name: cuisine.downcase).id
  		)
  		# dish.cuisines.build(name: Cuisine.find_or_create_by(name: cuisine))
  	end
  end
  
  dish.save

end