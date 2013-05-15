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

	def self.getOrganizationByRut(rut)

		cmd = VtigerHelper.login
		resp = cmd.query_element_by_field('Accounts','cf_640',	"\r"+"#{rut}"	)
		status = resp[0]
		obj_id = resp[1]
		
		if status
			obj = cmd.retrieve_object(obj_id)
			return obj
		end

		return nil
	end

	def self.createSalesOrder(pruduct_sku, contact_rut, fecha_string, quantity, unit, price=0)

		organization = VtigerHelper.getOrganizationByRut(contact_rut)
		contact = VtigerHelper.getContactByRut(contact_rut)
		product = VtigerHelper.getProductBySku(pruduct_sku)

		subject = "Pedido de " + product["cf_660"]
		description = "Pedido de " + quantity.to_s + " " +unit.to_s+ " de producto sku: " + pruduct_sku.to_s + "\n" + "Tipo : " + product["cf_657"] + "\n" + "Marca : " + product["cf_658"] + "\n" + "Fundo : " + product["cf_659"] + "\n" + "Descripcion : " + product["cf_660"]

		object_map = {
			'subject' => subject,
			'description' => description,
			'sostatus' => "Created",
			'contact_id' => contact["id"],
			'account_id' => organization["id"],
			'assigned_user_id' => "19x1",
			'duedate' => fecha_string,
	        'bill_street' => contact["cf_645"],
	        'invoicestatus' => 'Created',
            'ship_street'=> contact["cf_645"]
		}

		cmd = VtigerHelper.login
		hashv = {}

		resp = cmd.add_object(	object_map , hashv , "SalesOrder" )
		status = resp[0]
		obj_id = resp[1]

		if status
			return obj_id
		else
			return nil
		end

	end

	def self.cancelSalesOrderStatus( order_vtiger_id )

		cmd = VtigerHelper.login

		order = cmd.retrieve_object(order_vtiger_id)
		new_status = { 'sostatus' => 'Cancelled', 'invoicestatus' => 'Created' }
		object_map = order.merge new_status

		puts object_map

		resp = cmd.updateobject( object_map )

		success = resp['success']

		if success 
			return resp['result']
		else
			return nil
		end


	end

end