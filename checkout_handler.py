#!/usr/bin/python
# -*- coding: utf-8 -*-

import tornado.auth
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
from basehandler import BaseHandler
import pytz

import uuid

from model.cart import Cart
from model.contact import Contact
from model.size import Size
from model.order import Order
from model.order_detail import OrderDetail
from model.kardex import Kardex
from model.cellar import Cellar
from model.product import Product
from model.city import City
from model.shipping import Shipping
from model.user import User, UserType

from datetime import datetime
from bson import json_util
import sendgrid
from globals import *


class CheckoutAddressHandler(BaseHandler):

    @tornado.web.authenticated
    def get(self):

        if self.current_user:

            user_id = self.current_user["id"]

            contact = Contact()
            response_obj = contact.ListByUserId(user_id)

            contactos = []
            cities = []

            if "success" in response_obj:
                contactos = json_util.loads(response_obj["success"])
            # else:
            #     self.render("beauty_error.html",message="Error al obtener la lista de contactos:{}".format(response_obj["error"]))
            #     return

            # use globals default to avoid exception
            web_cellar_id = cellar_id

            c = Cellar()
            res_cellar_id = c.GetWebCellar()

            if "success" in res_cellar_id:
                web_cellar_id = res_cellar_id["success"]

            cart = Cart()
            cart.user_id = user_id
            lista = cart.GetCartByUserId()

            suma = 0

            for l in lista:
                suma += l["subtotal"]

            res_web_cellar = c.InitById(web_cellar_id)

            if "success" in res_web_cellar:
                cellar_city_id = c.city_id

            city = City()
            city.from_city_id = cellar_city_id
            res_city = city.ListByFromCityId()
            # print res_city

            if suma > 0:
                if "success" in res_city:
                    cities = res_city["success"]

                self.render("store/checkout-1.html",contactos=contactos,data=lista,suma=suma,cities=cities)
            else:
                self.render("beauty_error.html",message="Carro est&aacute; vac&iacute;o")

        else:
            self.redirect("/auth/login")

        # else:
        #   self.write(response_obj["error"])


class CheckoutBillingHandler(BaseHandler):

    @tornado.web.authenticated
    def get(self):

        if self.current_user:
            user_id = self.current_user["id"]
            nombre = self.get_argument("name", self.current_user["name"])
            apellido = self.get_argument("lastname", self.current_user["lastname"])
            email = self.get_argument("email", self.current_user["email"])
            direccion = self.get_argument("address","")
            ciudad = self.get_argument("city_id","")
            codigo_postal = self.get_argument("zip_code","")
            informacion_adicional = self.get_argument("additional_info","")
            telefono = self.get_argument("telephone","")
            id_contacto = self.get_argument("contact_id","")
            comuna = self.get_argument("town","")
            rut = self.get_argument("rut","")

            cart = Cart()
            cart.user_id = user_id

            lista = cart.GetCartByUserId()

            if len(lista) <= 0:
                self.render("beauty_error.html",message="Carro est&aacute; vac&iacute;o")

            contact = Contact()

            contact.name = nombre
            contact.lastname = apellido
            contact.telephone = telefono
            contact.email = email
            contact.address = direccion
            contact.city = ciudad
            contact.zip_code = codigo_postal
            contact.user_id = user_id
            contact.additional_info = informacion_adicional
            contact.town = comuna
            contact.rut = rut

            operacion = ""

            if id_contacto != "":
                contact.id = id_contacto
                response_obj = contact.Edit()
                operacion = "editar"
            else:
                response_obj = contact.Save()
                operacion = "guardar"

            if "error" in response_obj:
                self.render("beauty_error.html",message="Error al {} contacto {}".format(operacion,response_obj["error"]))
            else:

                items = 0
                suma = 0

                for l in lista:
                    c = Cart()
                    response_obj = c.InitById(l["id"])

                    if "success" in response_obj:
                        c.shipping_id = contact.id
                        c.Edit()
                    else:
                        print response_obj["error"]

                    suma += l["subtotal"]
                    items += l["quantity"]

                contactos = []
                cities = []

                response_obj = contact.ListByUserId(user_id)

                city = City()
                res_city = city.List()

                if "success" in response_obj:
                    contactos = json_util.loads(response_obj["success"])

                if "success" in res_city:
                    cities = res_city["success"]

                c = Cellar()
                res_cellar_id = c.GetWebCellar()

                web_cellar_id = cellar_id

                if "success" in res_cellar_id:
                    web_cellar_id = res_cellar_id["success"]

                res_web_cellar = c.InitById(web_cellar_id)

                if "success" in res_web_cellar:
                    cellar_city_id = c.city_id

                    shipping = Shipping()
                    shipping.from_city_id = int(cellar_city_id)
                    shipping.to_city_id = int(ciudad)

                res = shipping.GetGianiPrice()

                if "error" in res:
                    self.render("beauty_error.html",message="Error al calcular costo de despacho, {}".format(res["error"]))
                else:
                    if shipping.charge_type == 1:
                        costo_despacho = shipping.price * items
                    else:
                        costo_despacho = shipping.price

                    self.render("store/checkout-2.html",contactos=contactos,data=lista,suma=suma,selected_address=direccion,cities=cities,costo_despacho=costo_despacho)
        else:

            self.redirect("/auth/login")

    @tornado.web.authenticated
    def post(self):
        self.get()


class CheckoutShippingHandler(BaseHandler):

    def get(self):

        if not self.current_user:

            self.render("beauty_error.html", message='Debes iniciar sesion para continuar')

    def post(self):

        if self.current_user:

            costo_despacho = int(self.get_argument("shipping_price",0))
            user_id = self.current_user["id"]
            nombre = self.get_argument("name", self.current_user["name"])
            apellido = self.get_argument("lastname", self.current_user["lastname"])
            email = self.get_argument("email", self.current_user["email"])
            direccion = self.get_argument("address","")
            ciudad = self.get_argument("city_id","")
            codigo_postal = self.get_argument("zip_code","")
            informacion_adicional = self.get_argument("additional_info","")
            telefono = self.get_argument("telephone","")
            id_contacto = self.get_argument("contact_id","")
            misma_direccion = self.get_argument("same_address","")
            comuna = self.get_argument("town","")
            rut = self.get_argument("rut","")

            cart = Cart()
            cart.user_id = user_id

            lista = cart.GetCartByUserId()

            if len(lista) <= 0:
                self.render("beauty_error.html",message="Carro est&aacute; vac&iacute;o")

            if misma_direccion != "on":

                contact = Contact()

                contact.name = nombre
                contact.lastname = apellido
                contact.telephone = telefono
                contact.email = email
                contact.address = direccion
                contact.city = ciudad
                contact.zip_code = codigo_postal
                contact.user_id = user_id
                contact.additional_info = informacion_adicional
                contact.town = comuna
                contact.rut = rut

                operacion = ""

                if id_contacto != "":
                    contact.id = id_contacto    
                    response_obj = contact.Edit()
                    operacion = "editar"
                else:
                    response_obj = contact.Save()
                    operacion = "guardar"

                if "error" in response_obj:
                    self.render("beauty_error.html",message="Error al {} contacto {}".format(operacion,response_obj["error"]))
                else:
                    suma = 0

                    for l in lista:
                        c = Cart()
                        c.InitById(l["id"])
                        c.billing_id = contact.id
                        c.Edit()
                        suma += l["subtotal"]

                    # self.render("store/checkout-2.html",contactos=contactos,data=lista,suma=suma,selected_address=direccion)
                    if self.current_user['type_id'] == User().getUserTypeID(UserType.EMPRESA):
                        self.render("wholesaler/checkout-4.html",data=lista,suma=suma,iva=iva)
                    else:
                        self.render("store/checkout-3.html",data=lista,suma=suma,costo_despacho=costo_despacho)
            else:

                cart = Cart()
                cart.user_id = user_id

                lista = cart.GetCartByUserId()

                suma = 0

                for l in lista:
                    c = Cart()
                    c.InitById(l["id"])
                    c.billing_id = c.shipping_id
                    c.Edit()
                    suma += l["subtotal"]

                if self.current_user['type_id'] == User().getUserTypeID(UserType.EMPRESA):
                    self.render("wholesaler/checkout-4.html",data=lista,suma=suma,iva=iva)
                else:
                    self.render("store/checkout-3.html",data=lista,suma=suma,costo_despacho=costo_despacho)

        else:

            self.redirect("/auth/login")


class CheckoutPaymentHandler(BaseHandler):

    @tornado.web.authenticated
    def post(self):

        if self.current_user:

            shipping_type = self.get_argument("shipping_type",1)
            costo_despacho = int(self.get_argument("shipping_price",0))          

            user_id = self.current_user["id"]

            cart = Cart()
            cart.user_id = user_id

            lista = cart.GetCartByUserId()

            if len(lista) <= 0:
                self.render("beauty_error.html",message="Carro est&aacute; vac&iacute;o")

            suma = 0

            for l in lista:
                c = Cart()
                c.InitById(l["id"])
                c.shipping_type = shipping_type
                c.Edit()
                suma += l["subtotal"]

            if self.current_user['type_id'] != User().getUserTypeID(UserType.EMPRESA):
                self.render("store/checkout-4.html",
                            data=lista,
                            suma=suma,
                            costo_despacho=costo_despacho,
                            pytz=pytz)
            else:
                self.render("wholesaler/checkout-5.html",
                            data=lista,
                            suma=suma,
                            iva=iva,
                            pytz=pytz)
        else:
            self.redirect("/auth/login")

    def get(self):

        self.redirect("/auth/login")


class CheckoutOrderHandler(BaseHandler):

    @tornado.web.authenticated
    def post(self):

        if self.current_user:

            print self.current_user

            user_id = self.current_user["id"]

            cart = Cart()
            cart.user_id = user_id

            lista = cart.GetCartByUserId()

            if len(lista) <= 0:
                self.render("beauty_error.html",message="Carro est&aacute; vac&iacute;o")

            suma = 0

            for l in lista:
                suma += l["subtotal"]

            costo_despacho = int(self.get_argument("shipping_price",0))

            self.render("store/checkout-5.html",data=lista,suma=suma,costo_despacho=costo_despacho)
        else:
            self.redirect("/auth/login")

        # cart = Cart()
        # user = User()
        # cart.user_id = user.GetUserId(self.current_user)
        # data = cart.GetCartByUserId()
        # self.render("store/checkout-5.html",data=data)


class CheckoutWhosaleOrderHandler(BaseHandler):
    pass

class CheckoutSendHandler(BaseHandler):

    @tornado.web.authenticated
    def post(self):

        id_bodega = cellar_id
        cellar = Cellar()
        res_cellar = cellar.GetWebCellar()
        if "success" in res_cellar:
            id_bodega = res_cellar["success"]

        cart = Cart()
        cart.user_id = self.current_user["id"]

        lista = cart.GetCartByUserId()

        final_name = ""

        # print self.request.files

        if "image" in self.request.files:

            imagedata = self.request.files['image'][0]

            filename = imagedata["filename"]

            extension = filename.lower().split(".")[-1]

            final_name = "{filename}.{extension}".format(filename=uuid.uuid4(),extension=extension)
            # print final_name

            try:
                # fn = imagedata["filename"]
                file_path = dir_image + final_name

                open(file_path, 'wb').write(imagedata["body"])
            except Exception, e:
                print str(e)
                pass

        payment_type = self.get_argument("payment_type",1)
        shipping_price = int(self.get_argument("shipping_price",0))
        order_tax = int(float(self.get_argument("tax", 0)))

        if self.current_user:
            user_id = self.current_user["id"]

        order = Order()

        if len(lista) > 0:

            for l in lista:
                c = Cart()
                c.InitById(l["id"])
                c.payment_type = payment_type
                c.Edit()

            lista = cart.GetCartByUserId()

            if len(lista) > 0:

                subtotal = 0
                iva = 0
                cantidad_items = 0
                cantidad_productos = 0
                id_facturacion = 0
                id_despacho = 0
                tipo_pago = 0
                total = 0

                for l in lista:
                    subtotal += l["subtotal"]
                    cantidad_items += l["quantity"]
                    cantidad_productos += 1
                    id_facturacion = l["billing_id"]
                    id_despacho = l["shipping_id"]
                    tipo_pago = l["shipping_type"]
                    total += l["subtotal"]

                order.date = datetime.now(pytz.timezone('Chile/Continental')).isoformat()
                order.type = 1
                order.subtotal = subtotal
                order.shipping = shipping_price
                order.tax = order_tax
                order.total = total + shipping_price + order_tax
                order.items_quantity = cantidad_items
                order.products_quantity = cantidad_productos
                order.user_id = user_id
                order.billing_id = id_facturacion
                order.shipping_id = id_despacho
                order.payment_type = tipo_pago
                order.voucher = final_name

                response_obj = order.Save()

                if "success" in response_obj:

                    detalle_orden = ""

                    for l in lista:

                        detail = OrderDetail()
                        detail.order_id = order.id
                        detail.quantity = l["quantity"]
                        detail.subtotal = l["subtotal"]
                        detail.product_id = l["product_id"]
                        detail.size = l["size"]
                        detail.price = l['price']
                        detail.Save()

                        # if "error" in res_obj:
                        #     print "{}".format(res_obj["error"])

                        detalle_orden += """\
                            <tr>
                                <td style="line-height: 2.5;border-left: 1px solid #d6d6d6; margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{quantity}</td>
                                <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{name}</td>
                                <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{color}</td>
                                <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{size}</td>
                                <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {price}</td>
                                <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {subtotal}</td>
                            </tr>
                        """.format(name=l["name"],size=l["size"],quantity=l["quantity"],color=l["color"],price=self.money_format(l["price"]),subtotal=self.money_format(l["subtotal"]))

                    contact = Contact()
                    facturacion_response = contact.InitById(order.billing_id)

                    if "success" in facturacion_response:
                        facturacion = facturacion_response["success"]
                    else:
                        self.render("beauty_error.html",message="Error al obtener datos de facturación, {}".format(facturacion_response["error"]))

                    despacho_response = contact.InitById(order.shipping_id)

                    if "success" in despacho_response:
                        despacho = despacho_response["success"]
                    else:
                        self.render("beauty_error.html",message="Error al obtener datos de despacho, {}".format(despacho_response["error"]))

                    order_shipping = "${}".format(self.money_format(order.shipping))
                    valor_iva = ''

                    if order_tax > 0:
                        valor_iva = '''
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">IVA</th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {order_tax}</td>
                        </tr>
                        '''.format(order_tax=order_tax)
                        order_shipping = 'Por pagar'

                    datos_facturacion = """\
                    <table cellspacing="0" style="width:80%; margin:0 auto; padding:5px 5px;color:#999999;-webkit-text-stroke: 1px transparent;">
                        <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th colspan=2 style="line-height: 2.5;height: 30px; border: 1px;border-color: #d6d6d6; border-style: solid; text-align: center;">Datos de Facturaci&oacute;n </th>
                        </tr>
                        <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">N&deg; Orden </th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{order_id}</td>
                        </tr>
                        <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Nombre </th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{name}</td>
                        </tr>
                        <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Direcci&oacute;n</th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{address} - {town} - {city} - {country}</td>
                        </tr>
                        <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Teléfono</th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{telephone}</td>
                        </tr>
                        <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Correo</th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{email}</td>
                        </tr>
                    </table>
                    """.format( order_id=order.id,
                                name=facturacion["name"].encode("utf-8"),
                                address=facturacion["address"],
                                town=facturacion["town"],
                                city=facturacion["city"],
                                country="",
                                telephone=facturacion["telephone"],
                                email=facturacion["email"])

                    datos_despacho = """\
                    <table cellspacing="0" style="width:80%; margin:0 auto; padding:5px 5px;color:#999999;-webkit-text-stroke: 1px transparent;">
                        <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th colspan=2 style="line-height: 2.5;height: 30px; border: 1px;border-color: #d6d6d6; border-style: solid; text-align: center;">Datos de Despacho</th>
                        </tr>
                        <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">N&deg; Orden </th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{order_id}</td>
                        </tr>
                        <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Nombre </th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{name}</td>
                        </tr>
                        <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Direcci&oacute;n</th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{address} - {town} - {city} - {country}</td>
                        </tr>
                        <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Teléfono</th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{telephone}</td>
                        </tr>
                        <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Correo</th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{email}</td>
                        </tr>
                    </table>
                    """.format( order_id=order.id,
                                name=despacho["name"].encode("utf-8"),
                                address=despacho["address"],
                                town=despacho["town"],
                                city=despacho["city"],
                                country="",
                                telephone=despacho["telephone"],
                                email=despacho["email"])

                    html = """\
                    <!DOCTYPE html>
                    <html>
                    <head>
                        <title></title>
                    </head>
                    <body style="text-align:center; font-family:Arial; width:100%; margin: 0px;">
                        <div style="">
                            <div style="background-color:rgb(239, 239, 239); height:100px;padding-top:10px;">
                                <img style="display:block;margin:0 auto;max-height:90px;" src="{url_local}/static/img/giani-logo-2-gris-260x119.png" />
                            </div>
                                <p style="margin:0px;font-family: Arial;color:#999;font-size:16px;text-align: left;padding: 24px 13px 0 27px;">
                                    Hola {name}
                                </p>

                            <p style="margin:0 0 20px 0; font-family:Arial; color:#999;font-size:12px;text-align: left;padding: 5px 13px 0 27px">"Gracias por comprar en Giani da Firenze"</p>


                            {datos_facturacion}
                            {datos_despacho}

                            <table cellspacing=0 style="width:80%; margin:10px auto; background:#efefef;color:#999999;-webkit-text-stroke: 1px transparent;font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">

                                <tr>
                                    <th colspan=2 style="line-height: 2.5;height: 30px; border: 1px;border-color: #d6d6d6; border-style: solid; text-align: center;">Datos compra</th>
                                </tr>
                            </table>
                            <table cellspacing=0 style="width:80%; margin:10px auto; background:#efefef;color:#999999;-webkit-text-stroke: 1px transparent;font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                                <tr>
                                    <th style="border: 1px solid #d6d6d6;line-height: 2.5;">Cantidad</th>
                                    <th style="border-top: 1px solid #d6d6d6;line-height: 2.5;border-right: 1px solid #d6d6d6;border-bottom: 1px solid #d6d6d6; ">Nombre producto</th>
                                    <th style="border-top: 1px solid #d6d6d6;line-height: 2.5;border-right: 1px solid #d6d6d6;border-bottom: 1px solid #d6d6d6; ">Color</th>
                                    <th style="border-top: 1px solid #d6d6d6;line-height: 2.5;border-right: 1px solid #d6d6d6;border-bottom: 1px solid #d6d6d6; ">Talla</th>
                                    <th style="border-top: 1px solid #d6d6d6;line-height: 2.5;border-right: 1px solid #d6d6d6;border-bottom: 1px solid #d6d6d6; ">Precio</th>
                                    <th style="border-top: 1px solid #d6d6d6;line-height: 2.5;border-right: 1px solid #d6d6d6;border-bottom: 1px solid #d6d6d6; ">Subtotal</th>
                                </tr>
                                {detalle_orden}

                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Subtotal</th>
                                    <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {order_subtotal}</td>
                                </tr>
                                {valor_iva}
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Costo de env&iacute;o</th>
                                    <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{order_shipping}</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Total</th>
                                    <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {order_total}</td>
                                </tr>
                            </table>

                            <table style="width:100%; height: 40px; background-color: rgb(255, 224, 218);">
                                <tr>
                                    <td colspan=2   style="padding: 24px;background-color:rgb(255, 224, 218);width:100%"><img style="display:block;margin:0 auto 0 auto;" src="" /></td>
                                </tr>
                            </table>
                        </div>
                    </body>
                    </html> 
                    """.format( name=self.current_user["name"],
                                order_id=order.id,
                                datos_facturacion=datos_facturacion,
                                datos_despacho=datos_despacho,
                                detalle_orden=detalle_orden,
                                order_total=self.money_format(order.total),
                                order_subtotal=self.money_format(order.subtotal),
                                order_shipping=order_shipping,
                                url_local=url_local,
                                valor_iva=valor_iva)

                    # email_confirmacion = "yichun212@gmail.com"

                    sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
                    message = sendgrid.Mail()
                    message.set_from("{nombre} <{mail}>".format(nombre="Giani Da Firenze",mail=email_giani))
                    message.add_to(self.current_user["email"])
                    message.set_subject("Giani Da Firenze - Compra Nº {}".format(order.id))
                    message.set_html(html)
                    status, msg = sg.send(message)

                    html = """\
                    <!DOCTYPE html>
                    <html>
                    <head>
                        <title></title>
                    </head>
                    <body style="text-align:center; font-family:Arial; width:100%; margin: 0px;">
                        <div style="">
                            <div style="background-color:rgb(239, 239, 239); height:100px;padding-top:10px;">
                                <img style="display:block;margin:0 auto;max-height:90px;" src="{url_local}/static/img/giani-logo-2-gris-260x119.png" />
                            </div>
                                <p style="margin:0px;font-family: Arial;color:#999;font-size:16px;text-align: left;padding: 24px 13px 0 27px;">
                                    Ha llegado un pedido de {name}
                                </p>

                            <p style="margin:0 0 20px 0; font-family:Arial; color:#999;font-size:12px;text-align: left;padding: 5px 13px 0 27px"></p>


                            {datos_facturacion}
                            {datos_despacho}

                            <table cellspacing=0 style="width:80%; margin:10px auto; background:#efefef;color:#999999;-webkit-text-stroke: 1px transparent;font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">

                                <tr>
                                    <th colspan=2 style="line-height: 2.5;height: 30px; border: 1px;border-color: #d6d6d6; border-style: solid; text-align: center;">Datos compra</th>
                                </tr>
                            </table>
                            <table cellspacing=0 style="width:80%; margin:10px auto; background:#efefef;color:#999999;-webkit-text-stroke: 1px transparent;font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                                <tr>
                                    <th style="border: 1px solid #d6d6d6;line-height: 2.5;">Cantidad</th>
                                    <th style="border-top: 1px solid #d6d6d6;line-height: 2.5;border-right: 1px solid #d6d6d6;border-bottom: 1px solid #d6d6d6; ">Nombre producto</th>
                                    <th style="border-top: 1px solid #d6d6d6;line-height: 2.5;border-right: 1px solid #d6d6d6;border-bottom: 1px solid #d6d6d6; ">Color</th>
                                    <th style="border-top: 1px solid #d6d6d6;line-height: 2.5;border-right: 1px solid #d6d6d6;border-bottom: 1px solid #d6d6d6; ">Talla</th>
                                    <th style="border-top: 1px solid #d6d6d6;line-height: 2.5;border-right: 1px solid #d6d6d6;border-bottom: 1px solid #d6d6d6; ">Precio</th>
                                    <th style="border-top: 1px solid #d6d6d6;line-height: 2.5;border-right: 1px solid #d6d6d6;border-bottom: 1px solid #d6d6d6; ">Subtotal</th>
                                </tr>
                                {detalle_orden}

                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Subtotal</th>
                                    <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {order_subtotal}</td>
                                </tr>
                                {valor_iva}
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Costo de env&iacute;o</th>
                                    <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{order_shipping}</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Total</th>
                                    <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {order_total}</td>
                                </tr>
                            </table>

                            <table style="width:100%; height: 40px; background-color: rgb(255, 224, 218);">
                                <tr>
                                    <td colspan=2   style="padding: 24px;background-color:rgb(255, 224, 218);width:100%"><img style="display:block;margin:0 auto 0 auto;" src="" /></td>
                                </tr>
                            </table>
                        </div>
                    </body>
                    </html> 
                    """.format( name=self.current_user["name"],
                                order_id=order.id,
                                datos_facturacion=datos_facturacion,
                                datos_despacho=datos_despacho,
                                detalle_orden=detalle_orden,
                                order_total=self.money_format(order.total),
                                order_subtotal=self.money_format(order.subtotal),
                                order_shipping=order_shipping,
                                url_local=url_local,
                                valor_iva=valor_iva)

                    sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
                    message = sendgrid.Mail()
                    message.set_from("{nombre} <{mail}>".format(nombre="Giani Da Firenze",mail=self.current_user["email"]))
                    message.add_to(to_giani)

                    if self.current_user['type_id'] == 4:
                        message.set_subject("Nueva Compra Mayorista - Compra Nº {}".format(order.id))
                    else:
                        message.set_subject("Giani Da Firenze - Compra Nº {}".format(order.id))

                    message.set_html(html)
                    estado, mensaje = sg.send(message)

                    cart = Cart()
                    cart.user_id = self.current_user["id"]

                    carro = cart.GetCartByUserId()

                    for l in lista:

                        if len(carro) > 0:

                            cart.id = l["id"]
                            cart.Remove()

                            kardex = Kardex()

                            producto = Product()
                            response = producto.InitById(l["product_id"])

                            if "success" in response:

                                kardex.product_sku = producto.sku
                                kardex.cellar_identifier = id_bodega
                                kardex.operation_type = Kardex.OPERATION_MOV_OUT
                                kardex.sell_price = l['price']

                                _s = Size()
                                _s.name = l["size"]
                                res_name = _s.initByName()

                                if "success" in res_name:
                                    kardex.size_id = _s.id
                                elif debugMode:
                                    print res_name["error"]


                                kardex.date = str(datetime.now(pytz.timezone('Chile/Continental')).isoformat()) 
                                kardex.user = "Sistema - Reservar Producto"
                                kardex.units = l["quantity"]
                                kardex.price = producto.price

                                kardex.Insert()

                                c = Cellar()
                                res_reservation = c.GetReservationCellar()

                                reservation_cellar = shipping_cellar

                                if "success" in res_reservation:
                                    reservation_cellar = res_reservation["success"]
                                elif debugMode:
                                    print res_reservation["error"]

                                kardex.cellar_identifier = reservation_cellar
                                kardex.operation_type = Kardex.OPERATION_MOV_IN

                                res_kardex = kardex.Insert()

                                if debugMode and "error" in res_kardex:
                                    print res_kardex["error"]

                            elif debugMode:
                                print response["error"]

                    if status == 200:
                        self.render( "store/success.html",webpay="no", detalle=lista, order=order)
                    else:
                        self.render("beauty_error.html",message="Error al enviar correo de confirmación, {}".format(msg))

                else:
                    self.render("beauty_error.html",message="{}".format(response_obj["error"]))

            else:

                self.render("beauty_error.html",message="Carro se encuentra vacío")

        else:

                self.render("beauty_error.html",message="Carro se encuentra vacío")
        # pass


class GetAddressByIdHandler(BaseHandler):

    def get(self):

        contact_id = self.get_argument("id","")

        if contact_id != "":
            contact = Contact()
            json_str_contactos = contact.InitById(contact_id)
            self.write(json_util.dumps(json_str_contactos))


class CheckStockHandler(BaseHandler):
    """ verifica que todos los productos del carro tengan stock
        @author : Yi Chun Lin

    """

    def get(self):

        if self.current_user:

            cart = Cart()
            cart.user_id = self.current_user["id"]

            lista = cart.GetCartByUserId()

            cellar = Cellar()
            res_web_cellar = cellar.GetWebCellar()

            if "success" in res_web_cellar:
                web_cellar_id = res_web_cellar["success"]

                k = Kardex()
                res_checkstock = k.checkStock(lista, web_cellar_id)

                self.write(json_util.dumps(res_checkstock))

            else:

                self.write(json_util.dumps(res_web_cellar))

        else:

            user_id = self.get_argument("user_id", 0)

            cart = Cart()
            cart.user_id = user_id

            lista = cart.GetCartByUserId()

            cellar = Cellar()
            res_web_cellar = cellar.GetWebCellar()

            if "success" in res_web_cellar:
                web_cellar_id = res_web_cellar["success"]

                k = Kardex()
                res_checkstock = k.checkStock(lista, web_cellar_id)

                self.write(json_util.dumps(res_checkstock))

            else:

                self.write(json_util.dumps(res_web_cellar))

            # if "error" in res_checkstock:
            #     self.render("beauty_error.html",message="Falta stock, {}".format(res_checkstock["error"]))
