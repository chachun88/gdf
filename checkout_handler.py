#!/usr/bin/python
# -*- coding: UTF-8 -*-

import tornado.auth
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
from basehandler import BaseHandler

import uuid

from model.cart import Cart
from model.user import User
from model.contact import Contact
# from model.customer import Customer
from model.order import Order
from model.order_detail import OrderDetail
from model.kardex import Kardex
from model.cellar import Cellar
from model.product import Product

from datetime import datetime
from bson import json_util
import sendgrid
from globals import url_local, email_giani


class CheckoutAddressHandler(BaseHandler):

    @tornado.web.authenticated
    def get(self):

        if self.current_user:

            user_id = self.current_user["id"]
            
            contact = Contact()
            response_obj = contact.ListByUserId(user_id)

            contactos = []

            if "success" in response_obj:
                contactos = json_util.loads(response_obj["success"])
            # else:
            #     self.render("beauty_error.html",message="Error al obtener la lista de contactos:{}".format(response_obj["error"]))
            #     return

            cart = Cart()
            cart.user_id = user_id

            lista = cart.GetCartByUserId()
            suma = 0
            for l in lista:
                suma += l["subtotal"]

            self.render("store/checkout-1.html",contactos=contactos,data=lista,suma=suma)

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
            ciudad = self.get_argument("city","")
            codigo_postal = self.get_argument("zip_code","")
            informacion_adicional = self.get_argument("additional_info","")
            telefono = self.get_argument("telephone","")
            id_contacto = self.get_argument("contact_id","")


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

                cart = Cart()
                cart.user_id = user_id

                lista = cart.GetCartByUserId()

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

                contactos = []

                response_obj = contact.ListByUserId(user_id)

                if "success" in response_obj:
                    contactos = json_util.loads(response_obj["success"])

                self.render("store/checkout-2.html",contactos=contactos,data=lista,suma=suma,selected_address=direccion)
        else:

            self.redirect("/auth/login")

    @tornado.web.authenticated
    def post(self):
        self.get()

class CheckoutShippingHandler(BaseHandler):

    @tornado.web.authenticated
    def get(self):

        if self.current_user:

            user_id = self.current_user["id"]
            nombre = self.get_argument("name", self.current_user["name"])
            apellido = self.get_argument("lastname", self.current_user["lastname"])
            email = self.get_argument("email", self.current_user["email"])
            direccion = self.get_argument("address","")
            ciudad = self.get_argument("city","")
            codigo_postal = self.get_argument("zip_code","")
            informacion_adicional = self.get_argument("additional_info","")
            telefono = self.get_argument("telephone","")
            id_contacto = self.get_argument("contact_id","")
            misma_direccion = self.get_argument("same_address","")

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

                    cart = Cart()
                    cart.user_id = user_id

                    lista = cart.GetCartByUserId()

                    suma = 0

                    for l in lista:
                        c = Cart()
                        c.InitById(l["id"])
                        c.billing_id = contact.id
                        c.Edit()
                        suma += l["subtotal"]

                    # self.render("store/checkout-2.html",contactos=contactos,data=lista,suma=suma,selected_address=direccion)
                    self.render("store/checkout-3.html",suma=suma)
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

                # self.render("store/checkout-2.html",contactos=contactos,data=lista,suma=suma,selected_address=direccion)
                self.render("store/checkout-3.html",suma=suma)

        else:

            self.redirect("/auth/login")

    @tornado.web.authenticated
    def post(self):
        self.get()

        

class CheckoutPaymentHandler(BaseHandler):

    @tornado.web.authenticated
    def get(self):

        if self.current_user:

            shipping_type = self.get_argument("shipping_type",1)

            user_id = self.current_user["id"]

            cart = Cart()
            cart.user_id = user_id

            lista = cart.GetCartByUserId()

            suma = 0

            for l in lista:
                c = Cart()
                c.InitById(l["id"])
                c.shipping_type = shipping_type
                c.Edit()
                suma += l["subtotal"]

            self.render("store/checkout-4.html",suma=suma)
        else:
            self.redirect("/auth/login")

class CheckoutOrderHandler(BaseHandler):

    @tornado.web.authenticated
    def get(self):

        if self.current_user:

            user_id = self.current_user["id"]

            cart = Cart()
            cart.user_id = user_id

            lista = cart.GetCartByUserId()

            suma = 0

            for l in lista:
                suma += l["subtotal"]

            self.render("store/checkout-5.html",data=lista,suma=suma)
        else:
            self.redirect("/auth/login")

        # cart = Cart()
        # user = User()
        # cart.user_id = user.GetUserId(self.current_user)
        # data = cart.GetCartByUserId()
        # self.render("store/checkout-5.html",data=data)

class CheckoutSendHandler(BaseHandler):
    
    @tornado.web.authenticated
    def get(self):

        final_name = ""

        if "image" in self.request.files:

            imagedata = self.request.files['image'][0]

            final_name = "{filename}.{extension}".format(filename=uuid.uuid4(),extension="png")
            
            # final_name = "{}_{}.png".format( image_number, sku )

            try:
                fn = imagedata["filename"]
                file_path = 'uploads/images/' + final_name

                open(file_path, 'wb').write(imagedata["body"])
            except Exception, e:
                print str(e)
                pass
        
        payment_type = self.get_argument("payment_type",1)

        if self.current_user:
            user_id = self.current_user["id"]

        order = Order()
        
        cart = Cart()
        cart.user_id = user_id

        lista = cart.GetCartByUserId()

        if len(lista) > 0:

            for l in lista:
                c = Cart()
                c.InitById(l["id"])
                c.payment_type = payment_type
                c.Edit()

            lista = cart.GetCartByUserId()

            if len(lista) > 0:

                subtotal = 0
                descuento = 0
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


                order.date = datetime.now()
                order.type = 1
                order.subtotal = subtotal
                order.discount = descuento
                order.tax = iva
                order.total = total
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
                        res_obj = detail.Save()

                        kardex = Kardex()
                        cellar = Cellar()

                        response = cellar.InitByName("Bodega Central")

                        producto = Product()
                        response = producto.InitById(detail.product_id)

                        if "success" in response:

                            kardex.product_sku = producto.sku
                            kardex.cellar_identifier = cellar.id
                            kardex.operation_type = Kardex.OPERATION_SELL
                            kardex.sell_price = producto.sell_price
                            kardex.size = detail.size
                            kardex.date = str(datetime.now().isoformat()) 
                            kardex.user = self.current_user["email"]
                            kardex.units = detail.quantity

                            kardex.Insert()

                        # if "error" in res_obj:
                        #     print "{}".format(res_obj["error"])

                        cart.id = l["id"]
                        cart.Remove()

                        detalle_orden += """\
                            <tr>
                                <td style="line-height: 2.5;border-left: 1px solid #d6d6d6; margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{quantity}</td>
                                <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{name}</td>
                                <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{color}</td>
                                <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{size}</td>
                                <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{price}</td>
                                <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{subtotal}</td>
                            </tr>
                        """.format(name=l["name"],size=l["size"],quantity=l["quantity"],color=l["color"],price=l["sell_price"],subtotal=l["subtotal"])

                    contact = Contact()
                    facturacion = json_util.loads(contact.InitById(order.billing_id))
                    despacho = json_util.loads(contact.InitById(order.shipping_id))

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
                    """.format(order_id=order.id,name=facturacion["name"],address=facturacion["address"],town="",city=facturacion["city"],country="",telephone=facturacion["telephone"],email=facturacion["email"])

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
                    """.format(order_id=order.id,name=despacho["name"],address=despacho["address"],town="",city=despacho["city"],country="",telephone=despacho["telephone"],email=despacho["email"])

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
                                    <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{order_subtotal}</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">IVA</th>
                                    <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{order_tax}</td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Total</th>
                                    <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{order_total}</td>
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
                    """.format(name=self.current_user["name"],order_id=order.id,datos_facturacion=datos_facturacion,datos_despacho=datos_despacho,detalle_orden=detalle_orden,order_total=order.total,order_subtotal=order.subtotal,order_tax=order.tax,url_local=url_local)

                    # email_confirmacion = "yichun212@gmail.com"

                    sg = sendgrid.SendGridClient('nailuj41', 'Equipo_1234')
                    message = sendgrid.Mail()
                    message.set_from("{nombre} <{mail}>".format(nombre="Giani Da Firenze",mail=email_giani))
                    message.add_to(self.current_user["email"])
                    message.set_subject("Giani Da Firenze - Compra Nº {}".format(order.id))
                    message.set_html(html)
                    status, msg = sg.send(message)

                    if status == 200:
                        self.redirect( "/checkout/success" )
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
            self.write(json_str_contactos)