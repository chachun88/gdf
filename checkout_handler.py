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

class CheckoutAddressHandler(BaseHandler):
	def get(self):
		contact = Contact()
		user = User()
		customer = Customer()

		customer.user_id = user.GetUserId(self.current_user)
		response_obj = customer.GetCustomerIdByUserId()

		if "success" in response_obj:
			contactos = contact.ListByCustomerId(customer.id)
			self.render("store/checkout-1.html",contacto=contactos[0])
		else:
			self.write(response_obj["error"])

class CheckoutBillingHandler(BaseHandler):
	def get(self):

		self.render("store/checkout-2.html")

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
		