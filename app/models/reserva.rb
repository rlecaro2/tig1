class Reserva

	attr_accessor :sku

	def self.get(sku)
		session = GoogleDrive.login("username@gmail.com", "mypassword")
		ws = session.spreadsheet_by_key("pz7XtlQC-PYx-jrVMJErTcg").worksheets[0]
	end

	def initialize	

	end
	
end