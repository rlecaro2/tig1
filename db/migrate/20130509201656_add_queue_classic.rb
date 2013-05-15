class AddQueueClassic < ActiveRecord::Migration
  def connection
    ActiveRecord::Base.establish_connection QUEUE_CONF
  end

  def up
    QC::Setup.create
  end

  def down
    QC::Setup.drop
  end
end
