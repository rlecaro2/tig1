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
 if c["cf_650"] == "34.242.924-1"
 	esPreferencial=true
 end
 #Obtencion de las reservas y los stocks
 reservado=Reserva.find_by_sku(p.sku)
 #disponible=Bodegas.obtener_stock_disponible(p.sku,55)
 if esPreferencial
 	if p.cantidad <= disponible
 	 reservado.cantidad -= p.cantidad
 	 if reservado.cantidad <0
 	 reservado.cantidad=0
 	 end
 	 reservado.save
 	else
 	 p.status="Quiebre por falta de stock"
 	 p.save
 	 return
 	end
 else
 	if p.cantidad > disponible-reservado.cantidad
 	 p.status="Quiebre por falta de stock"
 	 p.save
 	 return
 	end
 end

 #Bodegas.traspaso(p.sku,p.cantidad,"disponible","despacho")

 #Acá habría que revisar si el clima permite el despacho
 #Si no se puede despachar hay que reversar la reserva
 #También hay que mover el stock de bodega
 buenClima=true

 if not buenClima
 	#Bodegas.traspaso(p.sku,p.cantidad,"despacho","disponible")
 else
 	#Bodegas.despachar(p.sku,p.cantidad)
 end
end

end