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
from bson import json_util
from datetime import datetime

from model.product import Product
from model.cart import Cart
from model.kardex import Kardex
from model.vote import Vote
from model.tag import Tag

class IndexHandler(BaseHandler):

	def get(self):
		product = Product()
		page = int(self.get_argument("page","1"))
		lista = product.GetList(page,7)

		items = 0
		tags = {}

		response = product.GetItems()
		if "success" in response:
			items = response["success"]

		tag = Tag()
		tags_visibles = tag.ListVisibleTags()

		if "success" in tags_visibles:
			tags = tags_visibles["success"]

		self.render("store/index.html",data=lista,items=items,page=page,tags=tags)

	def post(self):

		self.write(json_util.dumps(self.request.arguments))

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
						if kardex.balance_units > 0:
							tallas_disponibles.append(s)
					# else:
					# 	self.write(json_util.dumps(response_obj["error"]))

				prod.size = tallas_disponibles

				vote = Vote()
				print "PRODUCT ID:{}".format(prod.id)
				res = vote.GetVotes(prod.id)
				votos = 0

				combinaciones = prod.GetCombinations(prod.name)
				relacionados = prod.GetRandom()

				

				if "success" in res:
					votos = res["success"]

				self.render("store/detalle-producto.html",data=prod,combinations=combinaciones,related=relacionados,votos=votos)
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

				subtotal = int(product.sell_price) * cart.quantity

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

class GetCartByUserIdHandler(BaseHandler):

	def get(self):

		user_id = self.get_argument("user_id","")
		ajax = int(self.get_argument("ajax",1))

		if user_id != "":

			cart = Cart()
			cart.user_id = user_id
			lista = cart.GetCartByUserId()
			suma = 0
			for l in lista:
				suma += l["subtotal"]

			if ajax:
				self.render("store/carro_ajax.html",data=lista,suma=suma)
			else:
				self.render("store/cart.html",data=lista,suma=suma)
		else:

			self.write("error")

class RemoveCartByIdHandler(BaseHandler):

	def get(self):

		cart = Cart()
		cart.id = self.get_argument("cart_id","")
		if cart.id == "":
			self.write("No existe el item a eliminar")
		else:
			response_obj = cart.Remove()
			if "success" in response_obj:
				self.write("ok")
			else:
				self.write(response_obj["error"])

class VoteProductHandler(BaseHandler):

	def get(self):

		user_id = self.get_argument("user_id","")
		product_id = self.get_argument("product_id","")

		vote = Vote()
		response = vote.VoteProduct(user_id,product_id)

		self.write(json_util.dumps(response))

class IfVotedHandler(BaseHandler):

	def get(self):

		user_id = self.get_argument("user_id","")
		product_id = self.get_argument("product_id","")

		vote = Vote()
		response = vote.IfVoted(user_id,product_id)

		self.write(json_util.dumps(response))

class GetVotesHandler(BaseHandler):

	def get(self):

		product_id = self.get_argument("product_id","")

		vote = Vote()
		response = vote.GetVotes(product_id)

		self.write(json_util.dumps(response))

class GetProductsByTagsHandler(BaseHandler):

	def get(self):

		_tags = self.get_argument("tags","")
		page = int(self.get_argument("page","1"))

		tags_arr = _tags.split(",")

		items = 0

		tag = Tag()

		res = tag.GetItemsByTags(tags_arr)

		if "success" in res:
			items = int(res["success"])

		res = tag.GetProductsByTags(tags_arr,page)

		tags_visibles = tag.ListVisibleTags()

		if "success" in tags_visibles:
			tags = tags_visibles["success"]

		if "success" in res:
			self.render("store/index.html",data=res["success"],items=items,page=page,tags=tags)
		else:
			self.render("beauty_error.html",message=res["error"])



		# product = Product()
		# page = int(self.get_argument("page","1"))
		# lista = product.GetList(page,7)

		# items = 0

		# response = product.GetItems()
		# if "success" in response:
		# 	items = response["success"]

		# self.render("store/index.html",data=lista,items=items,page=page)
