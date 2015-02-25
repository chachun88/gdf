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
        cities = []

        if self.current_user:
            user_id = self.current_user["id"]

            contact = Contact()
            response_contacto = contact.ListByUserId(user_id)

            if "success" in response_contacto:
                contactos = json_util.loads(response_contacto["success"])

            city = City()
            response_city = city.List()

            if "success" in response_city:
                cities = response_city["success"]

        self.render("profile/index.html", contactos=contactos, ciudades=cities)


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
                    self.write("El cambio fue exitoso")
                else:
                    self.write("Claves ingresadas no coinciden")
            else:
                self.write("Clave incorrecta")


class EditContactHandler(BaseHandler):

    def post(self):

        id = self.get_argument("id-contacto","")
        name = self.get_argument("name","")
        address = self.get_argument("address","")
        town = self.get_argument("town","")
        city = self.get_argument("city","")
        zip_code = self.get_argument("zip_code","")
        telephone = self.get_argument("telephone","")

        contacto = Contact()
        res_contact = contacto.InitById(id)

        if "success" in res_contact:
            datos = res_contact["success"]

            contacto.initialize(datos)

            contacto.name = name
            contacto.address = address
            contacto.town = town
            contacto.city = city
            contacto.zip_code = zip_code
            contacto.telephone = telephone

            ciudad = City()
            res_city = ciudad.getNameById(city)

            if "success" in res_city:
                contacto.Edit()
                self.write(json_util.dumps(res_city))


class DeleteContactHandler(BaseHandler):

    def post(self):

        id = self.get_argument("id","")

        contacto = Contact()

        response = contacto.RemoveOneContact(id)

        if "success" in response:
            self.write("El contacto fue eliminado exitosamente")
        else:
            self.write("No fue posible eliminar el contacto")


class AddContactHandler(BaseHandler):

    def post(self):

        name = self.get_argument("name","")
        lastname = self.get_argument("lastname","")
        email = self.get_argument("email","")
        rut = self.get_argument("rut","")
        address = self.get_argument("address","")
        town = self.get_argument("town","")
        city = self.get_argument("city_id","")
        zip_code = self.get_argument("zip_code","")
        additional_info = self.get_argument("additional_info","")
        telephone = self.get_argument("telephone","")

        if self.current_user:
            user_id = self.current_user["id"]
            contacto = Contact()

            contacto.name = name
            contacto.lastname = lastname
            contacto.email = email
            contacto.rut = rut
            contacto.address = address
            contacto.town = town
            contacto.city = city
            contacto.zip_code = zip_code
            contacto.additional_info = additional_info
            contacto.telephone = telephone
            contacto.user_id = user_id

            response = contacto.Save()

            if "success" in response:
                id = response["success"]
                ciudad = City()
                res_city = ciudad.getNameById(city)

                if "success" in res_city:
                    res_city["success"]["id_contact"] = id
                    self.write(json_util.dumps(res_city))
