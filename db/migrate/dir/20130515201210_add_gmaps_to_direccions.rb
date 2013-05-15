class AddGmapsToDireccions < ActiveRecord::Migration
  def change
    add_column :direcciones, :gmaps, :boolean
  end
end
