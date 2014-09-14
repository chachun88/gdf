#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os
import tornado.httpserver
import tornado.web
import urllib


from tornado.options import define, options

from globals import port, debugMode

import home_handler
import store_handler
import auth
import user_handler
import kardex_handler

define("port", default=port, help="run on the given port", type=int)
    
define("protocol", default="https", help="run on the given port", type=str)

define("email", help="remitente email", default="ricardo.silva.16761@gmail.com")
define("user", help="cuenta usuario remitente", default="ricardo.silva.16761@gmail.com")
define("password", help="clave remitente", default="yichunTAM")


if debugMode:
    # define("facebook_api_key", help="your Facebook application API key", default="348233998672458")
    # define("facebook_secret", help="your Facebook application secret", default="ba057d8acc18aea4819693c16ebee23a")
    define("facebook_api_key", help="your Facebook application API key", default="839753546059058")
    define("facebook_secret", help="your Facebook application secret", default="26bbd6af2dad046a3dd17b14ab81da67")
else:
    define("facebook_api_key", help="your Facebook application API key", default="839753546059058")
    define("facebook_secret", help="your Facebook application secret", default="26bbd6af2dad046a3dd17b14ab81da67")

class Application(tornado.web.Application):
    def __init__(self):
        handlers = [
            (r"/", home_handler.HomeHandler), #home
            (r"/store", store_handler.IndexHandler), #home de la tienda
            (r"/product/([^/]+)", store_handler.ProductHandler), #detalle producto
            (r"/user/save-guess", user_handler.AddAnonimousHandler), #crear anonimo
            (r"/kardex/getunitsbysize", kardex_handler.GetUnitsBySizeHandler), # stock segun item y sku
            (r"/cart/add",store_handler.AddToCartHandler), # agregar item al carro

            (r"/auth/login", auth.AuthHandler),
            (r"/auth/logout", auth.LogoutHandler),
            (r"/auth/registro", auth.UserRegistrationHandler), ## registro de usuarios
            (r"/auth/recuperar-contrasena", auth.PasswordRecovery),
            (r"/auth/nuevaclave/([^/]+)", auth.NewPasswordHandler),
            (r"/auth/facebook", auth.AuthFacebookHandler)
            
        ]
        settings = dict(
            blog_title=u"Giani Da Firenze",
            template_path=os.path.join(os.path.dirname(__file__), "templates"),
            static_path=os.path.join(os.path.dirname(__file__), "static"),
            cookie_secret="12oETzKXQAGaYdkL5gEmGeJJFuYh7EQnp2XdTP1o/Vo=",
            facebook_api_key=options.facebook_api_key,
            facebook_secret=options.facebook_secret,
            login_url="/auth/login",
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
