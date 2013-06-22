class CreateTransacciones < ActiveRecord::Migration
  def change
    create_table :transacciones do |t|
      t.references :pedido
      t.string :ruta
      t.string :monto
       
      t.timestamps
    end
  end
end