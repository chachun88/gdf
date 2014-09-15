#!/usr/bin/python
# -*- coding: UTF-8 -*-

import tornado.auth
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from basehandler import BaseHandler

class BeautyError(BaseHandler):
	def get(self):
		self.render( "beauty_error.html", message=self.get_argument("e", "sin mensaje") )