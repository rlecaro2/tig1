class Pedido < ActiveRecord::Base
  establish_connection INTEGRA1_CONF
  attr_accessible :sku, :hora_llegada, :cantidad, :fecha, :rut, :fecha_llegada, :unidad, :status
  has_one :transaccion

  def self.process (id)

    begin

      QUEUE_LOGGER.info("Processing pedido "+id.to_s)
      p = Pedido.find_by_id(id)
      p.status = "Procesando"
      p.save
      #Se obtiene la direccion
      d = p.direccion
      #Se obtiene la información de contacto
      c = VtigerHelper.getContactByShipTo(p.direccion_id)

      vtiger_order_id = VtigerHelper.createSalesOrder(p.sku, p.rut ,c["cf_641"], p.fecha, p.cantidad, p.unidad)

      #Se ve si el cliente es preferencial
      esPreferencial = false
      if c["cf_650"].strip == "34.242.924-1" #este es el rut preferencial y cf_650 es el campo que guarda el rut en vTiger
        QUEUE_LOGGER.info("esPreferencial")
        esPreferencial = true
      else
        QUEUE_LOGGER.info("No esPreferencial")

      end


      #Obtencion de las reservas y los stocks
      reservado = Reserva.find_by_sku(p.sku)
      disponible = Bodega.obtener_stock(p.sku,55)
      if esPreferencial
        if p.cantidad <= disponible
         QUEUE_LOGGER.info("Rebajando cantidad reserva "+reservado.id.to_s)
         reservado.cantidad -= p.cantidad
         if reservado.cantidad < 0
          reservado.cantidad = 0
         end
         QUEUE_LOGGER.info("Guardando cantidad reserva "+reservado.id.to_s)
         reservado.save
        else
         p.status = "Quiebre por falta de stock"
         p.save
         VtigerHelper.cancelSalesOrder(vtiger_order_id)
         return
        end
      else #No es preferencial
        if p.cantidad > disponible - reservado.cantidad
         p.status = "Quiebre por falta de stock"
         p.save
         VtigerHelper.cancelSalesOrder(vtiger_order_id)
         return
        end
      end

      Bodega.preparar_despacho(p.sku,p.cantidad)

      #Acá habría que revisar si el clima permite el despacho
      #Si no se puede despachar hay que reversar la reserva
      #También hay que mover el stock de bodega
      infoSkus = Bodega.informacion_sku
      infoSku = infoSkus.select{|b| b["sku"].to_s == p.sku.strip}
      maxTemp = infoSku[0]["max_temp"].to_d
      minTemp = infoSku[0]["min_temp"].to_d
      lat = Direccion.find_by_shipto(p.direccion_id).latitude.to_d
      long = Direccion.find_by_shipto(p.direccion_id).longitude.to_d
      w = Metwit::Weather.in_location(lat,long)
      temp = w[0].weather["measured"]["temperature"].to_d-273.15
      buenClima = true
      if temp>maxTemp
        buenClima=false
      end
      if temp<minTemp
        buenClima=false
      end
      if not buenClima
        Bodega.mover(102,55,p.sku,p.cantidad)
        p.status = "Quiebre por clima"
        p.save
      else
        Bodega.despachar(p.sku,p.cantidad)
        p.status = "Despachado"
        p.save

        t = Transaccion.new
        t.pedido = p
        precio = Precio.find_precio_activo(p.sku.to_i).precio
        t.monto = precio.to_d * p.cantidad.to_d
        t.costos =   infoSku[0]["costo"].to_d * p.cantidad.to_d

        t.save
        QUEUE_LOGGER.info('Transaccion por ' +t.monto.to_s )

        Contabilidad.earning(t.monto.to_i)
        Contabilidad.cost(t.costos.to_i)

        VtigerHelper.dispatchSalesOrder(vtiger_order_id)
      end 

      QUEUE_LOGGER.info('Successfully processed pedido ' +id.to_s )

    rescue Exception => ex
      QUEUE_LOGGER.info(ex.message)
      QUEUE_LOGGER.info(ex.backtrace.join("\n"))
    end

  end


  def direccion
    d = Direccion.find_by_shipto(self.direccion_id)
    return d
  end
end