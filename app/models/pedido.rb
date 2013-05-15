class Pedido < ActiveRecord::Base
  establish_connection INTEGRA1_CONF
  attr_accessible :sku, :hora_llegada, :cantidad, :fecha, :rut, :fecha_llegada, :unidad

  def self.process(id)
    p = find(id)
    p.status = "processing"
    p.save
  end
end
