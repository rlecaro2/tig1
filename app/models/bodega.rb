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
			res = HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=getStock&key=45XtPg&params="+sku.to_s)
			objArray = JSON.parse(res)
			#objArray[0]["sku"] primer sku
			return objArray
		rescue Exception => e
			return nil
		end
		
	end

	def self.mover(almacen_desde,almacen_hasta,sku, units)		
		begin
			resp=HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=moverStock&key=45XtPg&params="+almacen_desde.to_s+","+almacen_hasta.to_s+","+sku.to_s+","+units.to_s)
		rescue 
			#HTTParty::Error => e
			return false
		end
		return true
	end

	def self.preparar_despacho(sku, units)		
		begin
			resp = HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=moverStock&key=45XtPg&params=55,102,"+sku.to_s+","+units.to_s)
		rescue
			#HTTParty::Error => e
			return false
		end
		return true

	end

	def self.obtener_stock(sku, almacen)		
		begin
			resp=HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=getStock&key=45XtPg&params="+sku.to_s)			
		rescue
			#HTTParty::Error => e
			return false
		end

		stock = JSON.parse(resp)
		b=0
		stock.each do|a|
			if(a["almacenId"]==almacen)
				b = a["libre"]
			end
		end
		return b
	end

	def self.despachar(sku,cantidad)		
		begin
			resp=HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=despacharStock&key=45XtPg&params=102,"+sku.to_s+","+cantidad.to_s)
		rescue
			return false
		end
		return true
	end

	def self.reponer(sku, almacen)
		stock = Bodega.obtener_stock(sku, almacen)
		Bodega.mover(almacen,55,sku,stock)
		return stock
	end
		
#stock disponible 55(me lo de) sku 
#despacho,sku y cantidad

end