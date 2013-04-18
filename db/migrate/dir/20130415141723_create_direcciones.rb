class CreateDirecciones < ActiveRecord::Migration
  def change
  	create_table :direcciones do |t|
      t.string :shipto
  	  t.string :rut, :limit => 12, :null => false
  	  t.string :calle, :limit => 255, :null => false
  	  t.string :numero, :limit => 255, :null => false
  	  t.string :depto, :limit => 255
  	  t.string :otro, :limit => 255
  	  t.string :cliente_direccion_id, :limit => 255, :null => false
      t.references :comuna
	    t.timestamps
	end
end
end
