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

	def self.getContactByShipTo(shipto)
		
		shipto = shipto.to_s

		cmd = VtigerHelper.login
		resp = cmd.query_element_by_field('Contacts','cf_641',"#{shipto.strip}")
		status = resp[0]
		obj_id = resp[1]
		
		if status
			obj = cmd.retrieve_object(obj_id)
			return obj
		end

		return nil

	end

	def self.getProductBySku(sku)
		
		sku = sku.to_s

		cmd = VtigerHelper.login
		resp = cmd.query_element_by_field('Products','cf_656',"#{sku.strip}")
		status = resp[0]
		obj_id = resp[1]
		
		if status
			obj = cmd.retrieve_object(obj_id)
			return obj
		end

		return nil

	end

	def self.getOrganizationByRut(rut)

		rut = rut.to_s

		cmd = VtigerHelper.login
		resp = cmd.query_element_by_field('Accounts','cf_640',	"\r"+"#{rut.strip}"	)
		status = resp[0]
		obj_id = resp[1]
		
		if status
			obj = cmd.retrieve_object(obj_id)
			return obj
		end

		return nil
	end

	def self.createSalesOrder(product_sku, contact_rut, shipto, fecha_string, quantity, unit, price=0)


		contact = VtigerHelper.getContactByShipTo(shipto)
		product = VtigerHelper.getProductBySku(product_sku)

		if(contact_rut.nil?)
			contact_rut = contact["cf_650"]
		end
		organization = VtigerHelper.getOrganizationByRut(contact_rut)


		subject = "Pedido de " + product["cf_660"]
		description = "Pedido de " + quantity.to_s + " " +unit.to_s+ " de producto sku: " + product_sku.to_s + "\n" + "Tipo : " + product["cf_657"] + "\n" + "Marca : " + product["cf_658"] + "\n" + "Fundo : " + product["cf_659"] + "\n" + "Descripcion : " + product["cf_660"]

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