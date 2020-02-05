class UsersController < ApplicationController

	def create
		byebug
        user = User.create(
            username: params[:username], 
            password: params[:password], 
            name: params[:name], 
            region: params[:region], 
            birthdate: params[:birthdate], 
            avatar: params[:avatar], 
        )

        token = encode({ user_id: user.id })
        render json: {
            jwt: token,
            currentUser: user.to_json(
                except: [:updated_at, :created_at]
            )
        }
    end

    def update
        user = User.find(params[:id])
        user.update(
            username: params[:username], 
            password: params[:password], 
            name: params[:name], 
            region: params[:region], 
            birthdate: params[:birthdate], 
            avatar: params[:avatar], 
        )

        token = encode({ user_id: user.id })
        render json: {
            jwt: token,
            currentUser: user.to_json(
                except: [:updated_at, :created_at]
            )
        }
    end

end
