class Precio

	attr_accessor	:id,
					:sku,
					:descripcion,
					:precio,
					:desde,
					:hasta


	def initialize(json)
		@id 	=	 json["ID"]
		@sku 	=	 json["Material"].to_i

		string 	=	 json["Precio 1"]
		string 	=	 string.tr(",", "")

		@precio = 	string.to_d
		@descripcion = json["Descripción"]
		@desde 	=  	Time.at(json["Desde"]/1000).to_date
		@hasta 	= 	Time.at(json["Hasta"]/1000).to_date


	end

	def self.find (id)
		return Precio.find_by_id (id)
	end

	def self.find_all (id)
		return Precio.find_all_by_id (id)
	end

	def self.first
		return Precio.find(1)
	end

	def self.find_by_id (id)
		begin
			string = J_HELPER.find_by("ID",id)
			json = ActiveSupport::JSON.decode(string)
			return Precio.new(json[0])
    	rescue Exception => e
    		return nil
   		end

	end

	def self.find_all_by_id (id)
		begin
			string = J_HELPER.find_by("ID",id)
			json = ActiveSupport::JSON.decode(string)

			list = []
			json.each do |p|
				precio = Precio.new(p)
				list << precio
			end
			return list
    	rescue Exception => e
    		return nil
   		end

	end

	def self.find_by_sku (mat)

		search = mat.to_s
		length=search.length

	    if length >= 20 then
	       search = search.to_s
	    else
	       search='0' * (20-length)  + search.to_s
	    end

		begin
			string = J_HELPER.find_by("Material",search)
			json = ActiveSupport::JSON.decode(string)
			return Precio.new(json[0])

    	rescue Exception => e
    		return nil
   		end

	end

	def self.find_all_by_sku (mat)

		search = mat.to_s
		length=search.length

	    if length >= 20 then
	       search = search.to_s
	    else
	       search='0' * (20-length)  + search.to_s
	    end

		begin
			string = J_HELPER.find_by("Material",search)
			json = ActiveSupport::JSON.decode(string)
			
			list = []
			json.each do |p|
				precio = Precio.new(p)
				list << precio
			end

			return list
    	rescue Exception => e
    		return nil
   		end

	end

	def self.find_by_precio (pr)
		begin
			string = J_HELPER.find_by("Precio 1",pr)
			json = ActiveSupport::JSON.decode(string)
			return Precio.new(json[0])
    	rescue Exception => e
    		return nil
   		end

	end

	def self.find_all_by_precio (pr)
		begin
			string = J_HELPER.find_by("Precio 1",pr)
			json = ActiveSupport::JSON.decode(string)
			
			list = []
			json.each do |p|
				precio = Precio.new(p)
				list << precio
			end

			return list
    	rescue Exception => e
    		return nil
   		end

	end

	def self.find_by_desde (des)
		begin
			string = J_HELPER.find_by("Desde",des)
			json = ActiveSupport::JSON.decode(string)
			return Precio.new(json[0])
    	rescue Exception => e
    		return nil
   		end

	end

	def self.find_all_by_desde (des)
		begin
			string = J_HELPER.find_by("Desde",des)
			json = ActiveSupport::JSON.decode(string)
			
			list = []
			json.each do |p|
				precio = Precio.new(p)
				list << precio
			end

			return list
    	rescue Exception => e
    		return nil
   		end

	end

	def self.find_by_hasta (has)
		begin
			string = J_HELPER.find_by("Hasta",has)
			json = ActiveSupport::JSON.decode(string)
			return Precio.new(json[0])
    	rescue Exception => e
    		return nil
   		end

	end

	def self.find_all_by_hasta (has)
		begin
			string = J_HELPER.find_by("Hasta",has)
			json = ActiveSupport::JSON.decode(string)
			
			list = []
			json.each do |p|
				precio = Precio.new(p)
				list << precio
			end

			return list
    	rescue Exception => e
    		return nil
   		end

	end

	def inspect
		ActiveSupport::JSON.decode(self.to_json)
	end


end