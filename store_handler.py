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

from model.product import Product

# librerias prescindibles
import json

class IndexHandler(BaseHandler):

	def get(self):
		product = Product()
		lista = product.GetList()
		# self.write(json.dumps(lista))
		self.render("store/index.html",data=lista)