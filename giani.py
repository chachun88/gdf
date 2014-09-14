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
import user_handler
import kardex_handler

define("port", default=port, help="run on the given port", type=int)
    
define("protocol", default="https", help="run on the given port", type=str)

class Application(tornado.web.Application):
    def __init__(self):
        handlers = [
            (r"/", home_handler.HomeHandler), #home
            (r"/store", store_handler.IndexHandler), #home de la tienda
            (r"/product/([^/]+)", store_handler.ProductHandler), #detalle producto
            (r"/user/save-guess", user_handler.AddAnonimousHandler), #crear anonimo
            (r"/kardex/getunitsbysize", kardex_handler.GetUnitsBySizeHandler), # stock segun item y sku
            (r"/cart/add",store_handler.AddToCartHandler) # agregar item al carro
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
