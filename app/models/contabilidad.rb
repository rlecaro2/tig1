class Contabilidad

def self.earning(amount)
	begin
		date = CGI::escape(DateTime.now().strftime("%m-%d-%Y %H:%M:%S"))
		res = HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/contabilidad/?key=45XtPg&action=earning&date="+date.to_s+"&amount="+amount.to_i.to_s+"
")
	rescue Exception => e
		return false
	end
	return true
end

def self.cost(amount)
	begin
		date = CGI::escape(DateTime.now().strftime("%m-%d-%Y %H:%M:%S"))
		res = HTTParty.get("http://iic3103.ing.puc.cl/webservice/integra1/contabilidad/?key=45XtPg&action=cost&date="+date.to_s+"&amount="+amount.to_i.to_s+"
")
	rescue Exception => e
		return false
	end
	return true
end

end