#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basehandler import BaseHandler

from globals import url_local

import psycopg2
import psycopg2.extras
import tornado.auth
from bson import json_util
import hashlib

from model.user import User, UserType

class UserRegistrationHandler(BaseHandler):    

    def get(self):
        ajax = self.get_argument("ajax", "0")

        if ajax == "1":
            self.render( "auth/login.ajax.html" )
        else:
            self.render( "auth/login.html" )

    def post(self):

        name = self.get_argument("name", "")
        email = self.get_argument("email", "")
        password = self.get_argument("password", "")
        re_password = self.get_argument("re-password", "")
        tos = self.get_argument("tos", "")
        ajax = self.get_argument("ajax", "false")

        if email == "":
            self.write( "debe ingresar el email" )
        elif name == "":
            self.write( "debe ingresar su nombre" )
        elif password == "":
            self.write( "debe ingresar la contraseña" )
        elif password != re_password:
            self.write( "las contraseñas no coinciden" )
        elif tos != "on":
            self.write( "debe aceptar las condiciones de uso" )
        elif (User()).Exist( email ):
            self.write( "ya existe un usuario registrado con este email" )
        else:
            ### perform login
            self.write( "ok" )

            user = User()
            user.name = name
            user.email = email
            user.password = password
            user.user_type = 'Cliente'

            user.Save()

            if user.Login( user.email, user.password ):
                self.set_secure_cookie( "user_giani", user.email )

            ##redirect is the request isn't aajx
            if ajax == "false":
                redirect = self.get_argument("next", "/")
                self.redirect( redirect )

class AuthHandler(BaseHandler):

    def get(self):
        self.render( "auth/login.ajax.html" )

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
        my_url = url_local + "/auth/facebook"


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

        self.set_secure_cookie("user_giani", user["email"])

        usr = User()
        usr.name = user["name"]
        usr.email = user["email"]
        usr.user_type = UserType.CLIENTE

        if not usr.Exist( usr.email ):
            usr.Save()

        self.redirect( "/" )
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

        self.render( "auth/password_recovery.html" )

    def post(self):
        try:
            email = self.get_argument("email", "")

            if email == "":
                raise Exception( "El email ingresado no es válido" )
            if (User()).PassRecovery( email ):
                # self.write( "se ha enviado un correo" )
                self.render( "auth/success.html" )
            else:
                # self.write( "no se ha podido recuperar la contraseña" )
                self.render( "auth/fail.html", message="no se ha podido recuperar la contraseña" )
        except Exception, e:
            self.render( "auth/fail.html", message=str(e) )


class NewPasswordHandler(BaseHandler):
    

    def get(self, id):
        try:
            self.render( "auth/change_password.html", id=id )

        except Exception, e:
            print str( e )
            self.write( "error al iniciar usuaio" )

    def post(self, id):
        try:
            user = (User()).InitById( id )


            clave_ant = self.get_argument("claveant", "")
            clave_nva = self.get_argument("clavenva", "")
            clave_nva_rep = self.get_argument("clavenvarep", "")


            if clave_ant == user["password"] and clave_nva == clave_nva_rep and clave_nva != "":
                (User()).ChangePassword( id, clave_nva )
                self.render( "auth/fail.html", message="se ha cambiado correctamente" )
                return

            raise Exception( "no se puedo cambiar el usuario" )
        except Exception, e:
            print str( e )
            self.render( "auth/fail.html", message="error al cambiar contrasña" )


class LogoutHandler(BaseHandler):
    
    def get(self):
        self.clear_cookie( "user_giani" )
        self.redirect( "/" )


        
class ValidateUserCheckoutHandler(BaseHandler):

    def get(self):
        try:
            if (User()).Exist( self.get_current_user() ):
                self.redirect( "/checkout/address" )
        except Exception,e:
            pass

        self.redirect( "/auth/login?ajax=0" )


class CheckoutSuccessHandler(BaseHandler):
    def get(self):
        self.render( "store/success.html" )
        