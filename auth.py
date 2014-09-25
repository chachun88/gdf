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
from model.cart import Cart

class UserRegistrationHandler(BaseHandler):    

    def get(self):
        ajax = self.get_argument("ajax", "0")

        if ajax == "0":
            self.render( "auth/login.ajax.html" )
        else:
            self.write( "auth/login.html" )

    def post(self):

        name = self.get_argument("name", "")
        email = self.get_argument("email", "")
        password = self.get_argument("password", "")
        re_password = self.get_argument("re-password", "")
        tos = self.get_argument("tos", "")
        ajax = self.get_argument("ajax", "false")
        user_id = int(self.get_argument("user_id",0))

        if name == "":
            self.write(json_util.dumps({"error":"debe ingresar su nombre"}))
            return
        elif email == "":
            self.write(json_util.dumps({"error":"debe ingresar el email"}))
            return
        elif password == "":
            self.write(json_util.dumps({"error":"debe ingresar la contraseña"}))
            return
        elif password != re_password:
            self.write(json_util.dumps({"error":"las contraseñas no coinciden"}))
            return
        elif tos != "on":
            self.write(json_util.dumps({"error":"debe aceptar las condiciones de uso"}))
            return
        elif User().Exist(email)["success"]:
            self.write(json_util.dumps({"error":"ya existe un usuario registrado con este email"}))
            return
        else:
            ### perform login

            user = User()
            user.name = name
            user.email = email
            user.password = password
            user.user_type = 'Cliente'

            if user_id != 0:
                user.id = user_id
                
            user.Save()

            response_obj = user.Login( user.email, user.password )

            if "success" in response_obj:
                self.set_secure_cookie( "user_giani", response_obj["success"] )
                self.write(json_util.dumps({"success":self.next}))

            ##redirect is the request isn't aajx
            if ajax == "false":
                self.redirect( self.next )

class AuthHandler(BaseHandler):

    def get(self):
        ajax = self.get_argument("ajax", "")

        if ajax == "":
            self.render( "auth/login.html" )
        else:
            self.render( "auth/login.ajax.html" )


    def post(self):

        email = self.get_argument("email", "")
        password = self.get_argument("password", "")
        stay_logged = self.get_argument("stay-logged", "")
        ajax = self.get_argument("ajax", "false")
        user_id = self.get_argument("user_id","")

        print "user_id {}".format(user_id)


        if email == "":
            self.write( "debe ingresar el email" )
        elif password == "":
            self.write( "debe ingresar la contraseña" )
        else:
            user = User()
            user.email = email
            user.password = password

            response_obj = user.Login( user.email, user.password )

            if "success" in response_obj:

                self.set_secure_cookie( "user_giani", response_obj["success"] )

                current_user_id = json_util.loads(response_obj["success"])["id"]

                if user_id != current_user_id:

                    cart = Cart()

                    response = cart.MoveTempToLoggedUser(user_id,current_user_id)

                if "error" in response:
                    rtn_obj = {"status":"error","message":"Usuario y contraseña no coinciden, error:{}".format(response["error"])}
                    self.write( json_util.dumps(rtn_obj) )
                    return

                rtn_obj = {"status":"ok","next":self.next,"user_id":current_user_id}
                self.write( json_util.dumps(rtn_obj) )

                if ajax == "false":
                    self.redirect( self.next )

            else:
                rtn_obj = {"status":"error","message":"Error:{}".format(response_obj["error"])}
                self.write( json_util.dumps(rtn_obj) )


class FormLoginHandler(BaseHandler):
    def get(self):
        self.render("formulario-log-in.html")

class FormRegisterHandler(BaseHandler):
    def get(self):
        self.render("form-register.html")

class AuthLogoutHandler(BaseHandler):
    def get(self):        
        self.clear_cookie("user_giani")
        self.redirect(self.next)

class AuthFacebookHandler(BaseHandler, tornado.auth.FacebookGraphMixin):
    @tornado.web.asynchronous
    def get(self):
        my_url = url_local + self.request.uri


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
        # print "lllllllllllll {}".format(user["access_token"])
        self.facebook_request("/me", access_token=user["access_token"], callback=self._save_user_profile)

    @tornado.web.asynchronous
    def _save_user_profile(self, user):

        if not user:
            raise tornado.web.HTTPError(500, "Facebook authentication failed.")

        user_id = self.get_argument("user_id","")

        usr = User()

        usr.name = user["name"]
        usr.email = user["email"]
        usr.user_type = 'Cliente'

        if user_id != "":
            usr.id = user_id

        response = usr.Exist(user["email"])

        if "success" in response:
            if not response["success"]:
                res = usr.Save()
                if "error" in res:
                    print res["error"]
        
        response_obj = usr.InitByEmail(user["email"])

        if "success" in response_obj:

            current_user_id = json_util.loads(response_obj["success"])["id"]

            if int(user_id) != int(current_user_id):

                cart = Cart()

                response = cart.MoveTempToLoggedUser(user_id,current_user_id)          

            self.set_secure_cookie("user_giani", response_obj["success"])

            self.redirect( self.next )

        else:

            print response_obj["error"]
            self.redirect("/auth/login")

        # else:

        #     self.write(response_obj["error"])
        
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
        
        # self.set_secure_cookie("user_giani", json_util.dumps(_user, sort_keys=True, indent=4, default=json_util.default))                                
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
        self.redirect( self.next )


        
class ValidateUserCheckoutHandler(BaseHandler):

    def get(self):
        try:
            if self.get_current_user():
                self.redirect( "/checkout/address" )
        except Exception,e:
            pass

        next = self.get_argument("next", "/")
        self.redirect( "/auth/login?next={}".format( tornado.escape.url_escape(self.next) ) )


class CheckoutSuccessHandler(BaseHandler):
    def get(self):
        self.render( "store/success.html" )
        