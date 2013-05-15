class AddLongitudeAndLatitudeToDirecciones < ActiveRecord::Migration
  def change
    add_column :direcciones, :latitude, :float
    add_column :direcciones, :longitude, :float
  end
end

