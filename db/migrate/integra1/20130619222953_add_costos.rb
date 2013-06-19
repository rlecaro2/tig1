class AddCostos < ActiveRecord::Migration
  def change
     change_table :transacciones do |t|
      t.string :costos
    end
  end
end
