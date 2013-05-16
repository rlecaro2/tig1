class Pedido < ActiveRecord::Base
  establish_connection INTEGRA1_CONF
  attr_accessible :sku, :hora_llegada, :cantidad, :fecha, :rut, :fecha_llegada, :unidad, :status


  def self.process (id)

    p = Pedido.find_by_id(id)
    p.status = "Procesando"
    p.save
    #Se obtiene la direccion
    d = p.direccion
    #Se obtiene la información de contacto
    c = VtigerHelper.getContactByShipTo(p.direccion_id)

    VtigerHelper.createSalesOrder(p.sku, p.rut ,c["cf_641"], p.fecha, p.cantidad, p.unidad)

    #Se ve si el cliente es preferencial
    esPreferencial = false
    if c["cf_650"] == "34.242.924-1" #este es el rut preferencial y cf_650 es el campo que guarda el rut en vTiger
      esPreferencial = true
    end

    #Obtencion de las reservas y los stocks
    reservado = Reserva.find_by_sku(p.sku)
    disponible = Bodega.obtener_stock(p.sku,55)
    if esPreferencial
      if p.cantidad <= disponible
       reservado.cantidad -= p.cantidad
       if reservado.cantidad < 0
        reservado.cantidad = 0
       end
       reservado.save
      else
       p.status = "Quiebre por falta de stock"
       p.save
       return
      end
    else #No es preferencial
      if p.cantidad > disponible - reservado.cantidad
       p.status = "Quiebre por falta de stock"
       p.save
       return
      end
    end

    Bodega.preparar_despacho(p.sku,p.cantidad)

    #Acá habría que revisar si el clima permite el despacho
    #Si no se puede despachar hay que reversar la reserva
    #También hay que mover el stock de bodega
    buenClima = true
    if not buenClima
      #Bodegas.traspaso(p.sku,p.cantidad,"despacho","disponible")
    else
      Bodega.despachar(p.sku,p.cantidad)
      p.status = "Despachado"
      p.save

      t = Transaccion.new
      t.pedido = p
      t.save
    end
  end

  def direccion
    d = Direccion.find_by_shipto(self.direccion_id)
    return d
  end

end