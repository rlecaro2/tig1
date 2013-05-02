class Pedido < ActiveRecord::Base
  establish_connection DIR_CONF
  attr_accessible :nombre, :rut
end
