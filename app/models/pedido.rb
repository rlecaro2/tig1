class Pedido < ActiveRecord::Base
  establish_connection INTEGRA1_CONF
  attr_accessible :sku, :hora_llegada, :cantidad, :fecha, :rut, :fecha_llegada, :unidad
  belongs_to :direccion
end
