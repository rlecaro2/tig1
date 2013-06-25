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

  def reporte_a_excel
    p = Axlsx::Package.new
    wb = p.workbook

    reportes = Reporte.all #CAMBIAR DESPUES!!!
    wb.add_worksheet(:name => "Pedidos") do |sheet|
      sheet.add_row ["Fecha Pedido","SKU", "Rut", "Cantidad", "Unidad", "Estado", "Costos", "Ingresos", "Fecha Llegada", "Hora Llegada"]

    end
    p.serialize("example2.xlsx")
  end

end