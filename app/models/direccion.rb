class Direccion < ActiveRecord::Base
  establish_connection DIR_CONF
  self.table_name = 'direcciones'
  attr_accessible :shipto, :rut, :calle, :numero, :depto, :otro, :cliente_direccion_id, :comuna_id

  acts_as_gmappable
  
  belongs_to :comuna

  def gmaps4rails_address
  	"#{calle}, #{numero}, #{comuna.nombre} , Chile"
	end
end
