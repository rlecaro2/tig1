namespace :cdb do
  desc "Migrate the database through scripts in db/migrate."
  task :migrate  => :environment do
    Rake::Task["cdb:migrate_integra1"].invoke
    Rake::Task["cdb:migrate_dir"].invoke
  end
 
  task :migrate_integra1  => :environment do
    puts "MIGRATE INTEGRA1"
    ActiveRecord::Base.establish_connection INTEGRA1_CONF
    ActiveRecord::Migrator.migrate("db/migrate/integra1/")
  end
 
  task :migrate_dir  => :environment do
    puts "MIGRATE DIR"
    ActiveRecord::Base.establish_connection DIR_CONF
    ActiveRecord::Migrator.migrate("db/migrate/dir/")
  end

  desc "Create the databases"
  task :create  => :environment do
    Rake::Task["cdb:create_integra1"].invoke
    Rake::Task["cdb:create_dir"].invoke
  end
 
  task :create_integra1  => :environment do
    puts "CREATE INTEGRA1"
    ActiveRecord::Base.connection.create_database(INTEGRA1_CONF["database"])
  end
 
  task :create_dir  => :environment do
    puts "CREATE DIR"
    ActiveRecord::Base.connection.create_database(DIR_CONF["database"])
  end

  task :seed  => :environment do
    puts "SEEDING"
    require './db/seeds.rb'
  end

  desc "Drop the databases"
  task :drop  => :environment do
    Rake::Task["cdb:drop_integra1"].invoke
    Rake::Task["cdb:drop_dir"].invoke
  end
 
  task :drop_integra1  => :environment do
    puts "DROP INTEGRA1"
    ActiveRecord::Base.connection.drop_database(INTEGRA1_CONF["database"]) rescue nil
  end
 
  task :drop_dir  => :environment do
    puts "DROP DIR"
    ActiveRecord::Base.connection.drop_database(DIR_CONF["database"]) rescue nil
  end

end


