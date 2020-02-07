class UserDietsController < ApplicationController

    def create
        user = User.find(params[:currentUser])

        user.diets.each do |diet|
        	if !params[:diets].include?(diet.name)
        		UserDiet.find_by(diet: diet, user: user).destroy
        	end
        end

        params[:diets].each do |diet_string|
        	diet = Diet.find_by(name: diet_string)
        	if !user.diets.include?(diet)
        		user.diets << diet
        	end
        end

        render json: user.to_json(
            except: [:password_digest, :updated_at, :created_at],
            include: [:diets, :favorites]
        )
    end

end
