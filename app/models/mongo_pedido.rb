class MongoPedido
  include Mongoid::Document
  field :sku, type: String
  field :rut, type: String
  field :cantidad, type: Integer
  field :unidad, type: String
  field :status, type: String
  field :costos, type: Float
  field :ingresos, type: Float
  field :fecha, type: Date
  field :fecha_llegada, type: Date
  field :hora_llegada, type: Time 

  embedded_in :reporte

  def self.createFrom(pedido, reporte)
    
    ingresos = 0
    costos = 0
    if pedido.status.casecmp("Despachado") == 0
      t = pedido.transaccion
      ingresos = t.monto
      costos = t.costos
    end

    mongo = MongoPedido.new(
      sku: pedido.sku,
      rut: pedido.rut,
      cantidad: pedido.cantidad,
      unidad: pedido.unidad,
      status: pedido.status,
      costos: costos,
      ingresos: ingresos,
      fecha: pedido.fecha,
      fecha_llegada: pedido.fecha_llegada,
      hora_llegada: pedido.hora_llegada,
      reporte: reporte
    )
    
    mongo.save
    return mongo
  end

end
