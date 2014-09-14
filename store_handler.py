#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os.path



import tornado.auth
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
from tornado.options import define, options
from basehandler import BaseHandler

from globals import cellar_id

#libreria prescindible
import json
from datetime import datetime

from model.product import Product
from model.cart import Cart
from model.kardex import Kardex

class IndexHandler(BaseHandler):

	def get(self):
		product = Product()
		lista = product.GetList()
		# self.write(json.dumps(lista))
		self.render("store/index.html",data=lista)

class ProductHandler(BaseHandler):

	def get(self,sku=""):

		# sku = self.get_argument("sku","")
		prod = Product()

		if sku != "":

			response_obj = prod.InitBySku(sku)

			if "error" in response_obj:
				self.render("error.html",msg="Producto no encontrado, error:{}".format(producto["error"]))
			else:

				tallas_disponibles = []

				for s in prod.size:

					kardex = Kardex()
					response_obj = kardex.GetUnitsBySize(prod.sku,cellar_id,s)

					if "success" in response_obj:
						tallas_disponibles.append(s)

				prod.size = tallas_disponibles

				combinaciones = prod.GetCombinations(prod.name)
				relacionados = prod.GetRandom()

				self.render("store/detalle-producto.html",data=prod,combinations=combinaciones,related=relacionados)
		else:
			self.render("error.html",msg="Producto no encontrado")

class AddToCartHandler(BaseHandler):

	def get(self):

		product = Product()
		cart = Cart()
		cart.product_id = self.get_argument("product_id","")
		
		if cart.product_id != "":

			response_obj = product.InitById(cart.product_id)

			if "success" in response_obj:

				cart.quantity = int(self.get_argument("quantity",0))

				subtotal = product.price * cart.quantity

				cart.date = datetime.now()
				cart.subtotal = subtotal
				cart.user_id = self.get_argument("user_id",-1)
				cart.size = self.get_argument("size","")
				response_obj = cart.Save()

				if "success" in response_obj:
					self.write("ok")
				else:
					self.write(response_obj["error"])
			else:
				self.write(response_obj["error"])
		else:
			self.write("Product ID is empty")