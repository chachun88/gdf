#!/usr/bin/python
# -*- coding: UTF-8 -*-

import hashlib
import tornado

from basehandler import BaseHandler
from model.user import User
from model.contact import Contact
from model.city import City
from bson import json_util


class ProfileHandler(BaseHandler):

    @tornado.web.authenticated
    def get(self):

        contactos = []

        if self.current_user:
            user_id = self.current_user["id"]
            contact = Contact()
            lista_contacto = contact.ListByUserId(user_id)

            if "success" in lista_contacto:
                contactos = json_util.loads(lista_contacto["success"])

        self.render("profile/index.html", contactos=contactos)


class ChangePassHandler(BaseHandler):

    def post(self):

        oldpass = self.get_argument("oldpass","")
        newpass = self.get_argument("newpass","")
        confirmpass = self.get_argument("confirmpass","")

        if self.current_user:
            user_id = self.current_user["id"]
            user = User()
            usuario = user.InitById(user_id)

            # codificar la contrasena ingresada
            m = hashlib.md5()
            m.update(oldpass)
            password = m.hexdigest()

            # compara la clave del usuario con la clave almacenada
            if password == usuario["password"]:
                # si la clave esta ingresada correctamente
                if newpass == confirmpass:
                    m = hashlib.md5()
                    m.update(newpass)
                    password = m.hexdigest()
                    user.ChangePassword(user_id, password)
                    self.write("exito")
                else:
                    self.write("claves ingresado no coinciden")
            else:
                self.write("clave incorrecta")


class EditContactHandler(BaseHandler):

    def post(self):
        name = self.get_argument("name","")
        address = self.get_argument("address","")
        town = self.get_argument("town","")
        city = self.get_argument("city","")
        zip_code = self.get_argument("zip_code","")
        telephone = self.get_argument("telephone","")

        ciudad = City()
        respuesta = ciudad.getIdByName(city)

        if "success" in respuesta:
            city_id = respuesta["success"]

        print "name: ", name, "\n"
        print "address: ", address, "\n"
        print "town: ", town, "\n"
        print "city: ", city, "\n"
        print "zip_code: ", zip_code, "\n"
        print "telephone: ", telephone, "\n"
