#!/usr/bin/python
# -*- coding: UTF-8 -*-

import tornado.auth
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
from basehandler import BaseHandler

from model.cart import Cart

class CheckoutAddressHandler(BaseHandler):
	def get(self):

		self.render("store/checkout-1.html")

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
		#cart.user_id = self.current_user["id"]
		cart.user_id = 0
		data = cart.GetCartByUserId()
		self.render("store/checkout-5.html",data=data)
		