#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os.path

import psycopg2
import psycopg2.extras

import tornado.auth
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

from tornado.options import define, options

from basehandler import BaseHandler


class HomeHandler(BaseHandler):

    def get(self):

        self.render("home/index.html")


class MainHandler(BaseHandler):

    def get(self):

        self.write("MainHandler")

# Creo que el MainHandler que se encuentra debajo esta de mas
# class MainHandler(BaseHandler):

#     def get(self):

#         self.write("MainHandler")
