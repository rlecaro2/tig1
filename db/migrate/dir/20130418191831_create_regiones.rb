class CreateRegiones < ActiveRecord::Migration
  def up
    create_table :regiones do |t|
      t.string :nombre, :limit => 255, :null=>false
    end
  end

  def down
  end
end
