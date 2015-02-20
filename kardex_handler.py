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

from model.kardex import Kardex
from model.cellar import Cellar

class GetUnitsBySizeHandler(BaseHandler):

	def get(self):

		id_bodega = cellar_id

		cellar = Cellar()
		res_cellar = cellar.GetWebCellar()

		if "success" in res_cellar:
			id_bodega = res_cellar["success"]


		sku = self.get_argument("sku","")
		size = self.get_argument("size","")
		kardex = Kardex()
		response_obj = kardex.FindKardex(sku,id_bodega,size)

		if "success" in response_obj:
			self.write("{}".format(kardex.balance_units))
		else:
			self.write("error:{}".format(response_obj["error"]))