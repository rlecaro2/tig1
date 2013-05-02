class EmailsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def create
		if request.headers["Authorization"] != "hualpenpedidos1"
			return head(:unauthorized)
		end
		UserMailer.receive(params[:email][:raw])
	head :ok
	end

end
