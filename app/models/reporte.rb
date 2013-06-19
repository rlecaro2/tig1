class Reporte
  include Mongoid::Document

  field :quiebres, type: Integer
  field :despachos, type: Integer
  field :costos, type: Float
  field :ingresos, type: Float

  
  embeds_many :mongo_pedidos

  def self.reportar
    @infoSkus = Bodega.informacion_sku

    reporte = Reporte.new()
    reporte.save
    pedidos = Pedido.where(fecha: Date.today).where(["status != 'recibido' OR status != 'procesando'"])
    pedidos.each do |pedido|
      MongoPedido.createFrom(pedido, reporte)
    end

    reporte.despachos = reporte.mongo_pedidos.where(status: "despachado").count
    reporte.quiebres = reporte.mongo_pedidos.count - reporte.despachos

    reporte.costos = reporte.mongo_pedidos.sum(:costos)
    reporte.ingresos = reporte.mongo_pedidos.sum(:ingresos)

    reporte.save
  end

end