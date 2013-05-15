class PedidosController < ApplicationController
	layout 'application'

  def index
    @pedidos = Pedido.all    
  end

  # GET /pedidos/1/showmap
  def show_map
  	@pedido = Pedido.find(params[:pedido_id])
  	@direccion = Direccion.first

  	@json = @direccion.to_gmaps4rails

  	respond_to do |format|
  		format.html # showmap.html.erb
  	end
  end

end
