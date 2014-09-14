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

from model.user import User

class AddAnonimousHandler(BaseHandler):

	def get(self):
		user = User()
		response_obj = user.Save()
		if "success" in response_obj:
			self.write(response_obj['success'])
		else:
			self.write("error")