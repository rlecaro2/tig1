
queue_logfile = File.open("#{Rails.root}/log/queue.log", 'a')

queue_logfile.sync = true

QUEUE_LOGGER = QueueLogger.new(queue_logfile)

bodega_logfile = File.open("#{Rails.root}/log/bodega.log", 'a')

bodega_logfile.sync = true

BODEGA_LOGGER = BodegaLogger.new(bodega_logfile)