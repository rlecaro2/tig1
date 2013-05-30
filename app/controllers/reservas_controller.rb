class ReservasController < ApplicationController
  
  def index
  	    @reservas = Reserva.order("id DESC").page(params[:page]).per(10)
  end

end