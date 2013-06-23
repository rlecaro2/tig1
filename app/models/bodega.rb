class Bodega

	def self.informacion
		begin
			res = HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=getInfoBodegas&key=45XtPg")
			objArray = JSON.parse(res)
			#objArray[0]["almacenId"]
			return objArray
		rescue Exception => e
			return nil
		end
	end

	def self.informacion_sku
		begin
			res = HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=getSkuInfo&key=45XtPg")
			objArray = JSON.parse(res)
			#objArray[0]["sku"] primer sku
			return objArray
		rescue Exception => e
			return nil
		end
	end

	def self.obtener_info_stock (sku)
		begin
			res = HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=getStock&key=45XtPg&params="+sku.to_s.strip)
			objArray = JSON.parse(res)
			#objArray[0]["sku"] primer sku
			return objArray
		rescue Exception => e
			return nil
		end
		
	end

	def self.mover(almacen_desde,almacen_hasta,sku, units)
		BODEGA_LOGGER.info("Traspasando #{units.to_s} unidades de sku #{sku.to_s} desde #{almacen_desde.to_s} a #{almacen_hasta.to_s} ...")
		begin
			resp=HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=moverStock&key=45XtPg&params="+almacen_desde.to_s.strip+","+almacen_hasta.to_s.strip+","+sku.to_s.strip+","+units.to_i.to_s)
		rescue Exception => e
			#HTTParty::Error => e
			BODEGA_LOGGER.info("Error al traspasar #{e.message}")
   	        BODEGA_LOGGER.info(e.backtrace.join("\n"))
			return false
		end
		BODEGA_LOGGER.info("Traspaso exitoso")
		return true
	end

	def self.preparar_despacho(sku, units)	
		BODEGA_LOGGER.info("Traspasando #{units.to_s} unidades de sku #{sku.to_s} desde 55 a 102 ...")	
		begin
			resp = HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=moverStock&key=45XtPg&params=55,102,"+sku.to_s.strip+","+units.to_i.to_s)
		rescue Exception => e
			#HTTParty::Error => e
			BODEGA_LOGGER.info("Error al traspasar #{e.message}")
   	        BODEGA_LOGGER.info(e.backtrace.join("\n"))
			return false
		end
		BODEGA_LOGGER.info("Traspaso exitoso")
		return true

	end

	def self.obtener_stock(sku, almacen)		
		begin
			resp=HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=getStock&key=45XtPg&params="+sku.to_s.strip)			
		rescue
			#HTTParty::Error => e
			return false
		end

		stock = JSON.parse(resp)
		b = 0
		stock.each do|a|
			if(a["almacenId"].to_i == almacen.to_i)
				b = a["libre"].to_i
			end
		end
		return b
	end

	def self.despachar(sku,cantidad)
		BODEGA_LOGGER.info("Despachando #{cantidad.to_i.to_s} unidades de sku #{sku.to_s} ...")	
		begin
			resp=HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=despacharStock&key=45XtPg&params=102,"+sku.to_s.strip+","+cantidad.to_i.to_s)
		rescue Exception => e
			BODEGA_LOGGER.info("Error al despachar #{e.message}")
   	        BODEGA_LOGGER.info(e.backtrace.join("\n"))
			return false
		end
		BODEGA_LOGGER.info("Despacho exitoso")
		return true
	end

	def self.reponer(sku, almacen)
		BODEGA_LOGGER.info("Reponiendo sku #{sku.to_s} desde #{almacen.to_s}")	
		stock = Bodega.obtener_stock(sku, almacen)
		Bodega.mover(almacen,55,sku,stock.to_i)
		return stock
	end
		
#stock disponible 55(me lo de) sku 
#despacho,sku y cantidad

end