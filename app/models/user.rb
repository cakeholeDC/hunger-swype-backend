class User < ApplicationRecord
	has_many :favorites
	has_many :recipes, through: :favorites

	has_many :user_diets
	has_many :diets, through: :user_diets

	has_secure_password
	validates :username, uniqueness: {case_sensititive: false}

	before_create :confirmation_token

	def favorite_recipes
		self.favorites.map do |favorite|
			favorite.recipe
		end		
	end

	def email_activate
		self.email_confirmed = true
		self.confirm_token = nil
		save!(:validate => false)
	end

	def send_confirmation_email
		UserMailer.registration_confirmation(self).deliver
	end

	private
	
	def confirmation_token
	    if self.confirm_token.blank?
	        self.confirm_token = SecureRandom.urlsafe_base64.to_s
	    end
	end
end