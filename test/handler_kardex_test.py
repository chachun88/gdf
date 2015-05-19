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
from config import *


class TestStock(unittest.TestCase): 
    http_server = None
    response = None 

    def setUp(self): 

        app = Application()
        self.http_server = tornado.httpserver.HTTPServer(app) 
        self.http_server.listen(8502)

    def tearDown(self):
        self.http_server.stop()

    def handle_request(self, response): 
        self.response = response 
        tornado.ioloop.IOLoop.instance().stop() 

    def testMoveOrderHandler(self):

        '''orden con estado pendiente'''

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

        self.assertNotEqual(self.response.effective_url, None)

    def testPaymentWebpayHandler(self):

        '''orden con estado aprobado'''

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
        query = '''\
                select * from "Kardex" 
                where cellar_id = 12 
                and product_sku = 'GDF-PV14-Sirisi-C1' 
                and size_id = 4 
                order by date desc limit 1'''
        kardex = BaseModel.execute_query(query)

        if len(kardex) > 0:
            self.assertEqual(kardex[0]["balance_units"], 2)

    def testInvalidOrderIdHandler(self):

        '''id de pedido invalido'''

        body = 'TBK_ID_SESION=20150515034434&TBK_ORDEN_COMPRA=39gjahdgah6'
        http_client = tornado.httpclient.AsyncHTTPClient()
        http_client.fetch(
            "http://localhost:8502/store/success", 
            self.handle_request,
            body=body,
            method='POST'
        )
        tornado.ioloop.IOLoop.instance().start()
        self.failIf(self.response.error)
        self.assertNotEqual(self.response.effective_url, None)

    def testPaymentBankTransferHandler(self):

        body = 'TBK_ID_SESION=20150514120505&TBK_ORDEN_COMPRA=392'

        http_client = tornado.httpclient.AsyncHTTPClient()
        http_client.fetch(
            "http://localhost:8502/checkout/send", 
            self.handle_request,
            body=body,
            method="POST"
        )

        tornado.ioloop.IOLoop.instance().start()
        self.failIf(self.response.error)
        self.assertEqual(self.response.code, 200)

    def testInvalidPaymentHandler(self):

        '''pedido con validacion mac fallido'''

        body = 'TBK_ID_SESION=20150513214527&TBK_ORDEN_COMPRA=391'
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
        self.assertNotEqual(self.response.effective_url, None)

    def testAccentsHandler(self):

        '''orden acentos'''

        body = 'TBK_ID_SESION=20150518010742&TBK_ORDEN_COMPRA=402'
        http_client = tornado.httpclient.AsyncHTTPClient()
        http_client.fetch(
            "http://localhost:8502/store/success", 
            self.handle_request,
            body=body,
            method='POST'
        )

        tornado.ioloop.IOLoop.instance().start()
        self.failIf(self.response.error)

        # self.assertNotEqual(self.response.effective_url, None)
