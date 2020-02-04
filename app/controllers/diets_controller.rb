class DietsController < ApplicationController

	def index
		diets = Diet.all.map do |diet|
			diet.name
		end

		render json: diets
	end
end
