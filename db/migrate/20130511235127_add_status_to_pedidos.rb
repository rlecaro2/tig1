class AddStatusToPedidos < ActiveRecord::Migration
  def change
     change_table :pedidos do |t|
      t.string :status, :default => "received"
    end
  end
end
