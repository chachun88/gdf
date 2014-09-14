#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basehandler import BaseHandler

from globals import debugMode

import psycopg2
import psycopg2.extras
import tornado.auth
from bson import json_util
import hashlib

from model.user import User

class UserRegistrationHandler(BaseHandler):    

    def get(self):
        self.render( "login.html" )

    def post(self):

        email = self.get_argument("email", "")
        re_email = self.get_argument("re-email", "")
        password = self.get_argument("password", "")
        re_password = self.get_argument("re-password", "")
        tos = self.get_argument("tos", "")

        if email == "":
            self.write( "debe ingresar el email" )
        elif email != re_email:
            self.write( "los email no coinciden" )
        elif password == "":
            self.write( "debe ingresar la contraseña" )
        elif password != re_password:
            self.write( "las contraseñas no coinciden" )
        elif tos != "on":
            self.write( "debe aceptar las condiciones de uso" )
        else:
            ### perform login
            self.write( "loged-in" )

            user = User()
            user.email = email
            user.password = password
            user.user_type = 'Cliente'

            user.Save()

            redirect = self.get_argument("next", "/")
            self.redirect( redirect )
            self.write( "ok" )


class AuthHandler(BaseHandler):

    def get(self):
        self.render( "login.html" )

    def post(self):

        email = self.get_argument("email", "")
        password = self.get_argument("password", "")
        stay_logged = self.get_argument("stay-logged", "")
        ajax = self.get_argument("ajax", "false")


        if email == "":
            self.write( "debe ingresar el email" )
        elif password == "":
            self.write( "debe ingresar la contraseña" )
        else:
            user = User()
            if user.Login( email, password ):

                ## setting user cookie 
                self.set_secure_cookie( "user_giani", email )
                self.write( "ok" )

                if ajax == "false":
                    redirect = self.get_argument("next", "/")
                    self.redirect( redirect )
            else:
                self.write( "login incorrecto" )


class FormLoginHandler(BaseHandler):
    def get(self):
        self.render("formulario-log-in.html")

class FormRegisterHandler(BaseHandler):
    def get(self):
        self.render("form-register.html")

class AuthLogoutHandler(BaseHandler):
    def get(self):        
        self.clear_cookie("user_emp_esc")
        self.redirect("/")

class AuthFacebookHandler(BaseHandler, tornado.auth.FacebookGraphMixin):
    @tornado.web.asynchronous
    def get(self):   

        my_url = "http://localhost:8892/login/facebook"

        if not debugMode:
            my_url = "http://dev.emprendedoresescolares.cl/login/facebook"
                   
        if self.get_argument("code", False):
            self.get_authenticated_user(
                redirect_uri=my_url,
                client_id=self.settings["facebook_api_key"],
                client_secret=self.settings["facebook_secret"],
                code=self.get_argument("code"),
                callback=self._on_auth)
            return
        self.authorize_redirect(redirect_uri=my_url,
                                client_id=self.settings["facebook_api_key"],
                                extra_params={"scope": "email"})
    
    def _on_auth(self, user):

        self.facebook_request("/me", access_token=user["access_token"], callback=self._save_user_profile)


    def _save_user_profile(self, user):

        if not user:
            raise tornado.web.HTTPError(500, "Facebook authentication failed.")        
                
        # conn = psycopg2.connect(conn_string)

        # cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

        # # self.write(user)

        # # return

        # cursor.execute("select * from \"user\" where email = %(email)s",{"email":user["email"]})

        # data = cursor.fetchone()

        # _user = {}

        # if data:
        #     _user["id"] = data["id"]
        #     _user["name"] = data["name"]
        #     _user["email"] = data["email"]
        #     _user["type"] = data["type"]
        #     _user["profile"] = data["profile"]

        #     print "ya existe"
        #     self.write("el usuario con el email ya existe")
        # else:            
            
        #     parameters = {"email":user["email"],"name":user["name"],"type":"facebook"}

        #     try:
        #         cursor.execute("insert into \"user\" (email, name, type) values (%(email)s,%(name)s,%(type)s)",parameters)
        #         conn.commit()
                
        #         try:
        #             cursor.execute("select * from \"user\" where email = %(email)s",{"email":user["email"]})
        #             data = cursor.fetchone()
        #             if data:
        #                 _user["id"] = data["id"]
        #                 _user["name"] = data["name"]
        #                 _user["email"] = data["email"]
        #                 _user["type"] = data["type"]
        #                 self.write("usuario creado correctamente")
        #         except Exception, e:
        #             self.write(str(e))
        #     except Exception,e:
        #         self.write(str(e))
        
        # self.set_secure_cookie("user_emp_esc", json_util.dumps(_user, sort_keys=True, indent=4, default=json_util.default))                                
        # self.redirect("/")

        pass



class PasswordRecovery(BaseHandler):
    

    def get(self):
        self.write("recuperar password")



class LogoutHandler(BaseHandler):
    
    def get(self):
        self.clear_cookie( "user_giani" )
        self.redirect( "/" )
        