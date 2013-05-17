class TransaccionesController < ApplicationController
  
  def index
  	    @transacciones = Transaccion.order("id DESC").page(params[:page]).per(10)
  end

end