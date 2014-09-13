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

#libreria prescindible
import json

from model.product import Product

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

			producto = json.loads(prod.InitBySku(sku))

			if "error" in producto:
				self.render("error.html",msg="Producto no encontrado, error:{}".format(producto["error"]))
			else:

				prod.id = producto["id"]
				prod.name = producto["name"]
				prod.description = producto["description"]
				prod.brand = producto["brand"]
				prod.manufacturer = producto["manufacturer"]
				prod.size = producto["size"]
				prod.color = producto["color"]
				prod.material = producto["material"]
				prod.bullet_1 = producto["bullet_1"]
				prod.bullet_2 = producto["bullet_2"]
				prod.bullet_3 = producto["bullet_3"]
				prod.image = producto["image"]
				prod.image_2 = producto["image_2"]
				prod.image_3 = producto["image_3"]
				prod.category = producto["category"]
				prod.upc = producto["upc"]
				prod.sku = producto["sku"]
				prod.price = producto["price"]
				prod.sell_price = producto["sell_price"]

				combinaciones = prod.GetCombinations(prod.name)
				relacionados = prod.GetRandom()

				self.render("store/detalle-producto.html",data=prod,combinations=combinaciones,related=relacionados)
		else:
			self.render("error.html",msg="Producto no encontrado")