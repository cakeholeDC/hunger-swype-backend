class RecipesController < ApplicationController

	def show
		recipe = Recipe.find(params[:id])
		
		render json:recipe
	end
end
