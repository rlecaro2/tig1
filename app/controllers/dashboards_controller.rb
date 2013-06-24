class DashboardsController < ApplicationController

  def index
    reportes = Reporte.all.asc(:fecha).to_a
    #self.ProcessInfo(reportes)

    @ingresos_costos = []
    @despachos_quiebres = []
    reportes.each do |reporte|
      @ingresos_costos << [reporte.fecha.to_s, reporte.ingresos.to_s, reporte.costos.to_s]
      @despachos_quiebres << [reporte.fecha.to_s, reporte.despachos.to_s, reporte.quiebres.to_s]
    end

    respond_to do |format|
      format.html # showmap.html.erb
    end
  end

  def ProcessInfo(reportes)
    @ingresos_costos = []
    @despachos_quiebres = []
    reportes.each do |reporte|
      @ingresos_costos << [reporte.fecha.to_s, reporte.ingresos.to_s, reporte.costos.to_s]
      @despachos_quiebres << [reporte.fecha.to_s, reporte.despachos.to_s, reporte.quiebres.to_s]
    end
  end

end