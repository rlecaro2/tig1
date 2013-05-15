class PedidosController < ApplicationController

  def index
    @pedidos = Pedido.all    
  end

  # GET /pedidos/1/showmap
  def show_map
  	@pedido = Pedido.find(params[:pedido_id])
  	@direccion = Direccion.find_by_shipto(@pedido.direccion_id)

  	@json = @direccion.to_gmaps4rails

  	respond_to do |format|
  		format.html # showmap.html.erb
  	end
  end

end
