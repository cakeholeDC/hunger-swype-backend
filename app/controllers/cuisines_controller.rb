class CuisinesController < ApplicationController

	def index
		cuisines = Cuisine.all.map do |cuisine|
			cuisine.name
		end

		render json: cuisines
	end
end
