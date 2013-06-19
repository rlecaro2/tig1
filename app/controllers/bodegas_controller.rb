class BodegasController < ApplicationController

  def index
    @objArray = Bodega.informacion
  end

  def consulta
    @sku = params['sku']
    stocks = Bodega.obtener_info_stock(@sku)
    info = Bodega.informacion

    @objArray = info

    begin
      @objArray.each do |o|
        o['cantidad_sku'] = 0
        stocks.each do |s|
          if o['almacenId'] == s['almacenId']
             o['cantidad_sku'] = s['libre']
          end
        end
      end
    rescue Exception => e
      @objArray = []
    end
    
  end

  def reponer  
    sku = params[:sku]    
    almacenId = params[:almacendId]

    stockActual = Bodega.reponer(sku, almacenId)

    producto = VtigerHelper.getProductBySku(sku)
    descr = producto['cf_660']

    Twitter.update("¡ Hemos repuesto " + descr + " !")

    head :ok
  end

end