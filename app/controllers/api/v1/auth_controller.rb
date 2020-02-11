class Api::V1::AuthController < ApplicationController

	def create
		userInstance = User.find_by(username: params[:username])

		# isUserFound?
		if userInstance

			#isAccountConfirmed?
			if userInstance.email_confirmed
			
				# canUserBeAuthenticated?
				if userInstance.authenticate(params[:password])
					
					# setUserToken
					token = encode({ user_id: userInstance.id })

					# renderSerializedUserData
					render json: {
						currentUser: userInstance.to_json(
					            except: [:updated_at, :created_at],
					            include: [:diets, :favorite_recipes] 
							),
							jwt: token,
							status: :accepted
							}, status: :accepted
				# userExistsWithoutAuth
				else
					render json: {
						error: true,
						status: :unauthorized,
						message: "Incorrect Password"
						}, status: :unauthorized
				end

			else
				render json: {
					error: true,
					status: :locked,
					message: "Account Not Confirmed. Please check your email.",
					}, status: :locked
			end
		#userDoesNotExist
		else
			render json: {
				error: true,
				status: :not_acceptable,
				message: "Username not found"
				}, status: :not_acceptable
			
		end
	end
end
