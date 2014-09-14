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

class GetUnitsBySizeHandler(BaseHandler):

	def get(self):

		sku = self.get_argument("sku","")
		size = self.get_argument("size","")
		kardex = Kardex()
		response_obj = kardex.GetUnitsBySize(sku,cellar_id,size)

		if "success" in response_obj:
			self.write("{}".format(kardex.balance_units))
		else:
			self.write("error:{}".format(response_obj["error"]))