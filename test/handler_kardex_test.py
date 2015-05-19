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
from lp.tools.scriptloader import ScriptLoader
from config import *

class TestStock(unittest.TestCase): 
    http_server = None
    response = None 

    def setUp(self): 

        app = Application()
        self.http_server = tornado.httpserver.HTTPServer(app) 
        self.http_server.listen(8502) 
        # self.request = tornado.web.RequestHandler(app, "http://localhost:9008/cellar")
        # self.request.set_secure_cookie("user_bodega", json_util.dumps({"cellar_permissions":[1,2,3,4,5,6]}))

        # sl = ScriptLoader()
        # sl.dbname = ONTEST_DB_NAME
        # sl.user = ONTEST_USER
        # sl.host = ONTEST_HOST
        # sl.password = ONTEST_PASSWORD
        # sl.script_file = "dbscripts/setup.sql"
        # sl.execute()

    def tearDown(self):
        # query = '''update "Order" set state = 3 where user_id = 733;'''
        # BaseModel.execute_query(query)
        self.http_server.stop()

    def handle_request(self, response): 
        self.response = response 
        tornado.ioloop.IOLoop.instance().stop() 

    def testMoveOrderHandler(self):

        '''caso en que los productos sigan en el carro'''

        body = 'TBK_ID_SESION=20150517215610&TBK_ORDEN_COMPRA=400'
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

        kardex = BaseModel.execute_query('''select * from "Kardex" where cellar_id = 12 and product_sku = 'GDF-OI14-Queltehue-C35' and size_id = 1 order by date desc limit 1''')

        if len(kardex) > 0:
            self.assertEqual(kardex[0]["balance_units"], 1)

    def testPaymentWebpayHandler(self):

        '''caso en que los productos sigan en el carro'''

        body = 'TBK_ID_SESION=20150515034434&TBK_ORDEN_COMPRA=396'
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

        kardex = BaseModel.execute_query('''select * from "Kardex" where cellar_id = 12 and product_sku = 'GDF-PV14-Lile-C9' and size_id = 3 order by date desc limit 1''')

        if len(kardex) > 0:
            self.assertEqual(kardex[0]["balance_units"], 2)

    # def testPaymentBankTransferHandler(self):

    #     body = 'TBK_ID_SESION=20150514120505&TBK_ORDEN_COMPRA=392'

    #     http_client = tornado.httpclient.AsyncHTTPClient()
    #     http_client.fetch(
    #         "http://localhost:8502/checkout/send", 
    #         self.handle_request,
    #         body=body,
    #         method="POST"
    #     )

    #     tornado.ioloop.IOLoop.instance().start()
    #     self.failIf(self.response.error)
    #     self.assertEqual(self.response.code, 200)
