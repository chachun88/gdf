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
#from model.customer import Customer

class AddAnonimousHandler(BaseHandler):

    def get(self):

        if not self.current_user:
            
            user = User()
            response_obj = user.Save()
            if "success" in response_obj:
                self.write(response_obj['success'])
            else:
                self.write(response_obj['error'])

        else:

            self.write("{}".format(self.current_user["id"]))

class UserExistHandler(BaseHandler):

    def get(self):

        user_id = self.get_argument("user_id","")

        if user_id != "":
            user = User()
            response_obj = user.Exist('',user_id)
            if "success" in response_obj:
                if response_obj["success"]:
                    self.write("true")
                else:
                    self.write("false")
            else:
                self.write("false")
        else:
            self.write("false")
