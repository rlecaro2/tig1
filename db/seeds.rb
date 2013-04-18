# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'active_record/fixtures'
require 'yaml'

ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "regiones", :regiones)
ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "comunas", "comunas")
ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "razon_social", "razon_social")
ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "direcciones", "direcciones")
