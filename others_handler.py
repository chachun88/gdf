#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os.path
import os

import tornado.auth
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
from tornado.options import define, options
from basehandler import BaseHandler

from model.kardex import Kardex
from datetime import datetime
import urlparse
from bson import json_util

from globals import email_giani, cellar_id, url_local

import sendgrid

from model.cart import Cart
from model.order import Order
from model.order_detail import OrderDetail
from model.kardex import Kardex
from model.product import Product
from model.contact import Contact

class ContactHandler(BaseHandler):

    def get(self):

        self.render("auth/contacto.html")

    def post(self):

        name = self.get_argument("name","").encode("utf-8")
        email = self.get_argument("email","").encode("utf-8")
        subject = self.get_argument("subject","").encode("utf-8")
        message = self.get_argument("message","").encode("utf-8")

        if name == "" or email == "" or subject == "" or message == "":

            self.write("Debe ingresar los campos requeridos")

        else:

            sg = sendgrid.SendGridClient('nailuj41', 'Equipo_1234')
            mensaje = sendgrid.Mail()
            mensaje.set_from("{nombre} <{mail}>".format(nombre=name,mail=email))
            mensaje.add_to(email_giani)
            mensaje.set_subject("Contact GDF - {}".format(subject))
            mensaje.set_html(message)
            status, msg = sg.send(mensaje)

            if status == 200:
                self.render("message.html",message="Gracias por contactarte con nosotros, su mensaje ha sido enviado exitosamente")
            else:
                self.render("beauty_error.html",message="Ha ocurrido un error al enviar su mensaje, {}".format(msg))

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
        self.render( "tos.html" )

class TestPagoHandler(BaseHandler):

    def get(self):

        self.render("testpago.html")

    def post(self):

        TBK_TIPO_TRANSACCION = self.get_argument("TBK_TIPO_TRANSACCION","")
        TBK_MONTO = self.get_argument("TBK_MONTO","")
        # TBK_ORDEN_COMPRA = self.get_argument("TBK_ORDEN_COMPRA","")
        TBK_ID_SESION = self.get_argument("TBK_ID_SESION","")
        TBK_URL_EXITO = self.get_argument("TBK_URL_EXITO","")
        TBK_URL_FRACASO = self.get_argument("TBK_URL_FRACASO","")

        user_id = self.current_user["id"]

        order = Order()
        
        cart = Cart()
        cart.user_id = user_id

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
                c = Cart()
                c.InitById(l["id"])
                c.payment_type = 2
                c.Edit()
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
            order.voucher = ""
            order.state = 1

            response_obj = order.Save()

            if "success" in response_obj:

                for l in lista:

                    detail = OrderDetail()
                    detail.order_id = order.id
                    detail.quantity = l["quantity"]
                    detail.subtotal = l["subtotal"]
                    detail.product_id = l["product_id"]
                    detail.size = l["size"]
                    res_obj = detail.Save()

                    # if "error" in res_obj:
                    #     print "{}".format(res_obj["error"])

        myPath = "/var/www/giani.ondev/webpay/dato{}.log".format(TBK_ID_SESION)

        f = open(myPath, "w+");
        linea = "{};{}".format(TBK_MONTO,order.id)
        f.write(linea);
        f.close();

        data = {
        "TBK_TIPO_TRANSACCION":TBK_TIPO_TRANSACCION,
        "TBK_MONTO":TBK_MONTO,
        "TBK_ORDEN_COMPRA":order.id,
        "TBK_ID_SESION":TBK_ID_SESION,
        "TBK_URL_EXITO":TBK_URL_EXITO,
        "TBK_URL_FRACASO":TBK_URL_FRACASO
        }


        # self.write(json_util.dumps(data))
        self.render("testtransbank.html",data=data)

        

class XtCompraHandler(BaseHandler):

    def post(self):


        TBK_RESPUESTA=self.get_argument("TBK_RESPUESTA")
        TBK_ORDEN_COMPRA=self.get_argument("TBK_ORDEN_COMPRA")
        TBK_MONTO=self.get_argument("TBK_MONTO")
        TBK_ID_SESION=self.get_argument("TBK_ID_SESION")

        myPath = "/var/www/giani.ondev/webpay/dato{}.log".format(TBK_ID_SESION)

        filename_txt = "/var/www/giani.ondev/webpay/MAC01Normal{}.txt".format(TBK_ID_SESION)

        cmdline = "/var/www/cgiani.ondev/cgi-bin/tbk_check_mac.cgi {}".format(filename_txt)


        acepta=False;

        f=open(myPath,"r")

        linea = ""

        for l in f:
            if l.strip() != "":
                linea = l

        f.close()

        detalle=linea.split(";")

        # print "linea:{}".format(linea)

        if len(detalle)>0:
            monto = detalle[0]
            ordenCompra = detalle[1]

        f=open(filename_txt,"wt")

        f.write("{}={}&".format("TBK_ORDEN_COMPRA",self.get_argument("TBK_ORDEN_COMPRA")))
        f.write("{}={}&".format("TBK_TIPO_TRANSACCION",self.get_argument("TBK_TIPO_TRANSACCION")))
        f.write("{}={}&".format("TBK_RESPUESTA",self.get_argument("TBK_RESPUESTA")))
        f.write("{}={}&".format("TBK_MONTO",self.get_argument("TBK_MONTO")))
        f.write("{}={}&".format("TBK_CODIGO_AUTORIZACION",self.get_argument("TBK_CODIGO_AUTORIZACION")))
        f.write("{}={}&".format("TBK_FINAL_NUMERO_TARJETA",self.get_argument("TBK_FINAL_NUMERO_TARJETA")))
        f.write("{}={}&".format("TBK_FECHA_CONTABLE",self.get_argument("TBK_FECHA_CONTABLE")))
        f.write("{}={}&".format("TBK_FECHA_TRANSACCION",self.get_argument("TBK_FECHA_TRANSACCION")))
        f.write("{}={}&".format("TBK_HORA_TRANSACCION",self.get_argument("TBK_HORA_TRANSACCION")))
        f.write("{}={}&".format("TBK_ID_SESION",self.get_argument("TBK_ID_SESION")))
        f.write("{}={}&".format("TBK_ID_TRANSACCION",self.get_argument("TBK_ID_TRANSACCION")))
        f.write("{}={}&".format("TBK_TIPO_PAGO",self.get_argument("TBK_TIPO_PAGO")))
        f.write("{}={}&".format("TBK_NUMERO_CUOTAS",self.get_argument("TBK_NUMERO_CUOTAS")))
        f.write("{}={}&".format("TBK_VCI",self.get_argument("TBK_VCI")))
        f.write("{}={}&".format("TBK_MAC",self.get_argument("TBK_MAC")))

        f.close()

        if TBK_RESPUESTA == "0":
            acepta = True
        else:
            acepta = False

        if TBK_MONTO == monto and TBK_ORDEN_COMPRA == ordenCompra and acepta == True:
            acepta = True
        else:
            acepta = False


        if acepta:

            resultado = os.popen(cmdline).read()

            # print "RESULTADO:-----{}----".format(resultado.strip())
            
            if resultado.strip() == "CORRECTO":
                acepta = True
            else:
                acepta = False

        order = Order()
        init_by_id = order.InitById(TBK_ORDEN_COMPRA)

        # si ya existe la orden rechazar el pago
        if "success" in init_by_id:
            if order.state != 1:
                acepta = False


        if acepta:
            # print "si acepto"
            self.write("ACEPTADO")
        else:
            # print "no acepto"
            self.write("RECHAZADO")

class ExitoHandler(BaseHandler):

    def post(self):

        TBK_ID_SESION = self.get_argument("TBK_ID_SESION","")
        TBK_ORDEN_COMPRA = self.get_argument("TBK_ORDEN_COMPRA","")

        myPath = "/var/www/giani.ondev/webpay/MAC01Normal{}.txt".format(TBK_ID_SESION)
        pathSubmit = "http://giani.ondev.today"

        f = open(myPath,"r")
        linea = ""

        for l in f:
            if l.strip() != "":
                linea = l

        f.close()

        # json_util.dumps(urlparse.parse_qs(linea))

        dict_parametros = urlparse.parse_qs(linea)

        # self.write(dict_parametros["TBK_MONTO"][0])

        # detalle = linea.split("&")

        TBK_ORDEN_COMPRA = dict_parametros["TBK_ORDEN_COMPRA"][0]
        TBK_TIPO_TRANSACCION = dict_parametros["TBK_TIPO_TRANSACCION"][0]
        TBK_RESPUESTA = dict_parametros["TBK_RESPUESTA"][0]
        TBK_MONTO = dict_parametros["TBK_MONTO"][0]
        TBK_CODIGO_AUTORIZACION = dict_parametros["TBK_CODIGO_AUTORIZACION"][0]
        TBK_FINAL_NUMERO_TARJETA = dict_parametros["TBK_FINAL_NUMERO_TARJETA"][0]
        TBK_HORA_TRANSACCION = dict_parametros["TBK_HORA_TRANSACCION"][0]
        TBK_ID_TRANSACCION = dict_parametros["TBK_ID_TRANSACCION"][0]
        TBK_TIPO_PAGO = dict_parametros["TBK_TIPO_PAGO"][0]
        TBK_NUMERO_CUOTAS = dict_parametros["TBK_NUMERO_CUOTAS"][0]
        TBK_MAC = dict_parametros["TBK_MAC"][0]
        

        TBK_FECHA_CONTABLE = dict_parametros["TBK_FECHA_CONTABLE"][0] # ej: 1006
        TBK_FECHA_TRANSACCION = dict_parametros["TBK_FECHA_TRANSACCION"][0] # ej: 1006

        mes_contable = TBK_FECHA_CONTABLE[:2] #extrae el 10
        dia_contable = TBK_FECHA_CONTABLE[2:] #extrae el 06

        # formatea la fecha como 10-06

        TBK_FECHA_CONTABLE = "{mes}-{dia}".format(mes=mes_contable,dia=dia_contable)

        # aqui se repite la misma operacion para obtener mes y dia

        mes_transaccion = TBK_FECHA_TRANSACCION[:2]
        dia_transaccion = TBK_FECHA_TRANSACCION[2:]

        TBK_FECHA_TRANSACCION = "{mes}-{dia}".format(mes=mes_transaccion,dia=dia_transaccion)

        TBK_HORA_TRANSACCION = dict_parametros["TBK_HORA_TRANSACCION"][0]

        hora_transaccion = TBK_HORA_TRANSACCION[:2]
        minutos_transaccion = TBK_HORA_TRANSACCION[2:4]
        segundo_transaccion = TBK_HORA_TRANSACCION[4:]

        TBK_HORA_TRANSACCION = "{hora}:{minutos}:{segundos}".format(hora=hora_transaccion,minutos=minutos_transaccion,segundos=segundo_transaccion)

        data = {
        "TBK_ORDEN_COMPRA":TBK_ORDEN_COMPRA,
        "TBK_TIPO_TRANSACCION":TBK_TIPO_TRANSACCION,
        "TBK_RESPUESTA":TBK_RESPUESTA,
        "TBK_MONTO":int(TBK_MONTO),
        "TBK_CODIGO_AUTORIZACION":TBK_CODIGO_AUTORIZACION,
        "TBK_FINAL_NUMERO_TARJETA":TBK_FINAL_NUMERO_TARJETA,
        "TBK_HORA_TRANSACCION":TBK_HORA_TRANSACCION,
        "TBK_ID_TRANSACCION":TBK_ID_TRANSACCION,
        "TBK_TIPO_PAGO":TBK_TIPO_PAGO,
        "TBK_NUMERO_CUOTAS":TBK_NUMERO_CUOTAS,
        "TBK_MAC":TBK_MAC,
        "TBK_FECHA_CONTABLE":TBK_FECHA_CONTABLE,
        "TBK_FECHA_TRANSACCION":TBK_FECHA_TRANSACCION,
        "TBK_HORA_TRANSACCION":TBK_HORA_TRANSACCION
        }


        order = Order()
        init_by_id = order.InitById(TBK_ORDEN_COMPRA)
        order.state = 2
        save_order = order.Edit()

        if "error" in save_order:
            self.render("store/failure.html")
        
        detail = OrderDetail()

        lista = detail.ListByOrderId(TBK_ORDEN_COMPRA)

        if len(lista) > 0:

            detalle_orden = ""

            for l in lista:

                kardex = Kardex()

                producto = Product()
                response = producto.InitById(l["product_id"])

                if "success" in response:

                    kardex.product_sku = producto.sku
                    kardex.cellar_identifier = cellar_id
                    kardex.operation_type = Kardex.OPERATION_SELL
                    kardex.sell_price = producto.sell_price
                    kardex.size = l["size"]
                    kardex.date = str(datetime.now().isoformat()) 
                    kardex.user = self.current_user["email"]
                    kardex.units = l["quantity"]


                    kardex.Insert()

                # if "error" in res_obj:
                #     print "{}".format(res_obj["error"])

                

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

            cart = Cart()
            cart.user_id = self.current_user["id"]
            cart.RemoveByUserId()

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
                self.render("store/success.html",data=data,pathSubmit=pathSubmit)
            else:
                self.render("store/failure.html",message="Error al enviar correo de confirmación, {}".format(msg))



        else:

            self.render("store/failure.html",message="Carro se encuentra vacío")


        self.render("store/success.html",data=data,pathSubmit=pathSubmit)

class FracasoHandler(BaseHandler):

    def post(self):

        PATHSUBMIT = "http://giano.ondev.today"
        TBK_ID_SESION = self.get_argument("TBK_ID_SESION","")
        TBK_ORDEN_COMPRA = self.get_argument("TBK_ORDEN_COMPRA","")

        self.render("store/failure.html",TBK_ID_SESION=TBK_ID_SESION,TBK_ORDEN_COMPRA=TBK_ORDEN_COMPRA,PATHSUBMIT=PATHSUBMIT)

