class Reserva < ActiveRecord::Base
	establish_connection INTEGRA1_CONF
	attr_accessible :sku, :cantidad
	
	def self.mega_update
		
		Reserva.destroy_all
		session = GoogleDrive.login("hualpenpedidos@gmail.com", "tallerdeintegracion")
		ws = session.spreadsheet_by_key("0AhRzyWALVmYKdHZSTk1hUmpvR1JjRGFjX0ZZQjhwLVE").worksheets[0]
		
		i = 2
		while (true)
			if (ws[i,1] == "")
				break
			end
			sku = ws[i,1]
			cantidad = ws[i,2]	
			r = Reserva.new
			r.sku = sku
			r.cantidad = cantidad
			r.save

			i += 1
		end

	end
	
end