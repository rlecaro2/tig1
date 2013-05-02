class PedidosController < ActionController::Base
  def index
    @pedidos = Pedido.all    
  end
end
