#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basehandler import BaseHandler, valida, isEmailValid

from globals import *

import tornado.auth
from bson import json_util
import hashlib

from model.user import User, UserType
from model.cart import Cart
from model.contact import Contact
from model.city import City

from sendpassword import RegistrationEmail

import sendgrid
import os.path
from tornado import template


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

        # print tos

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
        else:

            response = User().Exist(email)

            if "success" in response:
                if response["success"]:
                    self.write(json_util.dumps({"error":"ya existe un usuario registrado con este email"}))
                    return
            else:
                self.write(json_util.dumps({"error":"se ha producido un error {}".format(response['error'])}))
                return

            # perform login

            user = User()
            user.name = name
            user.email = email
            user.password = password
            user.user_type = UserType.CLIENTE
            user.status = User.ACEPTADO

            if user_id != 0:
                existe = User().Exist('', user_id)
                if "success" in existe:
                    if existe["success"]:
                        user.id = user_id

            user.Save()

            RegistrationEmail(user.name,user.email)

            response_obj = user.Login( user.email, user.password )

            if "success" in response_obj:

                self.set_secure_cookie( "user_giani", response_obj["success"], expires_days=None )

                current_user_id = json_util.loads(response_obj["success"])["id"]

                if user_id != current_user_id:

                    cart = Cart()

                    response = cart.MoveTempToLoggedUser(user_id,current_user_id)

                self.write(json_util.dumps({"success":self.next}))
                return
            else:
                self.write(json_util.dumps({"error": str(response_obj)}))
                return

            # redirect is the request isn't aajx
            if ajax == "false":
                self.set_secure_cookie( "user_giani", response_obj["success"], expires_days=None )
                self.write(json_util.dumps({"success":self.next}))


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
        ajax = self.get_argument("ajax", "false")
        user_id = self.get_argument("user_id","")

        # print "user_id {}".format(user_id)

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

                self.set_secure_cookie( "user_giani", response_obj["success"], expires_days=None )

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
        usr.user_type = UserType.VISITA

        if user_id != "":
            usr.id = user_id

        response = usr.Exist(user["email"])

        if "success" in response:
            if not response["success"]:
                res = usr.Save()
                RegistrationEmail(usr.name,usr.email)
                if "error" in res:
                    print res["error"]

        else:
            self.render( "auth/fail.html", message=response["error"] )

        response_obj = usr.InitByEmail(user["email"])

        print response_obj

        if "success" in response_obj:

            current_user_id = json_util.loads(response_obj["success"])["id"]

            # print "user_id: {} current_user_id: {}".format(str(user_id),str(current_user_id))

            if user_id != "":

                if str(user_id) != str(current_user_id):

                    cart = Cart()

                    response = cart.MoveTempToLoggedUser(user_id,current_user_id)

                    if "error" in response:
                        print "Error moving cart detail: {}".format(response["error"])

            self.set_secure_cookie("user_giani", response_obj["success"], expires_days=0.02)

            self.redirect( self.next )

        else:

            self.render( "auth/fail.html", message=response_obj["error"] )

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
            clave_ant = self.get_argument("clave", "")
            self.render( "auth/change_password.html", id=id, old_pass=clave_ant )

        except Exception, e:
            print str( e )
            self.write( "error al iniciar usuaio" )

    def post(self, id):
        try:
            user = (User()).InitById( id )

            clave_ant = self.get_argument("claveant", "")
            clave_nva = self.get_argument("clavenva", "")
            clave_nva_rep = self.get_argument("clavenvarep", "")

            m = hashlib.md5()

            m.update(clave_ant)

            password = m.hexdigest()

            if password == user["password"] and clave_nva == clave_nva_rep and clave_nva != "":
                try:

                    m = hashlib.md5()

                    m.update(clave_nva)

                    new_password = m.hexdigest()

                    (User()).ChangePassword( id, new_password )
                    self.render( "auth/fail.html", message="se ha cambiado correctamente" )
                except Exception,e:
                    print str( e )
                    self.render( "auth/fail.html", message="error al cambiar contrasña" )

        except Exception, e:
            print str( e )
            self.render( "auth/fail.html", message="error al cambiar contrasña" )


class LogoutHandler(BaseHandler):

    def get(self):
        self.clear_cookie( "user_giani" )
        self.redirect( "/" )


class ValidateUserCheckoutHandler(BaseHandler):

    def get(self):
        if self.current_user:
            self.redirect( "/checkout/address" )
        else:
            self.redirect( "/auth/login?next={}".format( tornado.escape.url_escape(self.next) ) )


class CheckoutSuccessHandler(BaseHandler):
    def get(self):
        self.render( "store/success.html" )


class EnterpriseRegistrationHandler(BaseHandler):

    @staticmethod
    def generateMail(file_name, **kwargs):
        base_directory = os.path.join("templates", "mail")
        loader = template.Loader(base_directory)
        return loader.load(file_name).generate(**kwargs)

    def post(self):

        nombre = self.get_argument("name","")
        giro = self.get_argument("bussiness","")
        rut = self.get_argument("rut","")
        email = self.get_argument("email","")
        direccion = self.get_argument("address","")
        region = self.get_argument("state","")
        provincia = self.get_argument("city","")
        comuna = self.get_argument("town","")
        clave = self.get_argument("password","")
        rep_clave = self.get_argument("re-password","")

        if nombre.strip() == "":
            return json_util.dumps({"state": 0, "message": "Debe ingresar nombre"})
        elif giro.strip() == "":
            return json_util.dumps({"state": 0, "message": "Debe ingresar giro"})
        elif rut.strip() == "":
            return json_util.dumps({"state": 0, "message": "Debe ingresar rut"})
        elif not valida(rut.strip().replace("-","").replace(".","")):
            return json_util.dumps({"state": 0, "message": "Rut ingresado no es válido"})
        elif email.strip() == "":
            return json_util.dumps({"state": 0, "message": "Debe ingresar email"})
        elif not isEmailValid(email):
            return json_util.dumps({"state": 0, "message": "Email ingresado no es válido"})
        elif direccion.strip() == "" or region == "" or provincia == "" or comuna == "":
            return json_util.dumps({"state": 0, "message": "Debe ingresar su dirección completa"})
        elif clave.strip() == "":
            return json_util.dumps({"state": 0, "message": "Debe ingresar clave"})
        elif rep_clave.strip() != clave.strip():
            return json_util.dumps({"state": 0, "message": "Las claves ingresadas no coinciden"})

        rut = rut.strip().replace(".", "").replace("-", "").lower()

        user = User()
        user.name = nombre
        user.password = clave
        user.email = email
        user.user_type = UserType.EMPRESA
        user.bussiness = giro
        user.rut = rut
        user.status = User.PENDIENTE
        res_save = user.Save()

        user_id = None

        if "error" in res_save:
            self.write(json_util.dumps(res_save))
        else:
            user_id = res_save["success"]

            contact = Contact()
            contact.town = "{}, {}".format(comuna.encode("utf-8"),region.encode("utf-8")) 
            contact.address = direccion
            contact.user_id = user_id
            contact.city = None

            try:
                html = self.generateMail(
                                "registro_mayorista.html",
                                name=nombre.encode('utf-8'),
                                bussiness=giro.encode('utf-8'),
                                email=email.encode('utf-8'),
                                address=direccion.encode('utf-8'),
                                state=region.encode('utf-8'),
                                city=provincia.encode('utf-8'),
                                town=comuna.encode('utf-8'),
                                rut=rut,
                                url_local=url_local)

                sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
                mensaje = sendgrid.Mail()
                mensaje.set_from(
                    "{nombre} <{mail}>".format(nombre=nombre, mail=email))
                mensaje.add_to(to_giani)
                mensaje.set_subject("Registro Mayorista GDF")
                mensaje.set_html(html)
                status, msg = sg.send(mensaje)

                # print status

            except Exception, e:
                print str(e)

            try:
                html = self.generateMail(
                                "registro_mayorista_cliente.html",
                                name=nombre.encode('utf-8'))

                sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
                mensaje = sendgrid.Mail()
                mensaje.set_from(
                    "{nombre} <{mail}>".format(nombre='Giani Da Firenze', mail=email_giani))
                mensaje.add_to(email)
                mensaje.set_subject("Registro Mayorista GDF")
                mensaje.set_html(html)
                status, msg = sg.send(mensaje)

                # print msg

            except Exception, e:
                print str(e)

            self.write(json_util.dumps(contact.Save()))


class EnterpriseLoginHandler(BaseHandler):

    def post(self):

        rut = self.get_argument("rut","")
        password = self.get_argument("password","")

        if rut.strip() == "" or password.strip() == "":
            return json_util.dumps({"state": 0, "message": "Debe ingresar rut y contraseña"})
        else:
            rut = rut.strip().replace(".", "").replace("-", "").lower()

        user = User()
        res_login = user.enterpriseLogin(rut, password)

        if "success" in res_login:
            self.set_secure_cookie( "user_giani", res_login["success"], expires_days=None )
            self.write(json_util.dumps({"success":self.request.headers.get('Referer')}))
        else:
            self.write(json_util.dumps(res_login))
