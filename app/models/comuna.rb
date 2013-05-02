class Comuna < ActiveRecord::Base
  establish_connection DIR_CONF
  attr_accessible :nombre
  belongs_to :region
end
