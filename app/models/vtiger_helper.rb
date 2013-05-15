class VtigerHelper

	def self.login
		
		settings = {
	  		:username => 'admin',
			:key => 'AMmccaiTRPbjZvN',
			:url => 'integra1.ing.puc.cl/vtigercrm'
		}

		cmd = Vtiger::Commands.new()
		challengeStatus	=	cmd.challenge(settings)
		loginStatus		=	cmd.login(settings)

		if (challengeStatus and loginStatus)
			return cmd
		else
			raise 'Vtiger login failed'
		end

		return nil 

	end

	def self.getContactByRut(rut)
		
		cmd = VtigerHelper.login
		resp = cmd.query_element_by_field('Contacts','cf_650',"#{rut}")
		status = resp[0]
		obj_id = resp[1]
		
		if status
			obj = cmd.retrieve_object(obj_id)
			return obj

		end

		return nil

	end

	def self.getProductBySku(sku)
		
		cmd = VtigerHelper.login
		resp = cmd.query_element_by_field('Products','cf_656',"#{sku}")
		status = resp[0]
		obj_id = resp[1]
		
		if status
			obj = cmd.retrieve_object(obj_id)
			return obj

		end

		return nil

	end

	def self.createPurchaseOrder( pruduct_id, contact_id, quantity, price=0)

	end

end