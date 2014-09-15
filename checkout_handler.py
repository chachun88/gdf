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
		contact = Contact()
		user = User()
		customer = Customer()

		customer.user_id = user.GetUserId(self.current_user)
		response_obj = customer.InitByUserId()

		if "success" in response_obj:
			contactos = contact.ListByCustomerId(customer.id)

			user_id = customer.user_id

			if user_id != "":

				cart = Cart()
				cart.user_id = user_id
				lista = cart.GetCartByUserId()
				suma = 0
				for l in lista:
					suma += l["subtotal"]

				self.render("store/checkout-1.html",contactos=contactos,customer=customer,data=lista,suma=suma)

			else:

				self.write("error")
			
		else:
			self.write(response_obj["error"])

class CheckoutBillingHandler(BaseHandler):
	def get(self):

		contact = Contact()
		user = User()
		customer = Customer()
		order = Order()

		customer.user_id = user.GetUserId(self.current_user)
		response_obj = customer.InitByUserId()

		if "success" in response_obj:
			contactos = contact.ListByCustomerId(customer.id)

			user_id = customer.user_id

			if user_id != "":

				cart = Cart()
				cart.user_id = user_id
				lista = cart.GetCartByUserId()
				suma = 0
				for l in lista:
					suma += l["subtotal"]

				last_order = order.GetLastOrderByCustomerId(customer.id)

				self.render("store/checkout-2.html",contactos=contactos,customer=customer,data=lista,suma=suma,selected_address=last_order['billing_id'])

			else:

				self.write("error")
			
		else:
			self.write(response_obj["error"])

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
		