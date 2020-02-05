class UsersController < ApplicationController

	def profile
        token = request.headers["Authentication"]

        payload = decode(token)

        user = User.find(payload["musician_id"])

        render json: user.to_json(
            except: [:password_digest, :updated_at, :created_at],
        )
    end

    def create
        user = User.create(
            username: params[:username], 
            password: params[:password], 
            name: params[:name], 
            region: params[:region], 
            # email: params[:email], 
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
            # email: params[:email], 
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
