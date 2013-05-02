Integra1::Application.configure do
	config.generators do |gen|
        gen.orm :active_record
    end

    config.action_mailer.delivery_method = :remail
	config.action_mailer.remail_settings = {
	  :app_id  => "hualpenpedidos1",
	  :api_key => "integra1"
	}
end