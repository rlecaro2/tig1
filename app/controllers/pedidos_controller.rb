class PedidosController < ApplicationController

  def index
    @pedidos = Pedido.order("id DESC").page(params[:page]).per(10)
  end

  # GET /pedidos/1
  def show
  	@pedido = Pedido.find(params[:id])
  	@direccion = Direccion.find_by_shipto(@pedido.direccion_id)

  	@json = @direccion.to_gmaps4rails

    from = "-36.731455,-73.112297"
    
    @startLat = '"-36.731455"'
    @startLng = '"-73.112297"'
    @endLat = '"'+@direccion.latitude.to_s+'"'
    @endLng = '"'+@direccion.longitude.to_s+'"'

    to = @direccion.latitude.to_s+','+@direccion.longitude.to_s
    @dest = Gmaps4rails.destination( {"from"=>from , "to"=>to },options={}, output="pretty")

  	respond_to do |format|
  		format.html # showmap.html.erb
  	end
  end

  def tiempo

  end

end
