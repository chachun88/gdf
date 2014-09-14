#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os
import tornado.httpserver
import tornado.web
import urllib


from tornado.options import define, options

from globals import port

import home_handler
import store_handler
import auth
import user_handler

define("port", default=port, help="run on the given port", type=int)
    
define("protocol", default="https", help="run on the given port", type=str)

define("email", help="remitente email", default="ricardo.silva.16761@gmail.com")
define("user", help="cuenta usuario remitente", default="ricardo.silva.16761@gmail.com")
define("password", help="clave remitente", default="yichunTAM")

class Application(tornado.web.Application):
    def __init__(self):
        handlers = [
            (r"/", home_handler.HomeHandler), #home
            (r"/store", store_handler.IndexHandler), #home de la tienda
            (r"/product/([^/]+)", store_handler.ProductHandler),
            (r"/product/([^/]+)", store_handler.ProductHandler), #detalle producto
            (r"/user/save-guess", user_handler.AddAnonimousHandler), #crear anonimo

            (r"/auth/login", auth.AuthHandler),
            (r"/auth/logout", auth.LogoutHandler),
            (r"/auth/registro", auth.UserRegistrationHandler), ## registro de usuarios
            (r"/auth/recuperar-contrasena", auth.PasswordRecovery),
            (r"/auth/nuevaclave/([^/]+)", auth.NewPasswordHandler)
        ]
        settings = dict(
            blog_title=u"Giani Da Firenze",
            template_path=os.path.join(os.path.dirname(__file__), "templates"),
            static_path=os.path.join(os.path.dirname(__file__), "static"),
            cookie_secret="12oETzKXQAGaYdkL5gEmGeJJFuYh7EQnp2XdTP1o/Vo=",
            autoescape=None,
            debug=True,
            xsrf_cookies= False
        )
        tornado.web.Application.__init__(self, handlers, **settings) 

        
def main():
    tornado.options.parse_command_line()
    http_server = tornado.httpserver.HTTPServer(Application())
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()

if __name__ == "__main__":
    main()
