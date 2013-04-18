class CreateComunas < ActiveRecord::Migration
  def up
    create_table :comunas do |t|
      t.string :nombre, :limit => 255, :null=>false
      t.references :region
    end
  end

  def down
  end
end
