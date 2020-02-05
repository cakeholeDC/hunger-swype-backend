class ApplicationController < ActionController::API
	def secret_key
		Rails.application.secrets.secret_key_base
	end

	def encode(payload)
		JWT.encode(payload, secret_key, "HS512")
	end

	def decode(token)
		JWT.decode(token, secret_key, true, { algorithm:"HS512" })[0]
	end
end
