class EditPedidos < ActiveRecord::Migration
  def change
    remove_column :pedidos, :numero
    change_table :pedidos do |t|
      t.string :sku
      t.time :hora_llegada
      t.date :fecha
      t.date :fecha_llegada
      t.float :cantidad
      t.integer :direccion_id
      t.string :unidad
    end
  end
end
