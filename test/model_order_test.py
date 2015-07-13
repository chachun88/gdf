#!/usr/bin/python
# -*- coding: UTF-8 -*-

import unittest
from lp.model.basemodel import BaseModel
from model.order import Order
from model.user import User
from model.contact import Contact
from datetime import datetime
import pytz


class TestOrder(unittest.TestCase):

    def resetDB(self):
        BaseModel.execute_query( 'TRUNCATE "Order" CASCADE;' )

    def setUp(self):
        self.resetDB()

    def tearDown(self):
        self.resetDB()

    def test_insert_order(self):


        user = User()
        user.name = 'Yi Chun'
        user.email = 'yichun123@gmail.com'
        user.user_type = 'Visita'
        user.Save()

        contact = Contact()
        contact.user_id = user.id
        contact.name = 'Casa'
        contact.telephone = '123456'
        contact.email = 'yichun123@gmail.com'
        contact.user_id = user.id
        contact.address = 'some address'
        contact.lastname = 'lin'
        contact.city = 1
        contact.zip_code = '734628347632'
        contact.additional_info = 'skjahjdahk'
        contact.town = 'sadjahsdkjah'
        contact.rut = '35172617356'
        contact.Save()

        # create a new user instance
        order = Order()
        order.date = datetime.now(pytz.timezone('Chile/Continental').isoformat())
        order.type = Order.TIPO_WEB
        order.subtotal = 20000
        order.shipping = 2000
        order.tax = 0
        order.total = 22000
        order.items_quantity = 1
        order.products_quantity = 1
        order.user_id = user.id
        order.billing_id = contact.id
        order.shipping_id = contact.id
        order.payment_type = 1
        order.voucher = "image.png"
        order.state = Order.ESTADO_PENDIENTE
        res = order.Save()
        print order.date
        self.assertTrue('success' in res)
