class UserMailer < ApplicationMailer
	default from: 'hungerswype@gmail.com'

	def registration_confirmation(user)
	    @user = user
	    mail(:to => "#{@user.name} <#{@user.email}>", :subject => "Hunger Swype Account Confirmation")
	end

end
