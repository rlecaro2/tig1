class UserMailer < ActionMailer::Base
  #default from: "from@example.com"

	def receive(email)
		Rails.logger.debug(emal)
		p = Pedido.new
		p.numero = -1
		p.save
	end
end
