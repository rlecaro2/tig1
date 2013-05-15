class CreateReservas < ActiveRecord::Migration
  def change
    create_table :reservas do |t|
      t.string :sku
      t.float :cantidad
      t.timestamps
    end
  end
end
