class UserMailer < ActionMailer::Base
  #default from: "from@example.com"
	def receive(email)
		Rails.logger.debug(email)
	end
end
