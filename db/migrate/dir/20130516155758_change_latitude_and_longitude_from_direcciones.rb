class ChangeLatitudeAndLongitudeFromDirecciones < ActiveRecord::Migration
  def change
  	change_column :direcciones, :latitude, :decimal, precision: 10, scale: 7
  	change_column :direcciones, :longitude, :decimal, precision: 10, scale: 7
  end
end
