class UserMailer < ActionMailer::Base
  #default from: "from@example.com"

	def receive(email)
		Rails.logger.debug(email)
		p = Pedido.new
		p.numero = "BORRAME"
		p.save
	end
end
