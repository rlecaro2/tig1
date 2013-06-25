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

  def reportes_diarios
    @reportes = Reporte.desc(:fecha).page(params[:page]).per(50).all.to_a

    respond_to do |format|
      format.html
    end

  end

  def descargar_excel
    @reporte = Reporte.find(params[:id])
    respond_to do |format|
      format.xlsx {
        render xlsx: "descargar_excel", disposition: "attachment", filename: "reporte.xlsx"
      }
    end
  end

end