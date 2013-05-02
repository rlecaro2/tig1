class Pedido < ActiveRecord::Base

	establish_connection INTEGRA1_CONF
	
	attr_accessible :numero
end
