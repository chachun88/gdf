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
import hashlib

from tornado.options import define, options

from basehandler import BaseHandler
from model.user import User

class ProfileHandler(BaseHandler):

    def get(self):
        self.render("profile/index.html")

class ChangePassHandler(BaseHandler):

    def post(self):

        oldpass = self.get_argument("oldpass","")
        newpass = self.get_argument("newpass","")
        confirmpass = self.get_argument("confirmpass","")

        if self.current_user:
            user_id = self.current_user["id"]
            usuario = User().InitById(user_id)

            m = hashlib.md5()
            m.update(oldpass)
            password = m.hexdigest()

            if password == usuario["password"]:
                if newpass == confirmpass:
                    m = hashlib.md5()
                    m.update(newpass)
                    password = m.hexdigest()
                    User().ChangePassword(user_id, password)
                    self.write("exito")
                else:
                    self.write("claves ingresado no coinciden")
            else:
                self.write("clave incorrecta")