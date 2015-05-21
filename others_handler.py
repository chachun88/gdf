#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os.path
import os
import tornado.web
from basehandler import BaseHandler

from model.kardex import Kardex
from datetime import datetime
import urlparse

from lp.globals import enviroment, Enviroment
from tornado import template


from globals import email_giani, \
    to_giani, \
    cellar_id, \
    url_local, \
    shipping_cellar, \
    project_path, \
    cgi_path, \
    debugMode, \
    sendgrid_pass, \
    sendgrid_user

import sendgrid

from model.cart import Cart
from model.order import Order
from model.order_detail import OrderDetail
from model.product import Product
from model.contact import Contact
from model.webpay import Webpay
from model.cellar import Cellar
from model.size import Size


class ContactHandler(BaseHandler):

    def get(self):
        self.render("auth/contacto.html")

    def post(self):
        name = self.get_argument("name", "").encode("utf-8")
        email = self.get_argument("email", "").encode("utf-8")
        subject = self.get_argument("subject", "").encode("utf-8")
        message = self.get_argument("message", "").encode("utf-8")

        if name == "" or email == "" or subject == "" or message == "":

            self.write("Debe ingresar los campos requeridos")

        else:

            sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
            mensaje = sendgrid.Mail()
            mensaje.set_from(
                "{nombre} <{mail}>".format(nombre=name, mail=email))
            mensaje.add_to(to_giani)
            mensaje.set_subject("Contact GDF - {}".format(subject))
            mensaje.set_html(message)
            status, msg = sg.send(mensaje)

            if status == 200:
                self.render(
                    "message.html",
                    message="Gracias por contactarte con nosotros, su mensaje \
                            ha sido enviado exitosamente")
            else:
                self.render(
                    "beauty_error.html",
                    message="Ha ocurrido un error al enviar su mensaje, {}"
                    .format(msg))


class KardexTestHandler(BaseHandler):

    def get(self):

        kardex = Kardex()
        kardex.product_sku = "GDF-OI14-7841-18-C1"
        kardex.cellar_identifier = 5
        kardex.operation_type = Kardex.OPERATION_SELL
        kardex.sell_price = 26900
        kardex.size = '35.0'
        kardex.date = str(datetime.now().isoformat())
        kardex.user = self.current_user["email"]
        kardex.units = 1

        kardex.Insert()


class TosHandler(BaseHandler):

    def get(self):
        self.render("tos.html")


class PagoHandler(BaseHandler):

    def get(self):

        self.render("pago.html")

    def post(self):

        TBK_TIPO_TRANSACCION = self.get_argument("TBK_TIPO_TRANSACCION", "")
        TBK_MONTO = self.get_argument("TBK_MONTO", "")
        TBK_ID_SESION = self.get_argument("TBK_ID_SESION", "")
        TBK_URL_EXITO = self.get_argument("TBK_URL_EXITO", "")
        TBK_URL_FRACASO = self.get_argument("TBK_URL_FRACASO", "")

        payment_type = self.get_argument("payment_type", 2)
        costo_despacho = int(self.get_argument("shipping_price", 0))

        user_id = self.current_user["id"]

        order = Order()

        cart = Cart()
        cart.user_id = user_id

        lista = cart.GetCartByUserId()

        if len(lista) > 0:

            subtotal = 0
            iva = 0
            cantidad_items = 0
            cantidad_productos = 0
            id_facturacion = 0
            id_despacho = 0
            total = 0

            for l in lista:
                c = Cart()
                c.InitById(l["id"])
                c.payment_type = payment_type
                c.Edit()
                subtotal += l["subtotal"]
                cantidad_items += l["quantity"]
                cantidad_productos += 1
                id_facturacion = l["billing_id"]
                id_despacho = l["shipping_id"]
                total += l["subtotal"]

            order.date = datetime.now()
            order.type = Order.TIPO_WEB
            order.subtotal = subtotal
            order.shipping = costo_despacho
            order.tax = iva
            order.total = total + costo_despacho
            order.items_quantity = cantidad_items
            order.products_quantity = cantidad_productos
            order.user_id = user_id
            order.billing_id = id_facturacion
            order.shipping_id = id_despacho
            order.payment_type = payment_type
            order.voucher = ""
            order.state = Order.ESTADO_PENDIENTE

            response_obj = order.Save()

            if "success" in response_obj:

                for l in lista:

                    detail = OrderDetail()
                    detail.order_id = order.id
                    detail.quantity = l["quantity"]
                    detail.subtotal = l["subtotal"]
                    detail.product_id = l["product_id"]
                    detail.size = l["size"]
                    detail.price = l["price"]
                    detail.Save()

                    # res_obj = detail.Save()
                    # if "error" in res_obj:
                    #     print "{}".format(res_obj["error"])

            # else:

            #     self.write(response_obj["error"])
            #     return

        if os.name != "nt":
            myPath = "{}webpay/dato{}.log" \
                .format(project_path, TBK_ID_SESION)
        else:
            myPath = "C:\Users\YiChun\Documents\giani\webpay\dato{}.log" \
                .format(TBK_ID_SESION)

        f = open(myPath, "w+")
        linea = "{};{}".format(TBK_MONTO, order.id)
        f.write(linea)
        f.close()

        data = {
            "TBK_TIPO_TRANSACCION": TBK_TIPO_TRANSACCION,
            "TBK_MONTO": TBK_MONTO,
            "TBK_ORDEN_COMPRA": order.id,
            "TBK_ID_SESION": TBK_ID_SESION,
            "TBK_URL_EXITO": TBK_URL_EXITO,
            "TBK_URL_FRACASO": TBK_URL_FRACASO
        }

        # self.write(json_util.dumps(data))
        self.render("transbank.html", data=data)


class XtCompraHandler(BaseHandler):

    def get(self):
        self.write("RECHAZADO")

    def post(self):
        TBK_RESPUESTA = self.get_argument("TBK_RESPUESTA")
        TBK_ORDEN_COMPRA = self.get_argument("TBK_ORDEN_COMPRA")
        TBK_MONTO = self.get_argument("TBK_MONTO")
        TBK_ID_SESION = self.get_argument("TBK_ID_SESION")

        myPath = "{}webpay/dato{}.log".format(project_path, TBK_ID_SESION)

        filename_txt = "{}webpay/MAC01Normal{}.txt".format(
            project_path,
            TBK_ID_SESION)

        cmdline = "{}cgi-bin/tbk_check_mac.cgi {}".format(
            cgi_path, filename_txt)

        acepta = False

        if TBK_RESPUESTA == "0":
            acepta = True

        try:
            f = open(myPath, "r")

            linea = ""

            for l in f:
                if l.strip() != "":
                    linea = l

            f.close()

            detalle = linea.split(";")

            # print "linea:{}".format(linea)

            if len(detalle) > 0:
                monto = detalle[0]
                ordenCompra = detalle[1]

            f = open(filename_txt, "wt")

            f.write(
                "{}={}&".format("TBK_ORDEN_COMPRA", self.get_argument("TBK_ORDEN_COMPRA")))
            f.write("{}={}&".format(
                "TBK_TIPO_TRANSACCION", self.get_argument("TBK_TIPO_TRANSACCION")))
            f.write(
                "{}={}&".format("TBK_RESPUESTA", self.get_argument("TBK_RESPUESTA")))
            f.write(
                "{}={}&".format("TBK_MONTO", self.get_argument("TBK_MONTO")))
            f.write("{}={}&".format(
                "TBK_CODIGO_AUTORIZACION", self.get_argument("TBK_CODIGO_AUTORIZACION")))
            f.write("{}={}&".format(
                "TBK_FINAL_NUMERO_TARJETA", self.get_argument("TBK_FINAL_NUMERO_TARJETA")))
            f.write(
                "{}={}&".format("TBK_FECHA_CONTABLE", self.get_argument("TBK_FECHA_CONTABLE")))
            f.write("{}={}&".format(
                "TBK_FECHA_TRANSACCION", self.get_argument("TBK_FECHA_TRANSACCION")))
            f.write("{}={}&".format(
                "TBK_HORA_TRANSACCION", self.get_argument("TBK_HORA_TRANSACCION")))
            f.write(
                "{}={}&".format("TBK_ID_SESION", self.get_argument("TBK_ID_SESION")))
            f.write(
                "{}={}&".format("TBK_ID_TRANSACCION", self.get_argument("TBK_ID_TRANSACCION")))
            f.write(
                "{}={}&".format("TBK_TIPO_PAGO", self.get_argument("TBK_TIPO_PAGO")))
            f.write(
                "{}={}&".format("TBK_NUMERO_CUOTAS", self.get_argument("TBK_NUMERO_CUOTAS")))
            f.write("{}={}&".format("TBK_VCI", self.get_argument("TBK_VCI")))
            f.write("{}={}&".format("TBK_MAC", self.get_argument("TBK_MAC")))

            f.close()

            if (TBK_MONTO == monto and
                    TBK_ORDEN_COMPRA == ordenCompra and
                    acepta):
                acepta = True
            else:
                acepta = False

        except:
            self.write("RECHAZADO")
            return

        if acepta:

            resultado = os.popen(cmdline).read()

            # print "RESULTADO:-----{}----".format(resultado.strip())
            if resultado.strip() == "CORRECTO":
                acepta = True
            else:
                acepta = False

        if acepta:

            order = Order()
            init_by_id = order.InitById(TBK_ORDEN_COMPRA)

            if "success" in init_by_id:
                # rechaza si orden no esta pendiente
                if order.state != Order.ESTADO_PENDIENTE:
                    acepta = False
                # si esta pendiente actualizar a pagado
                elif order.state == Order.ESTADO_PENDIENTE:
                    order.state = Order.ESTADO_CONFIRMADO
                    save_order = order.Edit()
                    # rechaza si no puede actualizar la orden
                    if "error" in save_order:
                        acepta = False

                    webpay = Webpay()
                    webpay.order_id = order.id
                    webpay.tbk_orden_compra = self.get_argument(
                        "TBK_ORDEN_COMPRA")
                    webpay.tbk_tipo_transaccion = self.get_argument(
                        "TBK_TIPO_TRANSACCION")
                    webpay.tbk_monto = self.get_argument("TBK_MONTO")
                    webpay.tbk_codigo_autorizacion = self.get_argument(
                        "TBK_CODIGO_AUTORIZACION")
                    webpay.tbk_final_numero_tarjeta = self.get_argument(
                        "TBK_FINAL_NUMERO_TARJETA")
                    webpay.tbk_fecha_contable = self.get_argument(
                        "TBK_FECHA_CONTABLE")
                    webpay.tbk_fecha_transaccion = self.get_argument(
                        "TBK_FECHA_TRANSACCION")
                    webpay.tbk_hora_transaccion = self.get_argument(
                        "TBK_HORA_TRANSACCION")
                    webpay.tbk_id_sesion = self.get_argument("TBK_ID_SESION")
                    webpay.tbk_id_transaccion = self.get_argument(
                        "TBK_ID_TRANSACCION")
                    webpay.tbk_tipo_pago = self.get_argument("TBK_TIPO_PAGO")
                    webpay.tbk_numero_cuotas = self.get_argument(
                        "TBK_NUMERO_CUOTAS")
                    res = webpay.Save()

                    if "error" in res:
                        print res["error"]

        if acepta or TBK_RESPUESTA != "0":
            # print "si acepto"
            self.write("ACEPTADO")
        else:
            # print "no acepto"
            self.write("RECHAZADO")


class ExitoHandler(BaseHandler):

    @staticmethod
    def generateMail(file_name, **kwargs):
        base_directory = os.path.join("templates", "mail")
        loader = template.Loader(base_directory)
        return loader.load(file_name).generate(**kwargs)

    @staticmethod
    def sendError(msg):
        try:
            if enviroment != Enviroment.LOCAL and enviroment != Enviroment.ONTEST:
                sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
                message = sendgrid.Mail()
                message.set_from(
                    "Sistema web giani <contacto@loadingplay.com>")
                message.add_to("ricardo@loadingplay.com")

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
                ExitoHandler.sendError("{} -- {}".format(order, msg))

            return status
        except:
            return 400

    @staticmethod
    def verifyOrderState(order_id):

        order = Order()
        init_by_id = order.InitById(order_id)

        if "success" in init_by_id:
            if int(order.state) == Order.ESTADO_PENDIENTE:
                ExitoHandler.sendError("pedido {} esta pendiente de pago"
                                       .format(order_id))
                return None
            else:
                return order
        else:
            ExitoHandler.sendError("error al inicializar pedido {}, {}"
                                   .format(order_id, init_by_id["error"]))
            return None

    @staticmethod
    def readWebpayMAC(session_id, order):

        # if os.name != "nt":
        #     myPath = "{}webpay/MAC01Normal{}.txt".format(
        #         project_path,
        #         session_id)
        # else:
        #     myPath = "C:\Users\YiChun\Documents\giani\webpay\MAC01Normal{}.txt"\
        #         .format(session_id)

        # solucion multi sistema
        myPath = os.path.join(
                    os.path.dirname(__file__),
                    "webpay",
                    "MAC01Normal{}.txt".format(session_id))

        data = {}

        try:

            f = open(myPath, "r")
            linea = ""

            for l in f:
                if l.strip() != "":
                    linea = l

            f.close()

            try:
                dict_parametros = urlparse.parse_qs(linea)

                TBK_ORDEN_COMPRA = dict_parametros["TBK_ORDEN_COMPRA"][0]
                TBK_TIPO_TRANSACCION = dict_parametros[
                    "TBK_TIPO_TRANSACCION"][0]
                TBK_RESPUESTA = dict_parametros["TBK_RESPUESTA"][0]
                TBK_MONTO = dict_parametros["TBK_MONTO"][0]
                TBK_CODIGO_AUTORIZACION = dict_parametros[
                    "TBK_CODIGO_AUTORIZACION"][0]
                TBK_FINAL_NUMERO_TARJETA = dict_parametros[
                    "TBK_FINAL_NUMERO_TARJETA"][0]
                TBK_HORA_TRANSACCION = dict_parametros[
                    "TBK_HORA_TRANSACCION"][0]
                TBK_ID_TRANSACCION = dict_parametros["TBK_ID_TRANSACCION"][0]
                TBK_TIPO_PAGO = dict_parametros["TBK_TIPO_PAGO"][0]
                TBK_NUMERO_CUOTAS = dict_parametros["TBK_NUMERO_CUOTAS"][0]
                TBK_MAC = dict_parametros["TBK_MAC"][0]

                # ej: 1006
                TBK_FECHA_TRANSACCION = dict_parametros[
                    "TBK_FECHA_TRANSACCION"][0]

                # aqui se repite la misma operacion para obtener mes y dia

                mes_transaccion = TBK_FECHA_TRANSACCION[:2]
                dia_transaccion = TBK_FECHA_TRANSACCION[2:]

                TBK_FECHA_TRANSACCION = "{year}-{mes}-{dia}".format(
                    year=order.date.year,
                    mes=mes_transaccion,
                    dia=dia_transaccion)

                TBK_HORA_TRANSACCION = dict_parametros[
                    "TBK_HORA_TRANSACCION"][0]

                hora_transaccion = TBK_HORA_TRANSACCION[:2]
                minutos_transaccion = TBK_HORA_TRANSACCION[2:4]
                segundo_transaccion = TBK_HORA_TRANSACCION[4:]

                TBK_HORA_TRANSACCION = "{hora}:{minutos}:{segundos}".format(
                    hora=hora_transaccion,
                    minutos=minutos_transaccion,
                    segundos=segundo_transaccion)

                TBK_TIPO_CUOTA = TBK_TIPO_PAGO

                if TBK_TIPO_PAGO == "VD":
                    TBK_TIPO_PAGO = "Redcompra"
                else:
                    TBK_TIPO_PAGO = "Cr&eacute;dito"

                data = {
                    "TBK_ORDEN_COMPRA": TBK_ORDEN_COMPRA,
                    "TBK_TIPO_TRANSACCION": TBK_TIPO_TRANSACCION,
                    "TBK_RESPUESTA": TBK_RESPUESTA,
                    "TBK_MONTO": int(TBK_MONTO),
                    "TBK_CODIGO_AUTORIZACION": TBK_CODIGO_AUTORIZACION,
                    "TBK_FINAL_NUMERO_TARJETA": TBK_FINAL_NUMERO_TARJETA,
                    "TBK_HORA_TRANSACCION": TBK_HORA_TRANSACCION,
                    "TBK_ID_TRANSACCION": TBK_ID_TRANSACCION,
                    "TBK_TIPO_PAGO": TBK_TIPO_PAGO,
                    "TBK_NUMERO_CUOTAS": TBK_NUMERO_CUOTAS,
                    "TBK_MAC": TBK_MAC,
                    "TBK_FECHA_TRANSACCION": TBK_FECHA_TRANSACCION,
                    "TBK_HORA_TRANSACCION": TBK_HORA_TRANSACCION,
                    "TBK_TIPO_CUOTA": TBK_TIPO_CUOTA
                }

            except Exception, e:
                ExitoHandler.sendError(
                    "error al parsear archivo asociado al pedido {}, {}"
                    .format(order.id, str(e)))

        except Exception, e:
            ExitoHandler.sendError(
                "error al leer archivo asociado al pedido {}, {}"
                .format(order.id, str(e)))

        return data

    @staticmethod
    def moveStock(order_detail, user_id):
        try:
            id_bodega = cellar_id
            id_bodega_reserva = shipping_cellar

            cellar = Cellar()
            res_cellar = cellar.GetWebCellar()

            if "success" in res_cellar:
                id_bodega = res_cellar["success"]
            else:
                ExitoHandler.sendError("obtener id de bodega web {}"
                                       .format(res_cellar["error"]))

            res_reservation_cellar = cellar.GetReservationCellar()

            if "success" in res_reservation_cellar:
                id_bodega_reserva = res_reservation_cellar["success"]
            else:
                ExitoHandler.sendError("obtener id de bodega reserva {}"
                                       .format(res_reservation_cellar["error"]))

            cart = Cart()
            cart.user_id = user_id

            carro = cart.GetCartByUserId()

            if len(carro) > 0:

                res_remove_cart = cart.RemoveByUserId()

                if "error" in res_remove_cart:
                    ExitoHandler.sendError("vaciar carro {}"
                                           .format(res_remove_cart["error"]))

                for l in order_detail:

                    kardex = Kardex()

                    producto = Product()
                    response = producto.InitById(l["product_id"])

                    if "success" in response:

                        kardex.product_sku = producto.sku
                        kardex.cellar_identifier = id_bodega
                        kardex.operation_type = Kardex.OPERATION_MOV_OUT

                        _s = Size()
                        _s.name = l["size"]
                        res_name = _s.initByName()

                        if "success" in res_name:
                            kardex.size_id = _s.id
                        else:
                            ExitoHandler.sendError("obtener size_id para product_id {}, {}"
                                                   .format(l["product_id"],
                                                           res_name["error"]))

                        kardex.date = str(datetime.now().isoformat())
                        kardex.user = "Sistema - Reservar Producto"
                        kardex.units = l["quantity"]

                        res_kardex = kardex.Insert()

                        if "error" in res_kardex:
                            ExitoHandler.sendError("sacar de bodega web product_id {}, {}"
                                                   .format(l["product_id"],
                                                           res_kardex["error"]))

                        kardex.cellar_identifier = id_bodega_reserva
                        kardex.operation_type = Kardex.OPERATION_MOV_IN

                        res_kardex = kardex.Insert()

                        if "error" in res_kardex:
                            ExitoHandler.sendError("move a bodega reserva product_id {}, {}"
                                                   .format(l["product_id"],
                                                           res_kardex["error"]))

                    else:
                        ExitoHandler.sendError("initizalizar producto {}, {}"
                                               .format(l["product_id"],
                                                       res_remove_cart["error"]))
        except:
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

                detalle_orden += ExitoHandler.generateMail(
                    "detalle_orden.html",
                    name=l["name"].encode("utf-8"),
                    size=l["size"].encode("utf-8"),
                    quantity=l["quantity"],
                    color=l["color"],
                    price=ExitoHandler.money_format(l["price"]).encode("utf-8"),
                    subtotal=ExitoHandler.money_format(l["subtotal"]).encode("utf-8"))

            return detalle_orden
        except Exception, ex:
            ExitoHandler.sendError(str(ex))
            return ""

    @staticmethod
    def notifyEmails(lista, order, current_user):
        try:
            detalle_orden = ExitoHandler.getDetalleOrden(lista)

            contact = Contact()
            facturacion_response = contact.InitById(order.billing_id)

            if "success" in facturacion_response:
                facturacion = facturacion_response["success"]
            else:
                ExitoHandler.sendError("error al obtener facturacion")

            despacho_response = contact.InitById(order.shipping_id)

            if "success" in despacho_response:
                despacho = despacho_response["success"]
            else:
                ExitoHandler.sendError("error al obtener despacho_response")
                # self.render("beauty_error.html", message="Error al obtener datos de despacho, {}".format(
                #     despacho_response["error"]))
                # return

            datos_facturacion = ExitoHandler.generateMail(
                "datos_facturacion.html",
                order_id=order.id,
                name=facturacion["name"],
                address=facturacion["address"],
                town="",
                city=facturacion["city"],
                country="",
                telephone=facturacion["telephone"],
                email=facturacion["email"])

            datos_despacho = ExitoHandler.generateMail(
                "datos_despacho.html",
                order_id=order.id,
                name=despacho["name"],
                address=despacho["address"],
                town="",
                city=despacho["city"],
                country="",
                telephone=despacho["telephone"],
                email=despacho["email"])

            html = ExitoHandler.generateMail(
                "mail_confirmacion_cliente.html",
                name=current_user["name"].encode("utf-8"),
                order_id=order.id,
                datos_facturacion=datos_facturacion,
                datos_despacho=datos_despacho,
                detalle_orden=detalle_orden,
                order_total=ExitoHandler.money_format(order.total),
                order_subtotal=ExitoHandler.money_format(order.subtotal),
                order_tax=ExitoHandler.money_format(order.tax),
                url_local=url_local,
                costo_despacho=ExitoHandler.money_format(order.shipping))

            # email_confirmacion = "yichun212@gmail.com"

            client_status, client_message = ExitoHandler.sendEmail(
                                html, 
                                current_user["email"], 
                                order.id)

            html = ExitoHandler.generateMail(
                "mail_confirmacion_giani.html",
                name=current_user["name"].encode("utf-8"),
                order_id=order.id,
                datos_facturacion=datos_facturacion,
                datos_despacho=datos_despacho,
                detalle_orden=detalle_orden,
                order_total=ExitoHandler.money_format(order.total),
                order_subtotal=ExitoHandler.money_format(order.subtotal),
                order_tax=ExitoHandler.money_format(order.tax),
                url_local=url_local,
                costo_despacho=ExitoHandler.money_format(order.shipping))

            giani_status, giani_message = ExitoHandler.sendEmail(
                                html, 
                                to_giani, 
                                order.id)

            return client_status, giani_status, "{} -- {}".format(client_message, giani_message)
        except Exception, ex:
            ExitoHandler.sendError("error trying to send emails : {}".format(str(ex)))
            return 0, 0, "{}".format(ex)


    def get(self):
        self.render(
                "beauty_error.html",
                message="Acceso no permitido. Si tienes alguna duda, escríbenos a contacto@loadingplay.com")

    @tornado.web.authenticated
    def post(self):
        TBK_ID_SESION = self.get_argument("TBK_ID_SESION", "")
        TBK_ORDEN_COMPRA = self.get_argument("TBK_ORDEN_COMPRA", "")
        pathSubmit = url_local

        order = self.verifyOrderState(TBK_ORDEN_COMPRA)

        if order is None:
            self.render(
                "store/failure.html",
                TBK_ID_SESION=TBK_ID_SESION,
                TBK_ORDEN_COMPRA=TBK_ORDEN_COMPRA,
                PATHSUBMIT=pathSubmit)
            return

        data = self.readWebpayMAC(TBK_ID_SESION, order)

        detail = OrderDetail()
        lista = detail.ListByOrderId(TBK_ORDEN_COMPRA)

        self.moveStock(lista, self.current_user["id"])

        try:
            status_cliente, status_giani, message = ExitoHandler.notifyEmails(lista, order, self.current_user)


            if status_cliente != 200:
                ExitoHandler.sendError("el email de cliente no se ha enviado : {}".format(message))
            if status_giani != 200:
                ExitoHandler.sendError("el mail a giani no se ha enviado : {}".format(message))
        except Exception, ex:
            ExitoHandler.sendError(str(ex))

        self.render("store/success.html",
                        data=data,
                        pathSubmit=pathSubmit,
                        webpay="si",
                        detalle=lista,
                        order=order)


class FracasoHandler(BaseHandler):

    def post(self):

        PATHSUBMIT = url_local
        TBK_ID_SESION = self.get_argument("TBK_ID_SESION", "")
        TBK_ORDEN_COMPRA = self.get_argument("TBK_ORDEN_COMPRA", "")

        self.render(
            "store/failure.html",
            TBK_ID_SESION=TBK_ID_SESION,
            TBK_ORDEN_COMPRA=TBK_ORDEN_COMPRA,
            PATHSUBMIT=PATHSUBMIT)

    def get(self):

        self.redirect("/")


class WSCorreosChileHandler(BaseHandler):

    def get(self):

        from suds.client import Client

        client = Client(
            url='http://b2b.correos.cl:8008/ServicioTarificadorPersonasExterno/cch/ws/tarificacion/externo/implementacion/ServicioExternoTarificadorPersonas.asmx?WSDL')

        request = client.factory.create('tns:aplicarTarifaPersona')
        request.usuario = 'FIRENZE'
        request.contrasena = 'GIANI'
        request.cobertura = '1'
        request.iataOrigen = 'ARICA'
        request.iataDestino = 'SANTIAGO'
        request.peso = 0.5

        response = client.service.aplicarTarifaPersona(request)

        self.write(response)


class AboutusHandler(BaseHandler):

    def get(self):
        self.render("aboutus.html")


class HistoryHandler(BaseHandler):

    def get(self):
        self.render("history.html")


class ConditionsHandler(BaseHandler):

    def get(self):
        self.render("conditions.html")


class FaqHandler(BaseHandler):

    def get(self):
        self.render("faq.html")


class UserHandler(BaseHandler):

    def get(self):
        self.render("user.html")
