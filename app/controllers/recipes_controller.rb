require 'json'

class RecipesController < ApplicationController

	def show
		recipe = Recipe.find(params[:id])
		
		render json:recipe.to_json#( include: :step_by_step)
	end
end
