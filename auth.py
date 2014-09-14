#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basehandler import BaseHandler

from globals import debugMode

import psycopg2
import psycopg2.extras
import tornado.auth
from bson import json_util
import hashlib

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
            # conn = psycopg2.connect(conn_string)

            # cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
            
            # cursor.execute("SELECT * FROM \"user\" WHERE email = %(user_mail)s limit 1",{"user_mail":user_mail})

            # user = cursor.fetchone()
            
            # if user:
            #     self.write("Usuario ya existe")
            # else:

            #     m = hashlib.md5()

            #     m.update(password)

            #     password = m.hexdigest()

            #     user = {
            #         "name": username,
            #         "email": user_mail,
            #         "pass": password,
            #         "type": "registrado"
            #     }

            #     query = "INSERT INTO \"user\" (name,email,pass,type) VALUES (%(name)s,%(email)s,%(pass)s,%(type)s)"

            #     try:
            #         cursor.execute(query,user)
            #         conn.commit()
            #         self.write("ok")
            #     except Exception, e:
            #         self.write(str(e))
            #     finally:
            #         cursor.close()
            #         conn.close()

            pass
            
            

class AuthHandler(BaseHandler):

    def post(self):

        # conn = psycopg2.connect(conn_string)

        # cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

        # user_passowrd = self.get_argument("user_password","")
        # user_mail = self.get_argument("user_mail","")
        # msj = ""
        
        # if user_mail == "":
        #     msj = "Ingrese email"
        #     self.render("mensaje.html", msj = msj)
        
        # if user_passowrd == "":
        #     msj = "Ingrese contraseña"
        #     self.render("mensaje.html", msj = msj)
            
        # cursor.execute("SELECT * FROM \"user\" WHERE email = %(user_mail)s LIMIT 1",{"user_mail":user_mail})

        # user=cursor.fetchone()
        
        # if not user:            
        #     msj = "No existe usuario asociado al email ingresado"
        #     self.render("mensaje.html", msj = msj)
        # else:

        #     n = hashlib.md5()
        #     n.update(user_passowrd)
        #     user_passowrd  = n.hexdigest()

        #     if user["pass"] == user_passowrd: 
                
        #         self.set_secure_cookie("user_emp_esc", json_util.dumps(user, sort_keys=True, indent=4, default=json_util.default))  
        #         self.write("ok")
        #     else:
        #         msj = "Clave ingresada no es válida"
        #         self.render("mensaje.html", msj = msj) 

        pass

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