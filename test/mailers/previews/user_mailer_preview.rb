class UserMailerPreview < ActionMailer::Preview

	def registration_confirmation
	    @user = User.last
	    
	    UserMailer.registration_confirmation(@user)
	end

end
