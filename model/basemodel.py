#!/usr/bin/python
# -*- coding: UTF-8 -*-

from tornado.options import options

import psycopg2
import psycopg2.extras


class BaseModel(object):

    def __init__(self):

        self._connection = psycopg2.connect("host='{host}' dbname='{dbname}' user='{user}' password='{password}'".format(
                                            host=options["db_host"],
                                            dbname=options["db_name"], 
                                            user=options["db_user"], 
                                            password=options["db_password"]))

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
            self._connection = psycopg2.connect("host='{host}' dbname='{dbname}' user='{user}' password='{password}'".format(
                                                host=options["db_host"],
                                                dbname=options["db_name"], 
                                                user=options["db_user"], 
                                                password=options["db_password"]))

        return self._connection

    # @return json object
    def ShowError(self, error_text):
        return {'error': error_text}

    # @return json object
    def ShowSuccessMessage(self, message):
        return {'success': message}
