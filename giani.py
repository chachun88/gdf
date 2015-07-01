#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os
import tornado.httpserver
import tornado.web

from tornado.options import options, define

import home_handler
import store_handler
import auth
import user_handler
import kardex_handler
import checkout_handler
import error_handler
import server_handler
import others_handler
import profile_handler

from config import *
from lp.globals import *

define("nocache_static", default="static_v31", help="", type=str)

if "enviroment" not in options:

    define("enviroment", default=enviroment, type=str)
    define("db_name", default=DB_NAME, help="", type=str)
    define("db_user", default=DB_USER, help="", type=str)
    define("db_host", default=DB_HOST, help="", type=str)
    define("db_password", default=DB_PASSWORD, help="", type=str)


class Application(tornado.web.Application):
    def __init__(self):

        settings = dict(
            blog_title=u"Giani Da Firenze",
            template_path=os.path.join(os.path.dirname(__file__), "templates"),
            static_path=os.path.join(os.path.dirname(__file__), "static"),
            cookie_secret="12oETzKXQAGaYdkL5gEmGeJJFuYh7EQnp2XdTP1o/o=",
            facebook_api_key=options.facebook_api_key,
            facebook_secret=options.facebook_secret,
            login_url="/auth/login",
            autoescape=None,
            debug=True,
            xsrf_cookies=False
        )

        handlers = [
            (r'/{}/(.*)'.format(tornado.options.options["nocache_static"]),
             tornado.web.StaticFileHandler,
             {'path': os.path.join(os.path.dirname(__file__), "static")}),
            (r"/", home_handler.HomeHandler),  # home
            (r"/store", store_handler.IndexHandler),  # home de la tienda
            (r"/product/([^/]+)/([^/]+)/(.+)", store_handler.ProductHandler),  # detalle producto
            (r"/user/save-guess", user_handler.AddAnonimousHandler),  # crear anonimo
            (r"/user/exists", user_handler.UserExistHandler),  # verifica si usuario temporal existe
            (r"/kardex/getunitsbysize", kardex_handler.GetUnitsBySizeHandler),  # stock segun item y sku
            (r"/cart/add",store_handler.AddToCartHandler),  # agregar item al carro
            (r"/cart/getbyuserid", store_handler.GetCartByUserIdHandler),  # traer carro del usuario,
            (r"/cart/remove", store_handler.RemoveCartByIdHandler),
            (r"/cart/update", store_handler.UpdateCartQuantityHandler),
            (r"/store/voteproduct", store_handler.VoteProductHandler),
            (r"/store/product/ifvoted", store_handler.IfVotedHandler),
            (r"/store/product/getvotes", store_handler.GetVotesHandler),
            (r"/store/getproductsbytags/([^/]+)", store_handler.GetProductsByTagsHandler),
            (r"/store/filter", store_handler.FilterHandler),

            (r"/checkout/checkstock", checkout_handler.CheckStockHandler),
            (r"/checkout/address", checkout_handler.CheckoutAddressHandler),
            (r"/checkout/billing", checkout_handler.CheckoutBillingHandler),
            (r"/checkout/shipping", checkout_handler.CheckoutShippingHandler),
            (r"/checkout/payment", checkout_handler.CheckoutPaymentHandler),
            (r"/checkout/order", checkout_handler.CheckoutOrderHandler),
            (r"/checkout/send", checkout_handler.CheckoutSendHandler),

            (r"/checkout/getaddressbyid", checkout_handler.GetAddressByIdHandler),

            (r"/auth/login", auth.AuthHandler),
            (r"/auth/logout", auth.LogoutHandler),
            (r"/auth/registro", auth.UserRegistrationHandler),  # registro de usuarios
            (r"/auth/recuperar-contrasena", auth.PasswordRecovery),
            (r"/auth/nuevaclave/([^/]+)", auth.NewPasswordHandler),
            (r"/auth/facebook", auth.AuthFacebookHandler),
            (r"/auth/checkout", auth.ValidateUserCheckoutHandler),
            (r"/auth/enterprise-registration", auth.EnterpriseRegistrationHandler),
            (r"/auth/enterprise", auth.EnterpriseLoginHandler),
            (r"/checkout/success", auth.CheckoutSuccessHandler),

            (r"/error", error_handler.BeautyError),
            (r"/getserver", server_handler.ServerHandler),
            (r"/contact", others_handler.ContactHandler),
            (r"/kardextest", others_handler.KardexTestHandler),

            (r"/profile", profile_handler.ProfileHandler),
            (r"/profile/change_pass", profile_handler.ChangePassHandler),
            (r"/profile/edit_contact", profile_handler.EditContactHandler),
            (r"/profile/delete", profile_handler.DeleteContactHandler),
            (r"/profile/add_contact", profile_handler.AddContactHandler),

            (r"/tos", others_handler.TosHandler),
            (r"/pago", others_handler.PagoHandler),
            (r"/xt_compra", others_handler.XtCompraHandler),
            (r"/store/success", others_handler.ExitoHandler),
            (r"/store/failure", others_handler.FracasoHandler),
            (r"/aboutus", others_handler.AboutusHandler),
            (r"/history", others_handler.HistoryHandler),
            (r"/conditions", others_handler.ConditionsHandler),
            (r"/faq", others_handler.FaqHandler),
            (r"/user", others_handler.UserHandler),
            (r"/sitemap.xml()", tornado.web.StaticFileHandler, {'path':settings['static_path']+"/sitemap.xml"})
        ]

        tornado.web.Application.__init__(self, handlers, **settings) 


def main():
    tornado.options.parse_command_line()
    http_server = tornado.httpserver.HTTPServer(Application())
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()

if __name__ == "__main__":
    main()
