#!/usr/bin/python
# -*- coding: UTF-8 -*-

import tornado.auth
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from basehandler import BaseHandler

class ServerHandler(BaseHandler):
	def get(self):
		self.write("{}".format(self.request.host.split(":")[0]))