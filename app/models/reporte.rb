class Reporte
  include Mongoid::Document

  field :fecha, type: Date
  field :quiebres, type: Integer
  field :despachos, type: Integer
  field :costos, type: Float
  field :ingresos, type: Float

  
  embeds_many :mongo_pedidos

  def self.consolidar(fecha)

    reporte = Reporte.new(fecha: fecha)

    pedidos = Pedido.where(fecha: fecha).where(["status != 'recibido' OR status != 'procesando'"])
    pedidos.each do |pedido|
      MongoPedido.createFrom(pedido, reporte)
    end

    reporte.despachos = reporte.mongo_pedidos.select{|a| a.status=='Despachado'}.count
    reporte.quiebres = reporte.mongo_pedidos.count - reporte.despachos

    reporte.costos = 0
    reporte.ingresos = 0

    reporte.mongo_pedidos.each do |mp|
      reporte.costos += mp.costos.to_f
      reporte.ingresos += mp.ingresos.to_f
    end

    reporte.save
  end

  def self.ingresos_on(date)
    r = Reporte.where(fecha: date).first
    if r.nil?
      return 0
    else
      return r.ingresos
    end
  end

end