class Api::V1::AuthController < ApplicationController

	def create
		userInstance = User.find_by(username: params[:username])

		# isUserFound?
		if userInstance
			
			# canUserBeAuthenticated?
			if userInstance.authenticate(params[:password])
				
				# setUserToken
				token = encode({ musician_id: userInstance.id })

				# renderSerializedUserData
				render json: {
					currentUser: userInstance.to_json(
				            except: [:updated_at, :created_at], 
						),
						jwt: token
						}, status: :accepted
			# userExistsWithoutAuth
			else
				render json: {
					error: true,
					message: "Incorrect Password"
					}, status: :unauthorized
			end
		#userDoesNotExist
		else
			render json: {
				error: true,
				message: "Username not found"
				}, status: :not_acceptable
			
		end
	end
end
