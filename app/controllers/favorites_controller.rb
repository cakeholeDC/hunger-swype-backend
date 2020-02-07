class FavoritesController < ApplicationController

	def create
		user = User.find(params[:userID])


		favExists = Favorite.find_by(user: User.find(params[:userID]), recipe_id: params[:recipe][:id])

		if !favExists
			Favorite.create(user: user, recipe_id: params[:recipe][:id])
		else
			favExists.destroy
		end

		render json: user.favorite_recipes
	end
end
