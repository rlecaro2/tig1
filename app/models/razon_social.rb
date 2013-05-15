class RazonSocial < ActiveRecord::Base
  establish_connection DIR_CONF
  self.table_name = 'razon_social'
  attr_accessible :nombre, :rut
end
