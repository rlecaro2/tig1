class CreateRazonSocial < ActiveRecord::Migration
  def up
    create_table :razon_social do |t|
      t.string :nombre, :limit => 255, :null=>false
      t.string :rut, :limit => 12
    end
  end

  def down
  end
end
