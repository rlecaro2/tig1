# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130515201834) do

  create_table "comunas", :force => true do |t|
    t.string  "nombre",    :null => false
    t.integer "region_id"
  end

  create_table "direcciones", :force => true do |t|
    t.string   "shipto"
    t.string   "rut",                  :limit => 12,                                :null => false
    t.string   "calle",                                                             :null => false
    t.string   "numero",                                                            :null => false
    t.string   "depto"
    t.string   "otro"
    t.string   "cliente_direccion_id",                                              :null => false
    t.integer  "comuna_id"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.boolean  "gmaps"
    t.decimal  "latitude",                           :precision => 10, :scale => 0
    t.decimal  "longitude",                          :precision => 10, :scale => 0
  end

  create_table "pedidos", :force => true do |t|
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "sku"
    t.time     "hora_llegada"
    t.date     "fecha"
    t.date     "fecha_llegada"
    t.float    "cantidad"
    t.integer  "direccion_id"
    t.string   "unidad"
  end

  create_table "razon_social", :force => true do |t|
    t.string "nombre",               :null => false
    t.string "rut",    :limit => 12
  end

  create_table "regiones", :force => true do |t|
    t.string "nombre", :null => false
  end

end
