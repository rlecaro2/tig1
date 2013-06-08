class LogsController < ApplicationController
  
  def main_logs
    log = File.join(Rails.root, "log", "#{ Rails.env }.log")
    @lines = `tail -512 #{ log }`.split(/\n/).reverse
    respond_to do |wants|
      wants.html{ render }
      wants.json{ render(:json => @lines) }
    end
  end

  def queue_logs
    log = File.join(Rails.root, "log", "queue.log")
    @lines = `tail -512 #{ log }`.split(/\n/).reverse
    respond_to do |wants|
      wants.html{ render }
      wants.json{ render(:json => @lines) }
    end
  end

  def whenever_logs
    log = File.join(Rails.root, "log", "whenever.log")
    @lines = `tail -512 #{ log }`.split(/\n/).reverse
    respond_to do |wants|
      wants.html{ render }
      wants.json{ render(:json => @lines) }
    end
  end

  def bodega_logs
    log = File.join(Rails.root, "log", "bodega.log")
    @lines = `tail -512 #{ log }`.split(/\n/).reverse
    respond_to do |wants|
      wants.html{ render }
      wants.json{ render(:json => @lines) }
    end
  end

end
