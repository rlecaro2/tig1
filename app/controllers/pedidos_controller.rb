class PedidosController < ApplicationController

  def index
    @pedidos = Pedido.order(:fecha).page(params[:page]).per(10)
  end

  # GET /pedidos/1
  def show
  	@pedido = Pedido.find(params[:id])
  	@direccion = Direccion.find_by_shipto(@pedido.direccion_id)

  	@json = @direccion.to_gmaps4rails

  	respond_to do |format|
  		format.html # showmap.html.erb
  	end
  end

end
