class PedidosController < ActionController::Base

  def index
    @pedidos = Pedido.all    
  end

  def process
  	
  end

end
