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

from globals import cellar_id, url_bodega

#libreria prescindible
from bson import json_util
from datetime import datetime

from model.product import Product
from model.cart import Cart
from model.kardex import Kardex
from model.vote import Vote
from model.tag import Tag
from model.cellar import Cellar

class IndexHandler(BaseHandler):

	def get(self):
		product = Product()
		page = int(self.get_argument("page","1"))
		ajax = int(self.get_argument("ajax",0))
		lista = product.GetList(page,15)

		items = 0
		tags = {}

		response = product.GetItems()
		if "success" in response:
			items = response["success"]

		tag = Tag()
		tags_visibles = tag.ListVisibleTags()

		if "success" in tags_visibles:
			tags = tags_visibles["success"]

		if ajax == 0:
			self.render("store/index.html",data=lista,items=items,page=page,tags=tags,tags_arr=None)
		else:
			self.render("store/ajax_productos.html",data=lista,items=items,page=page,tags=tags,tags_arr=None)

	def post(self):

		self.write(json_util.dumps(self.request.arguments))

class ProductHandler(BaseHandler):

	def get(self,category,name,color):

		category = category.replace("_","|")
		name = name.replace("_","|")
		color = color.replace("_","&")

		id_bodega = cellar_id
		cellar = Cellar()
		res_cellar = cellar.GetWebCellar()

		if "success" in res_cellar:
			id_bodega = res_cellar["success"]

		# sku = self.get_argument("sku","")
		prod = Product()

		response_obj = prod.GetProductCatNameColor(category,name,color)

		if "error" in response_obj:
			self.render("beauty_error.html",message="Producto no encontrado, error:{}".format(response_obj["error"]))
		else:

			tallas_disponibles = []

			for s in prod.size:

				kardex = Kardex()
				response_obj = kardex.GetUnitsBySize(prod.sku,id_bodega,s)

				if "success" in response_obj:
					if kardex.balance_units > 0:
						tallas_disponibles.append(s)
				# else:
				# 	self.write(json_util.dumps(response_obj["error"]))

			prod.size = tallas_disponibles

			vote = Vote()
			
			res = vote.GetVotes(prod.id)
			votos = 0

			prod_name = prod.sku.split("-")[-2]

			# print "prod_name:{}".format(prod_name)

			combinaciones = prod.GetCombinations(prod_name)
			relacionados = prod.GetRandom()

			

			if "success" in res:
				votos = res["success"]

			self.render("store/detalle-producto.html",data=prod,combinations=combinaciones,related=relacionados,votos=votos)

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
				self.render("store/carro_ajax.html",data=lista,suma=suma,url_bodega=url_bodega)
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

	def get(self,tags=""):

		
		page = int(self.get_argument("page","1"))
		ajax = int(self.get_argument("ajax",0))

		tags = tags.replace("_"," ")

		tags_arr = tags.split(",")

		items = 0

		tag = Tag()

		res = tag.GetItemsByTags(tags_arr)

		if "success" in res:
			items = int(res["success"])

		res = tag.GetProductsByTags(tags_arr,page,15)

		tags_visibles = tag.ListVisibleTags()

		if "success" in tags_visibles:
			tags = tags_visibles["success"]

		if "success" in res:
			if ajax == 0:
				self.render("store/index.html",data=res["success"],items=items,page=page,tags=tags,tags_arr=tags_arr)
			else:
				self.render("store/ajax_productos.html",data=res["success"],items=items,page=page,tags=tags,tags_arr=None)
				#self.write(json_util.dumps({"html":self.render_string("store/ajax_productos.html",data=res["success"],url_bodega=url_bodega,money_format=self.money_format),"items":items,"page":page}))
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

class UpdateCartQuantityHandler(BaseHandler):

	def post(self):

		cart_id = self.get_argument("cart_id","")
		quantity = self.get_argument("quantity","")

		cart = Cart()
		response = cart.UpdateCartQuantity(cart_id,quantity)

		self.write(json_util.dumps(response))
