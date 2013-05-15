class BodegasController < ApplicationController
  def index
    res=HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=getInfoBodegas&key=45XtPg")
    @objArray = JSON.parse(res)
    skus = HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=getSkuInfo&key=45XtPg")
    sku = JSON.parse(skus)
    @sku_id = sku[0]["sku"]
    @stock = HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=getStock&key=45XtPg&params="+sku[0]["sku"].to_s)
    @stock1 = HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/?function=getStock&key=45XtPg&params="+sku[1]["sku"].to_s)
  end

  def mover_stock

  end
end