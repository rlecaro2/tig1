class CreateDirecciones < ActiveRecord::Migration
  def change
  	create_table :direcciones do |t|
  	  t.string :rs, :limit => 12, :null => false
  	  t.string :direccion, :limit => 255, :null => false
  	  t.string :num, :limit => 255, :null => false
  	  t.string :depto, :limit => 255
  	  t.string :otros, :limit => 255
  	  t.string :cliente_direccion_id, :limit => 255, :null => false
	  t.timestamps
	end
  end

end
