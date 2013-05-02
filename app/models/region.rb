class Region < ActiveRecord::Base
  establish_connection DIR_CONF
  self.table_name = 'regiones'
  attr_accessible :nombre
end
