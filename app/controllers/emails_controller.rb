class EmailsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    if request.headers["Authorization"] != "integra1"
      return head(:unauthorized)
    end
    params[:email][:pedidos].each do |p|
      pedido = Pedido.new
      pedido.sku = p[:sku]
      pedido.hora_llegada = p[:horaLlegada]
      pedido.fecha = p[:fecha]
      pedido.fecha_llegada = p[:fechaLlegada]
      pedido.cantidad = p[:cantidad]
      pedido.direccion_id = p[:direccionId]
      pedido.unidad = p[:unidad]
      pedido.rut = p[:rut]
      pedido.status = "Recibido"
      pedido.save
      QC.enqueue "Pedido.process", pedido.id
    end
  head :ok
  end

end
