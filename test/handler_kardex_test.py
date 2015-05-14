#!/usr/bin/python
# -*- coding: UTF-8 -*-

import unittest

import authenticated

from giani import Application
from bson import json_util
from lp.model.basemodel import BaseModel
import tornado.web
import tornado.ioloop 
import tornado.httpclient
import tornado.httpserver
import urllib


class TestStock(unittest.TestCase): 
    http_server = None
    response = None 

    def setUp(self): 

        # application = tornado.web.Application([ 
        #         (r'/', MainHandler), 
        #         ])

        # query = '''delete from "Kardex" where id > 2897;'''
        # BaseModel.execute_query(query)

        app = Application()
        self.http_server = tornado.httpserver.HTTPServer(app) 
        self.http_server.listen(8502) 
        # self.request = tornado.web.RequestHandler(app, "http://localhost:9008/cellar")
        # self.request.set_secure_cookie("user_bodega", json_util.dumps({"cellar_permissions":[1,2,3,4,5,6]}))

    def tearDown(self):
        # query = '''update "Order" set state = 3 where user_id = 733;'''
        # BaseModel.execute_query(query)
        self.http_server.stop()

    def handle_request(self, response): 
        self.response = response 
        tornado.ioloop.IOLoop.instance().stop() 

    def testPaymentBankTransferHandler(self):

        body = 'TBK_ID_SESION=20150514120505&TBK_ORDEN_COMPRA=392'

        # http_client = tornado.httpclient.AsyncHTTPClient()
        # http_client.fetch(
        #     "http://localhost:8502/checkout/send", 
        #     self.handle_request,
        #     body=body,
        #     method="POST"
        # )
        # print self.response
        # tornado.ioloop.IOLoop.instance().start()
        # self.failIf(self.response.error)
        # self.assertEqual(self.response.body, json_util.dumps({"state": "ok", "message": "Stock agregado exitosamente"}))

        http_client = tornado.httpclient.AsyncHTTPClient()
        http_client.fetch(
            "http://localhost:8502/store/success", 
            self.handle_request,
            body=body,
            method='POST'
        )
        # print self.response
        tornado.ioloop.IOLoop.instance().start()
        self.failIf(self.response.error)
        self.assertEqual(self.response.code, 200)
