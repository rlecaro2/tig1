class DashboardsController < ApplicationController

  def index
    reportes = Reporte.all.to_a
    ProcessInfo(reportes)



    respond_to do |format|
      format.html # showmap.html.erb
    end
  end

  def ProcessInfo(reportes)
    @ingresos_costos = []
    @despachos_quiebres = []
    @quiebres = []
    reportes.each do |reporte|
      @ingresos_costos << [reporte.fecha, reporte.ingresos, reporte.costos]

      @despachos_quiebres << [reporte.fecha, reporte.despachos, reporte.quiebres]
    end

  end

end