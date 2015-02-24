#!/usr/bin/python
# -*- coding: UTF-8 -*-

import tornado.auth
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web

import psycopg2
import psycopg2.extras

from basehandler import BaseHandler

class BaseModel(object):

    def __init__(self):

        self._connection = psycopg2.connect("host='localhost' dbname='giani' user='yichun' password='chachun88'")

        self._table = ""
        self._id = ""

    @property
    def id(self):
        return self._id
    @id.setter
    def id(self, value):
        self._id = value

    @property
    def table(self):
        return self._table
    @table.setter
    def table(self, value):
        self._table = value

    @property
    def connection(self):
        
        if self._connection.closed != 0:
            self._connection = psycopg2.connect("host='localhost' dbname='giani' user='yichun' password='chachun88'")

        return self._connection
    
    #@return json object
    def ShowError(self, error_text):
        return {'error': error_text}

    #@return json object
    def ShowSuccessMessage(self, message):
        return {'success': message}
        