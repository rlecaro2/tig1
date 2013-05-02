class Direccion < ActiveRecord::Base
  establish_connection DIR_CONF
  self.table_name = 'direcciones'
  attr_accessible :shipto, :rut, :calle, :numero, :depto, :otro, :cliente_direccion_id
  belongs_to :comuna
end
