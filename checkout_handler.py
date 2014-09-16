#!/usr/bin/python
# -*- coding: UTF-8 -*-

import tornado.auth
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
from basehandler import BaseHandler

from model.cart import Cart
from model.user import User
from model.contact import Contact
from model.customer import Customer
from model.order import Order

class CheckoutAddressHandler(BaseHandler):
	def get(self):

		user_id = self.current_user["id"]
		
		contact = Contact()
		response_obj = contact.ListByUserId(user_id)

		contactos = []

		if "success" in response_obj:
			contactos = response_obj["success"]

		if user_id != "":

			cart = Cart()
			cart.user_id = user_id

			lista = cart.GetCartByUserId()
			suma = 0
			for l in lista:
				suma += l["subtotal"]

			self.render("store/checkout-1.html",contactos=contactos,data=lista,suma=suma)

		else:
			self.write("error")

		# else:
		# 	self.write(response_obj["error"])

class CheckoutBillingHandler(BaseHandler):
	def get(self):

		if self.current_user:

			user_id = self.current_user["id"]
			nombre = self.get_argument("name", self.current_user["nombre"])
			apellido = self.get_argument("lastname", self.current_user["lastname"])
			email = self.get_argument("email", self.current_user["email"])
			direccion = self.get_argument("address","")
			ciudad = self.get_argument("city","")
			codigo_postal = self.get_argument("zip_code","")
			informacion_adicional = self.get_argument("additional_info","")
			telefono = self.get_argument("telephone","")
			id_contacto = self.get_argument("contact_id","")


			contact = Contact()

			contact.name = nombre
			contact.lastname = apellido
			contact.telephone = telefono
			contact.email = email
			contact.address = direccion
			contact.city = ciudad
			contact.zip_code = codigo_postal
			contact.user_id = user_id
			contact.additional_info = informacion_adicional

			if id_contacto != "":
				contact.id = id_contacto	
				response_obj = contact.Edit()
			else:
				response_obj = contact.Save()

			if "error" in response_obj:
				self.rende("beauty_error.html",message=response_obj["error"])
			else:

				lista = contact.GetCartByUserId()

				suma = 0

				for l in lista:
					cart = Cart()
					cart.InitById(l["id"])
					cart.address_id = direccion
					cart.Edit()
					suma += l["subtotal"]

				contactos = []

				if "success" in response_obj:
					response_obj = contact.ListByUserId(user_id)

				self.render("store/checkout-2.html",contactos=contactos,data=lista,suma=suma,selected_address=direccion)
		else:

			self.redirect("/auth/login")

		# contact = Contact()
		# user = User()
		# customer = Customer()
		# order = Order()

		# customer.user_id = user.GetUserId(self.current_user)
		# response_obj = customer.InitByUserId()

		# if "success" in response_obj:
		# 	contactos = contact.ListByCustomerId(customer.id)

		# 	user_id = customer.user_id

		# 	if user_id != "":

		# 		cart = Cart()
		# 		cart.user_id = user_id
		# 		lista = cart.GetCartByUserId()
		# 		suma = 0
		# 		for l in lista:
		# 			suma += l["subtotal"]

		# 		last_order = order.GetLastOrderByCustomerId(customer.id)

		# 		self.render("store/checkout-2.html",contactos=contactos,customer=customer,data=lista,suma=suma,selected_address=last_order['billing_id'])

		# 	else:
		# 		self.write("error")
			
		# else:
		# 	#self.write(response_obj["error"])
		# 	self.render( "beauty_error.html", message=response_obj["error"] )

class CheckoutShippingHandler(BaseHandler):
	def get(self):

		self.render("store/checkout-3.html")

class CheckoutPaymentHandler(BaseHandler):
	def get(self):

		self.render("store/checkout-4.html")

class CheckoutOrderHandler(BaseHandler):
	def get(self):
		cart = Cart()
#		cart.user_id = self.current_user["id"]
		user = User()
		cart.user_id = user.GetUserId(self.current_user)
		data = cart.GetCartByUserId()
		self.render("store/checkout-5.html",data=data)

class CheckoutSendHandler(BaseHandler):

	def get(self):
		pass

		# sg = sendgrid.SendGridClient('nailuj41', 'Equipo_1234')

		# cart = Cart()
		# user = User()
		# cart.user_id = user.GetUserId(self.current_user)
		# data = cart.GetCartByUserId()


		# datos_empresa = '''
		# 		<table style="font-size:12px; width:400px; margin-top: 20px auto;" cellspacing="0">
		# 			<tr style="">
		# 				<th colspan="4" style=" background-color: white;line-height: 2.5;height: 30px;border: 1px;border-color: #d6d6d6; border-style: solid;">Datos Empresas</th>
		# 			</tr>

		# 			<tr>
		# 				<th style=" width:120px ;background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Raz&oacute;n social</th>
		# 				<td colspan="3" style=" background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{razon_social}
		# 				</td>
		# 			</tr>
		# 			<tr>
		# 				<th style=" width:120px ;background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Rut</th>
		# 				<td colspan="3" style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{rut_factura}
		# 				</td>
		# 			</tr>
		# 			<tr>
		# 				<th style=" width:120px ;background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Giro</th>
		# 				<td colspan="4" style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{giro}
		# 				</td>
		# 			</tr>
		# 			<tr> 
		# 				<th style=" width:120px ;background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Direcci&oacute;n</th>
		# 				<td colspan="3" style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{direccion_factura}
		# 				</td>
		# 			</tr>
		# 			<tr> 
		# 				<th style=" width:120px ;background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Direcci&oacute;n</th>
		# 				<td colspan="3" style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{email_factura}
		# 				</td>
		# 			</tr>
		# 			<tr> 
		# 				<th style=" width:120px ;background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Direcci&oacute;n</th>
		# 				<td colspan="3" style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{telefono_factura}
		# 				</td>
		# 			</tr>
		# 		</table>
		# 		'''.format(
		# 		razon_social=tryToEncodeUtf8(chk.razonsocial),
		# 		rut_factura=tryToEncodeUtf8(chk.rut_factura),
		# 		giro=tryToEncodeUtf8(chk.giro),
		# 		direccion_factura=tryToEncodeUtf8(chk.direccion_factura),
		# 		email_factura=tryToEncodeUtf8(chk.email_factura),
		# 		telefono_factura=tryToEncodeUtf8(chk.telefono_factura)
		# 		)

		# 		datos_personales = '''
		# 		<table style="font-size:12px; width:400px; margin: 20px auto;" cellspacing="0">
		# 			<tr style="">
		# 				<th colspan="4" style=" background-color: white;line-height: 2.5;height: 30px;border: 1px;border-color: #d6d6d6; border-style: solid;">Datos Personales</th>
		# 			</tr>
		# 			<tr>
		# 				<th style="background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Nombre</th>
		# 				<td style="background-color: white;line-height: 2.5; height: 30px;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{nombre}
		# 				</td>
		# 				<th  style="background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Apellido</th>
		# 				<td style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{apellido}
		# 				</td>
		# 			</tr>
		# 			<tr>
		# 				<th style=" background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Email</th>
		# 				<td style="background-color: white;line-height: 2.5; height: 30px;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{email}
		# 				</td>
		# 				<th style=" background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Tel&eacute;fono</th>
		# 				<td style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{telefono}
		# 				</td>
		# 			</tr>
		# 			<tr>
		# 				<th style=" background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Direcci&oacute;n</th>
		# 				<td colspan="3" style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{direccion}
		# 				</td>
		# 			</tr>
		# 			<tr>
		# 				<th style=" background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Ciudad</th>
		# 				<td colspan="3" style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{ciudad}
		# 				</td>
		# 			</tr>
		# 			<tr>
		# 				<th style=" background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Comentarios</th>
		# 				<td colspan="3" style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{comentario}
		# 				</td>
		# 			</tr>
		# 		</table>
		# 		'''.format(
		# 		nombre=nombre,
		# 		apellido=apellido,
		# 		email=email,
		# 		telefono=telefono,
		# 		direccion=direccion,
		# 		ciudad=ciudad,
		# 		comentario=comentario
		# 		)

		# 		if chk.razonsocial!="":
		# 			datos = datos_empresa
		# 			nombre = razon_social
		# 			email = email_factura
		# 		else:
		# 			datos = datos_personales
		# 			nombre = nombre
		# 			email = email

		# 		carro = ""
		# 		total = 0
		# 		html_total = ""

		# 		for d in data:

		# 			product_name=d["name"]
		# 			color=d["color"]
		# 			finish=d["size"]
		# 			paper=''
		# 			quantity=d['quantity']
		# 			subtotal=d["subtotal"]
		# 			product_id=''

		# 			producto = '''
		# 			<tr>
		# 				<td style="background-color: white;line-height: 2.5; height: 30px; border-right: 1px solid #d6d6d6; border-bottom: 1px solid #d6d6d6; border-left: 1px solid #d6d6d6;">
		# 					<a href=\"http://{host}/design/get?identifier={product_id}\">{product_name}</a>
		# 				</td>
		# 				<td style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{color}
		# 				</td>
		# 				<td style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{finish}
		# 				</td>
		# 				<td style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{paper}
		# 				</td>
		# 				<td style="background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{quantity}
		# 				</td>
		# 				<td style="text-align:right; background-color: white;line-height: 2.5; height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">
		# 					{subtotal}
		# 				</td>
		# 			</tr>
		# 			'''.format(
		# 			product_name=product_name,
		# 			color=color,
		# 			finish=finish,
		# 			paper=paper,
		# 			quantity=quantity,
		# 			subtotal=subtotal,
		# 			host=self.request.host,
		# 			product_id=product_id
		# 			)
		# 			total += int(subtotal)
		# 			carro += producto


		# 		html_total = '''
		# 		<tr>
		# 			<td colspan="6" style="text-align:right; background-color: white;line-height: 2.5; height: 30px; border-right: 1px solid #d6d6d6; border-bottom: 1px solid #d6d6d6; border-left: 1px solid #d6d6d6;">
		# 			{total}
		# 			</td>
		# 		</tr>
		# 		'''.format(
		# 		total=total
		# 		)

		# 		if total != 0:
		# 			carro += html_total

		# 		contact_body = '''
		# 		<html>


		# 		<body style="width:400px; background: #efefef; margin: 0 auto; font-family: 'arial'; font-size:12px; color:black;">
		# 			<table style="background-color: white; font-size:12px; width:400px; margin: 0;" cellspacing="0">
		# 				<tr style="background-color: white;">
		# 					<td style="width:400px; background-color: white;line-height: 2.5;height: 30px;border: 1px;border-color: #d6d6d6; border-style: solid; text-align: center;">
		# 						<a href="http://{host}"><img src="http://ecommerce.loadingplay.com/static/images/logo_1.png" ></a>
		# 					</td>
		# 				</tr>
		# 			</table>
		# 			<h3 style="text-align: center; font-size: 18px">Confirmaci&oacute;n de pedido realizado</h3>
		# 			<h3 style="text-align: center;">{nombre} ha realizado un pedido</h3>
					

		# 			{datos}
					
		# 			<table style="font-size:12px; width:400px; margin: 20px auto;" cellspacing="0">
		# 				<tr style="">
		# 					<th colspan="6" style=" background-color: white;line-height: 2.5;height: 30px;border: 1px;border-color: #d6d6d6; border-style: solid;">Carro de Compra</th>
		# 				</tr>

		# 				<tr>
		# 					<th style=" width:120px ;background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Producto</th>
		# 					<th style=" width:120px ;background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Color</th>
		# 					<th style=" width:120px ;background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Terminaci&oacute;n</th>
		# 					<th style=" width:120px ;background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Papel</th>
		# 					<th style=" width:120px ;background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Cantidad</th>
		# 					<th style=" width:120px ;background-color: white;line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Subtotal</th>
		# 				</tr>
		# 				{carro}
		# 			</table>

					

		# 			<table style="font-size:12px; width:100%; margin-top: 20px; background-color: white;" cellspacing="0">
		# 				<tr style="background-color: white;">
		# 					<td style="width:400px; background-color: white;line-height: 2.5;height: 30px;border: 1px;border-color: #d6d6d6; border-style: solid; text-align: center;">
		# 						<a href="http://{host}"><img src="http://ecommerce.loadingplay.com/static/images/logo_1.png" ></a>
		# 					</td>
		# 				</tr>
		# 			</table>
		# 		</body>
		# 		</html>
		# 		'''.format( nombre=nombre,
		# 					datos=datos,
		# 					carro=carro,
		# 					host=self.request.host)

		# message = sendgrid.Mail()
		# message.set_from("{nombre} <{mail}>".format(nombre=nombre,mail=email))
		# message.add_to(email_confirmacion)
		# message.set_subject("Mail de confirmación")
		# message.set_html(contact_body)

		self.redirect( "/checkout/success" )
		