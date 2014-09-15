#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os.path



import tornado.auth
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
from tornado.options import define, options
from basehandler import BaseHandler

#libreria prescindible
import json

from model.user import User
from model.contact import Contact
from model.order import Order

class AddAnonimousHandler(BaseHandler):

    def get(self):
        user = User()
        response_obj = user.Save()
        if "success" in response_obj:
            self.write(response_obj['success'])
        else:
            self.write(response_obj['error'])

class GetAddressByIdHandler(BaseHandler):

    def get(self):

        _id = self.get_argument("id","")

        if _id != "":
            contact = Contact()
            self.write(contact.InitById(_id))
        else:
            self.write("error")

class AddressSaveHandler(BaseHandler):

    def get(self):

        id_contacto = self.get_argument("direccion","")
        nombre = self.get_argument("name","")
        email = self.get_argument("email","")
        direccion = self.get_argument("address","")
        ciudad = self.get_argument("city","")
        codigo_postal = self.get_argument("zip_code","")
        telefono = self.get_argument("telephone","")

        contact = Contact()

        contacto = json.loads(contact.InitById(id_contacto))

        contact.id = id_contacto
        contact.name = nombre
        contact.type = contacto["type_id"]
        contact.telephone = telefono
        contact.email = email
        contact.address = direccion
        contact.customer_id = contacto['customer_id']

        response_obj = contact.Edit()

        if "success" in response_obj:

            order = Order()
            order.type = 1
            order.subtotal = 0
            order.discount = 0
            order.tax = 0
            order.total = 0
            order.items = 0
            order.products = 0
            order.customer_id = contact.customer_id
            order.billing_id = contact.id
            order.address_id = contact.id
            order.shipping_id = contact.id

            response_obj = order.Save()

            if "success" in response_obj:
                self.redirect("/checkout/billing")
            else:
                self.write(response_obj["error"])

        # self.redirect("/checkout/billing")

class BillingSaveHandler(BaseHandler):

    def get(self):

        id_contacto = self.get_argument("direccion","")
        nombre = self.get_argument("name","")
        email = self.get_argument("email","")
        direccion = self.get_argument("address","")
        ciudad = self.get_argument("city","")
        codigo_postal = self.get_argument("zip_code","")
        telefono = self.get_argument("telephone","")

        contact = Contact()

        contacto = json.loads(contact.InitById(id_contacto))

        contact.id = id_contacto
        contact.name = nombre
        contact.type = contacto["type_id"]
        contact.telephone = telefono
        contact.email = email
        contact.address = direccion
        contact.customer_id = contacto['customer_id']

        response_obj = contact.Edit()

        if "success" in response_obj:

            order = Order()
            orden = order.GetLastOrderByCustomerId(contact.customer_id)

            order.type = orden["type"]
            order.subtotal = orden["subtotal"]
            order.discount = orden["discount"]
            order.tax = orden["tax"]
            order.total = orden["total"]
            order.items = orden["items"]
            order.products = orden["products"]
            order.customer_id = contact.customer_id
            order.billing_id = orden["billing_id"]
            order.address_id = contact.id
            order.shipping_id = orden["shipping_id"]

            response_obj = order.Edit()

            if "success" in response_obj:
                self.redirect("/checkout/shipping")
            else:
                self.write(response_obj["error"])

        # self.redirect("/checkout/billing")