class Transaccion < ActiveRecord::Base  
  self.table_name = 'transacciones'

  establish_connection INTEGRA1_CONF
  attr_accessible :ruta , :monto, :costos
  belongs_to :pedido
end