class AddRutPedidos < ActiveRecord::Migration
  def change
     change_table :pedidos do |t|
      t.string :rut
    end
  end
end
