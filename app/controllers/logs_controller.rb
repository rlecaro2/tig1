class LogsController < ApplicationController
  
  def main_logs
    log = File.join(Rails.root, "log", "#{ Rails.env }.log")
    @lines = `tail -512 #{ log }`.split(/\n/).reverse
    respond_to do |wants|
      wants.html{ render }
      wants.json{ render(:json => @lines) }
    end
  end

end
