#!/usr/bin/python
# -*- coding: utf-8 -*-

import tornado.auth
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
from basehandler import BaseHandler
import pytz
import os
import uuid
import os.path
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
from model.post_office import PostOffice
from tornado import template
from datetime import datetime
from bson import json_util
import sendgrid
import mandrill
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

            post_office_list = []

            po = PostOffice()
            res_po = po.ListOnlyWithShippingCost()

            if "success" in res_po:
                post_office_list = res_po["success"]

            if suma > 0:
                if "success" in res_city:
                    cities = res_city["success"]

                self.render("store/checkout-1.html",contactos=contactos,data=lista,suma=suma,cities=cities,post_office_list=post_office_list)
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
            shipping_type = self.get_argument("shipping_type", "")
            post_office_id = self.get_argument("post_office_id", "")

            shipping_type_id = 1

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
            if shipping_type == "chilexpress":
                po = PostOffice()
                po.InitById(post_office_id)
                post_office_name = po.name
                contact.address = "Oficina {}".format(post_office_name)
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
                        c.shipping_info = contact.additional_info
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
                    if shipping_type != "chilexpress":
                        cellar_city_id = c.city_id

                        shipping = Shipping()
                        shipping.from_city_id = int(cellar_city_id)
                        shipping.to_city_id = int(ciudad)
                        res = shipping.GetGianiPrice()
                        if "error" in res:
                            self.render("beauty_error.html",message="Error al calcular costo de despacho, {}".format(res["error"]))
                    else:
                        shipping_type_id = 2
                        shipping = Shipping()
                        shipping.post_office_id = post_office_id
                        res = shipping.GetPriceByPostOfficeId()

                    if "error" in res:
                        self.render("beauty_error.html",message="Error al calcular costo de despacho de Chilexpress, {}".format(res["error"]))
                    else:
                        if shipping.charge_type == 1:
                            costo_despacho = shipping.price * items
                        else:
                            costo_despacho = shipping.price

                        self.render(
                            "store/checkout-2.html",
                            contactos=contactos,
                            data=lista,
                            suma=suma,
                            selected_address=direccion,
                            cities=cities,
                            costo_despacho=costo_despacho,
                            shipping_type=shipping_type_id,
                            post_office_id=post_office_id
                        )
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
            shipping_type = self.get_argument("shipping_type", 1)
            post_office_id = self.get_argument("post_office_id", "")

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
                        c.billing_info = contact.additional_info
                        c.Edit()
                        suma += l["subtotal"]

                    # self.render("store/checkout-2.html",contactos=contactos,data=lista,suma=suma,selected_address=direccion)
                    if self.current_user['type_id'] == User().getUserTypeID(UserType.EMPRESA):
                        self.render("wholesaler/checkout-4.html",data=lista,suma=suma,iva=iva)
                    else:
                        self.render(
                            "store/checkout-3.html",
                            data=lista,
                            suma=suma,
                            costo_despacho=costo_despacho,
                            shipping_type=shipping_type,
                            post_office_id=post_office_id
                        )
            else:

                contact = Contact()
                cart = Cart()
                cart.user_id = user_id

                lista = cart.GetCartByUserId()

                billing_info = ''
                suma = 0

                try:
                    billing_info = contact.getAdditionalInfo(c.shipping_id)['success']
                except:
                    pass

                for l in lista:
                    c = Cart()
                    c.InitById(l["id"])
                    c.billing_info = billing_info
                    c.billing_id = c.shipping_id
                    c.Edit()
                    suma += l["subtotal"]

                if self.current_user['type_id'] == User().getUserTypeID(UserType.EMPRESA):
                    self.render("wholesaler/checkout-4.html",data=lista,suma=suma,iva=iva)
                else:
                    self.render("store/checkout-3.html",data=lista,suma=suma,costo_despacho=costo_despacho,shipping_type=shipping_type,post_office_id=post_office_id)

        else:

            self.redirect("/auth/login")


class CheckoutPaymentHandler(BaseHandler):

    @tornado.web.authenticated
    def post(self):

        if self.current_user:

            shipping_type = self.get_argument("shipping_type",1)
            costo_despacho = int(self.get_argument("shipping_price",0))
            post_office_id = self.get_argument("post_office_id", "")

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
                            pytz=pytz,
                            post_office_id=post_office_id,
                            shipping_type=shipping_type)
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

        post_office_id = self.get_argument("post_office_id", "")
        shipping_type = self.get_argument("shipping_type", 1)

        if self.current_user:

            # print self.current_user

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

            self.render("store/checkout-5.html",data=lista,suma=suma,costo_despacho=costo_despacho,post_office_id=post_office_id,shipping_type=shipping_type)
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

    @staticmethod
    def generateMail(file_name, **kwargs):
        base_directory = os.path.join("templates", "mail")
        loader = template.Loader(base_directory)
        return loader.load(file_name).generate(**kwargs)

    @staticmethod
    def sendEmail(html, to, order):
        try:

            sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
            message = sendgrid.Mail()
            message.set_from("Giani Da Firenze <{mail}>".format(mail=email_giani))
            message.add_to(to)

            message.set_subject("Giani Da Firenze - Compra Nº {}"
                                .format(order))

            message.set_html(html)
            status, msg = sg.send(message)

            if status != 200:
                CheckoutSendHandler.sendError("{} -- {}".format(order, msg))

            return status
        except:
            return 400

    @staticmethod
    def sendError(msg):
        try:
            if enviroment != Enviroment.ONTEST:
                sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
                message = sendgrid.Mail()
                message.set_from(
                    "Sistema web giani <contacto@loadingplay.com>")
                message.add_to(["ricardo@loadingplay.com", "yi@loadingplay.com"])

                message.set_subject(
                    "Ocurrio un error al intentar enviar un email")

                message.set_html(msg)
                status, msg = sg.send(message)
            else:
                print msg
        except Exception, ex:
            print str(ex)
            pass

    @staticmethod
    def getDetalleOrden(lista):
        try:
            detalle_orden = ""

            for l in lista:

                # kardex = Kardex()

                # producto = Product()
                # response = producto.InitById(l["product_id"])

                # if "success" in response:
                #     producto.sell_price = l["price"]

                detalle_orden += CheckoutSendHandler.generateMail(
                    "detalle_orden.html",
                    name=l["name"],
                    size=l["size"].encode("utf-8"),
                    quantity=l["quantity"],
                    color=l["color"],
                    price=CheckoutSendHandler.money_format(l["price"]).encode("utf-8"),
                    subtotal=CheckoutSendHandler.money_format(l["subtotal"]).encode("utf-8"))

            return detalle_orden
        except Exception, ex:
            CheckoutSendHandler.sendError(str(ex))
            return ""

    @staticmethod
    def notifyEmails(lista, order, current_user):
        try:
            detalle_orden = CheckoutSendHandler.getDetalleOrden(lista)

            contact = Contact()
            facturacion_response = contact.InitById(order.billing_id)

            if "success" in facturacion_response:
                facturacion = facturacion_response["success"]
            else:
                CheckoutSendHandler.sendError("error al obtener facturacion")

            despacho_response = contact.InitById(order.shipping_id)

            if "success" in despacho_response:
                despacho = despacho_response["success"]
            else:
                CheckoutSendHandler.sendError("error al obtener despacho_response")
                # self.render("beauty_error.html", message="Error al obtener datos de despacho, {}".format(
                #     despacho_response["error"]))
                # return

            datos_facturacion = CheckoutSendHandler.generateMail(
                "datos_facturacion.html",
                order_id=order.id,
                name=facturacion["name"],
                address=facturacion["address"],
                town="",
                city=facturacion["city"],
                country="",
                telephone=facturacion["telephone"],
                email=facturacion["email"])

            datos_despacho = CheckoutSendHandler.generateMail(
                "datos_despacho.html",
                order_id=order.id,
                name=despacho["name"],
                address=despacho["address"],
                town="",
                city=despacho["city"],
                country="",
                telephone=despacho["telephone"],
                email=despacho["email"])

            html = CheckoutSendHandler.generateMail(
                "mail_confirmacion_cliente.html",
                name=current_user["name"].encode("utf-8"),
                order_id=order.id,
                datos_facturacion=datos_facturacion,
                datos_despacho=datos_despacho,
                detalle_orden=detalle_orden,
                order_total=CheckoutSendHandler.money_format(order.total),
                order_subtotal=CheckoutSendHandler.money_format(order.subtotal),
                order_tax=CheckoutSendHandler.money_format(order.tax),
                url_local=url_local,
                costo_despacho=CheckoutSendHandler.money_format(order.shipping))

            # email_confirmacion = "yichun212@gmail.com"

            client_status = CheckoutSendHandler.sendEmail(
                                html, 
                                current_user["email"], 
                                order.id)

            html = CheckoutSendHandler.generateMail(
                "mail_confirmacion_giani.html",
                name=current_user["name"].encode("utf-8"),
                order_id=order.id,
                datos_facturacion=datos_facturacion,
                datos_despacho=datos_despacho,
                detalle_orden=detalle_orden,
                order_total=CheckoutSendHandler.money_format(order.total),
                order_subtotal=CheckoutSendHandler.money_format(order.subtotal),
                order_tax=CheckoutSendHandler.money_format(order.tax),
                url_local=url_local,
                costo_despacho=CheckoutSendHandler.money_format(order.shipping))

            giani_status = CheckoutSendHandler.sendEmail(
                                html, 
                                to_giani, 
                                order.id)

            return client_status, giani_status, "ambos emails enviados"
        except Exception, ex:
            CheckoutSendHandler.sendError("error trying to send emails : {}".format(str(ex)))
            return 0, 0, "{}".format(ex)

    def saveVoucher(self):
        # guardar foto del comprobante
        final_name = ""

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

        return final_name

    def saveOrder(self, lista, order, final_name):

        shipping_price = int(self.get_argument("shipping_price",0))
        order_tax = int(float(self.get_argument("tax", 0)))
        payment_type = self.get_argument("payment_type",1)

        # hacer calculos del pedido
        subtotal = 0
        iva = 0
        cantidad_items = 0
        cantidad_productos = 0
        id_facturacion = 0
        id_despacho = 0
        tipo_pago = 0
        total = 0
        info_despacho = ''
        info_facturacion = ''

        for l in lista:
            subtotal += l["subtotal"]
            cantidad_items += l["quantity"]
            cantidad_productos += 1
            id_facturacion = l["billing_id"]
            id_despacho = l["shipping_id"]
            tipo_pago = l["payment_type"]
            total += l["subtotal"]
            info_despacho = l['shipping_info']
            info_facturacion = l['billing_info']

        # traspaso de los datos al pedido
        order.date = datetime.now(pytz.timezone('Chile/Continental')).isoformat()
        order.type = 1
        order.subtotal = subtotal
        order.shipping = shipping_price
        order.tax = order_tax
        order.total = total + shipping_price + order_tax
        order.items_quantity = cantidad_items
        order.products_quantity = cantidad_productos
        order.user_id = self.current_user["id"]
        order.billing_id = id_facturacion
        order.shipping_id = id_despacho
        order.payment_type = payment_type
        order.voucher = final_name
        order.billing_info = info_facturacion
        order.shipping_info = info_despacho

        # guardar pedido
        response_obj = order.Save()

        return response_obj

    def moveStock(self, lista, carro, id_bodega, order_id):

        for l in lista:

            if len(carro) > 0:
                cart = Cart()
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
                    kardex.order_id = order_id

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

    def saveOrderDetail(self, lista, order):

        # guardar el detalle
        for l in lista:

            detail = OrderDetail()
            detail.order_id = order.id
            detail.quantity = l["quantity"]
            detail.subtotal = l["subtotal"]
            detail.product_id = l["product_id"]
            detail.size = l["size"]
            detail.price = l['price']
            detail.Save()

            product = Product()
            product.InitById(l["product_id"])
            product.updateSold(product.sku)

    @tornado.web.authenticated
    def post(self):

        # obtener id de la bodega web
        id_bodega = cellar_id
        cellar = Cellar()
        res_cellar = cellar.GetWebCellar()
        if "success" in res_cellar:
            id_bodega = res_cellar["success"]

        # obtener carro del usuario logueado
        cart = Cart()
        cart.user_id = self.current_user["id"]

        lista = cart.GetCartByUserId()

        final_name = self.saveVoucher()

        order = Order()

        if len(lista) > 0:

            response_obj = self.saveOrder(lista, order, final_name)

            # si se guardo el pedido de forma exitosa
            if "success" in response_obj:

                self.saveOrderDetail(lista, order)
                self.notifyEmails(lista, order, self.current_user)

                cart = Cart()
                cart.user_id = self.current_user["id"]

                carro = cart.GetCartByUserId()
                self.moveStock(lista, carro, id_bodega, order.id)

                self.render( "store/success.html", webpay="no", detalle=lista, order=order)
            else:
                self.render("beauty_error.html", message="{}".format(response_obj["error"]))
        else:
            self.render("beauty_error.html", message="Carro se encuentra vacío")


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

            if self.current_user["type_id"] == User().getUserTypeID(UserType.EMPRESA):
                total_quantity = 0
                for item in lista:
                    total_quantity += item["quantity"]
                if total_quantity < 15:
                    self.write(json_util.dumps({"error": "La cantidad mínima es de 15 pares"}))
                    return

            if "success" in res_web_cellar:
                web_cellar_id = res_web_cellar["success"]

                k = Kardex()
                res_checkstock = k.checkStock(lista, web_cellar_id)

                if "error" in res_checkstock:
                    self.write(json_util.dumps(res_checkstock))
                else:
                    res_update_cart_price = cart.updatePrice(lista, self.current_user)
                    if res_update_cart_price["success"] > 0:
                        self.write(json_util.dumps({"alert":"Alerta! El precio de algunos productos han sido actualizados"}))
                    else:
                        self.write(json_util.dumps(res_update_cart_price))

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

                if "error" in res_checkstock:
                    self.write(json_util.dumps(res_checkstock))
                else:
                    res_update_cart_price = cart.updatePrice(lista, self.current_user)
                    if res_update_cart_price["success"] > 0:
                        self.write(json_util.dumps({"alert":"Alerta! El precio de algunos productos han sido actualizados"}))
                    else:
                        self.write(json_util.dumps(res_update_cart_price))

            else:

                self.write(json_util.dumps(res_web_cellar))

            # if "error" in res_checkstock:
            #     self.render("beauty_error.html",message="Falta stock, {}".format(res_checkstock["error"]))


class ListPostOfficeByCityIdHandler(BaseHandler):

    def get(self):

        post_office = PostOffice()
        post_office.city_id = self.get_argument("city_id", "")
        res = post_office.ListPostOfficeByCityId()

        self.write(json_util.dumps(res))


class GetAddressByPostOfficeIdHandler(BaseHandler):

    def get(self):

        post_office = PostOffice()
        post_office.id = self.get_argument("post_office_id", "")
        res = post_office.GetAddressByPostOfficeId()

        self.write(json_util.dumps(res))


class ManualPaymentHandler(BaseHandler):

    def post(self):

        contact = self.get_argument("contact","")
        order_id = self.get_argument("order_id", "")

        try:
            mandrill_client = mandrill.Mandrill(mailchimp_api_key)
            info = mandrill_client.templates.info(payment_template_id)

            message = {
                'to': [{'email': email_giani}],
                'merge_language': 'handlebars',
                'from_email': info["from_email"],
                'from_name': info["from_name"],
                'subject': info["subject"],
                'html': info["code"],
                'merge_vars':[{
                    'rcpt': email_giani,
                    'vars': [
                        {"name": "order_id", "content": order_id},
                        {"name": "contact", "content": contact}
                    ]
                }]
            }

            result = mandrill_client.messages.send(message=message)

            self.write(json_util.dumps(result))
        except Exception, e:
            self.sendError('enviando correo procesamiento, {}'.format(str(e)))


class ShippingCostHandler(BaseHandler):

    def post(self):

        post_office_id = self.get_argument("post_office_id", "")
        shipping_type = self.get_argument("shipping_type", 1)
        cart_id = self.get_argument("cart_id", "")
        ciudad = None

        items = 0

        c = Cart()
        c.user_id = self.current_user["id"]
        detail = c.GetCartByUserId()

        for d in detail:
            items += int(d["quantity"])

        if cart_id != "":
            cart = Cart()
            res = cart.InitById(cart_id)

            if "success" in res:
                contact = Contact()
                res_contact = contact.InitById(cart.shipping_id)
                if "success" in res_contact:
                    ciudad = res_contact["success"]["city_id"]

        c = Cellar()
        res_cellar_id = c.GetWebCellar()

        web_cellar_id = cellar_id

        if "success" in res_cellar_id:
            web_cellar_id = res_cellar_id["success"]

        res_web_cellar = c.InitById(web_cellar_id)

        if "success" in res_web_cellar:
            if int(shipping_type) == 1:
                cellar_city_id = c.city_id
                shipping = Shipping()
                shipping.from_city_id = int(cellar_city_id)
                shipping.to_city_id = int(ciudad)
                res = shipping.GetGianiPrice()
            else:
                shipping = Shipping()
                shipping.post_office_id = post_office_id
                res = shipping.GetPriceByPostOfficeId()

            if "error" in res:
                self.write(json_util.dumps({"state": "error", "message": res["error"]}))
            else:
                if shipping.charge_type == 1:
                    costo_despacho = shipping.price * items
                else:
                    costo_despacho = shipping.price

                self.write(json_util.dumps({"state": "ok", "shipping_cost": costo_despacho}))
        else:
            self.write(json_util.dumps({"state": "error", "message": res_web_cellar["error"]}))
