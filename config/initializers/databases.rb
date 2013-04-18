DB_CONF = YAML::load(File.open(File.join(".",'config','database.yml')))
DIR_CONF = DB_CONF["dir"][Rails.env]
INTEGRA1_CONF = DB_CONF["integra1"][Rails.env]