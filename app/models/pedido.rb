class Pedido < ActiveRecord::Base
  establish_connection INTEGRA1_CONF
  attr_accessible :sku, :hora_llegada, :cantidad, :fecha, :rut, :fecha_llegada, :unidad


	def self.process (id)
		p=Pedido.find_by_id(id)
		#Se obtiene la direccion
		d=Direccion.find_by_rut(p.rut)
		#Se obtiene la información de contacto
		c=VtigerHelper.getContactByRut(p.rut)
		#Se ve si el cliente es preferencial
		esPreferencial=false
		if (c["cf_650"] == "34.242.924-1")
			esPreferencial=true
		end
		#Obtencion de los stocks
		reservado=Reservas.get(p.sku)
		#disponible=Bodegas.obtener_stock_disponible(p.sku)
		if (esPreferencial)
			if (p.cantidad <= disponible)
				Reservas.
		end
		else

		end
	end

end