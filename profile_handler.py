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


class ProfileHandler(BaseHandler):

    def get(self):
        self.render("profile/index.html")
