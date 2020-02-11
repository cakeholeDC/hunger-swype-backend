class UsersController < ApplicationController

	def profile
        token = request.headers["Authentication"]

        payload = decode(token)

        user = User.find(payload["user_id"])
        render json: user.to_json(
            except: [:password_digest, :updated_at, :created_at],
            include: [:diets, :favorite_recipes]
        )
    end

    def show
        user = User.find(params[:id])
        render json: user.to_json(
            except: [:password_digest, :updated_at, :created_at],
            include: [:diets, :favorite_recipes]
        )
    end

    def create
        @user = User.new(
            username: params[:username], 
            password: params[:password], 
            name: params[:name], 
            region: params[:region], 
            email: params[:email], 
            avatar: params[:avatar], 
        )

        if @user.save
            @user.send_confirmation_email

            # moved token creation to confirm_email
            # token = encode({ user_id: user.id })
            # render json: {
            #     jwt: token,
            #     currentUser: user.to_json(
            #         except: [:password_digest, :updated_at, :created_at],
            #         include: [:diets, :favorite_recipes]
            #     )
            # }

            render json: {
                error: true,
                status: :created,
                message: "Account Created. To confirm your account, please follow the link in your email" 
                }, status: :created
        else
            render json: {
                error: true,
                status: :not_acceptable,
                message: "Username is not available",
                }, status: :not_acceptable
        end

    end

    def confirm_email
        user = User.find_by_confirm_token(params[:token])
        if user
          user.email_activate
          token = encode({ user_id: user.id })
          render json: {
            jwt: token,
            currentUser: user.to_json(
                except: [:password_digest, :updated_at, :created_at],
                include: [:diets, :favorite_recipes]
            ),
            error: false,
            status: :success,
            message: "Account Confirmed."
            }, status: :success
        else
            render json: {
                error: true,
                status: :unauthorized,
                message: "Sorry. User does not exist"
                }, status: :unauthorized
        end
    end

    def update
        user = User.find(params[:id])
        user.update(
            username: params[:username], 
            password: params[:password], 
            name: params[:name], 
            region: params[:region], 
            email: params[:email], 
            avatar: params[:avatar], 
        )

        token = encode({ user_id: user.id })
        render json: {
            jwt: token,
            currentUser: user.to_json(
                except: [:password_digest, :updated_at, :created_at],
                include: [:diets, :favorite_recipes]
            )
        }
    end

end
