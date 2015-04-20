#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os.path
import os

from basehandler import BaseHandler

from model.kardex import Kardex
from datetime import datetime
import urlparse

from globals import email_giani, \
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
        name = self.get_argument("name","").encode("utf-8")
        email = self.get_argument("email","").encode("utf-8")
        subject = self.get_argument("subject","").encode("utf-8")
        message = self.get_argument("message","").encode("utf-8")

        if name == "" or email == "" or subject == "" or message == "":

            self.write("Debe ingresar los campos requeridos")

        else:

            sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
            mensaje = sendgrid.Mail()
            mensaje.set_from("{nombre} <{mail}>".format(nombre=name,mail=email))
            mensaje.add_to(email_giani)
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
        self.render( "tos.html" )


class PagoHandler(BaseHandler):

    # def get(self):

    #     self.render("pago.html")

    def post(self):

        TBK_TIPO_TRANSACCION = self.get_argument("TBK_TIPO_TRANSACCION","")
        TBK_MONTO = self.get_argument("TBK_MONTO","")
        TBK_ID_SESION = self.get_argument("TBK_ID_SESION","")
        TBK_URL_EXITO = self.get_argument("TBK_URL_EXITO","")
        TBK_URL_FRACASO = self.get_argument("TBK_URL_FRACASO","")

        payment_type = self.get_argument("payment_type",2)
        costo_despacho = int(self.get_argument("shipping_price",0))

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
        linea = "{};{}".format(TBK_MONTO,order.id)
        f.write(linea)
        f.close()

        data = {
            "TBK_TIPO_TRANSACCION":TBK_TIPO_TRANSACCION,
            "TBK_MONTO":TBK_MONTO,
            "TBK_ORDEN_COMPRA":order.id,
            "TBK_ID_SESION":TBK_ID_SESION,
            "TBK_URL_EXITO":TBK_URL_EXITO,
            "TBK_URL_FRACASO":TBK_URL_FRACASO
        }

        # self.write(json_util.dumps(data))
        self.render("transbank.html",data=data)


class XtCompraHandler(BaseHandler):

    def get(self):
        self.write("RECHAZADO")

    def post(self):
        TBK_RESPUESTA = self.get_argument("TBK_RESPUESTA")
        TBK_ORDEN_COMPRA = self.get_argument("TBK_ORDEN_COMPRA")
        TBK_MONTO = self.get_argument("TBK_MONTO")
        TBK_ID_SESION = self.get_argument("TBK_ID_SESION")

        myPath = "{}webpay/dato{}.log".format(project_path,TBK_ID_SESION)

        filename_txt = "{}webpay/MAC01Normal{}.txt".format(
                project_path, 
                TBK_ID_SESION)

        cmdline = "{}cgi-bin/tbk_check_mac.cgi {}".format(cgi_path,filename_txt)

        acepta = False

        if TBK_RESPUESTA == "0":
            acepta = True

        try:
            f = open(myPath,"r")

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

            f = open(filename_txt,"wt")

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
                    webpay.tbk_orden_compra = self.get_argument("TBK_ORDEN_COMPRA")
                    webpay.tbk_tipo_transaccion = self.get_argument("TBK_TIPO_TRANSACCION")
                    webpay.tbk_monto = self.get_argument("TBK_MONTO")
                    webpay.tbk_codigo_autorizacion = self.get_argument("TBK_CODIGO_AUTORIZACION")
                    webpay.tbk_final_numero_tarjeta = self.get_argument("TBK_FINAL_NUMERO_TARJETA")
                    webpay.tbk_fecha_contable = self.get_argument("TBK_FECHA_CONTABLE")
                    webpay.tbk_fecha_transaccion = self.get_argument("TBK_FECHA_TRANSACCION")
                    webpay.tbk_hora_transaccion = self.get_argument("TBK_HORA_TRANSACCION")
                    webpay.tbk_id_sesion = self.get_argument("TBK_ID_SESION")
                    webpay.tbk_id_transaccion = self.get_argument("TBK_ID_TRANSACCION")
                    webpay.tbk_tipo_pago = self.get_argument("TBK_TIPO_PAGO")
                    webpay.tbk_numero_cuotas = self.get_argument("TBK_NUMERO_CUOTAS")
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

    # def get(self):

    #     self.render("pago.html")

    #     TBK_ID_SESION = self.get_argument("TBK_ID_SESION","20141015235139")
    #     TBK_ORDEN_COMPRA = self.get_argument("TBK_ORDEN_COMPRA","133")

    #     detail = OrderDetail()

    #     lista = detail.ListByOrderId(TBK_ORDEN_COMPRA)

    #     order = Order()
    #     pedido = order.GetOrderById(TBK_ORDEN_COMPRA)

    #     myPath = "/var/www/giani.ondev/webpay/MAC01Normal{}.txt".format(TBK_ID_SESION)
    #     pathSubmit = "http://giani.ondev.today"

    #     f = open(myPath,"r")
    #     linea = ""

    #     for l in f:
    #         if l.strip() != "":
    #             linea = l

    #     f.close()
    #     dict_parametros = urlparse.parse_qs(linea)

    #     TBK_ORDEN_COMPRA = dict_parametros["TBK_ORDEN_COMPRA"][0]
    #     TBK_TIPO_TRANSACCION = dict_parametros["TBK_TIPO_TRANSACCION"][0]
    #     TBK_RESPUESTA = dict_parametros["TBK_RESPUESTA"][0]
    #     TBK_MONTO = dict_parametros["TBK_MONTO"][0]
    #     TBK_CODIGO_AUTORIZACION = dict_parametros["TBK_CODIGO_AUTORIZACION"][0]
    #     TBK_FINAL_NUMERO_TARJETA = dict_parametros["TBK_FINAL_NUMERO_TARJETA"][0]
    #     TBK_HORA_TRANSACCION = dict_parametros["TBK_HORA_TRANSACCION"][0]
    #     TBK_ID_TRANSACCION = dict_parametros["TBK_ID_TRANSACCION"][0]
    #     TBK_TIPO_PAGO = dict_parametros["TBK_TIPO_PAGO"][0]
    #     TBK_NUMERO_CUOTAS = dict_parametros["TBK_NUMERO_CUOTAS"][0]
    #     TBK_MAC = dict_parametros["TBK_MAC"][0]
    #     TBK_FECHA_TRANSACCION = dict_parametros["TBK_FECHA_TRANSACCION"][0] # ej: 1006

    #     # aqui se repite la misma operacion para obtener mes y dia

    #     mes_transaccion = TBK_FECHA_TRANSACCION[:2]
    #     dia_transaccion = TBK_FECHA_TRANSACCION[2:]

    #     TBK_FECHA_TRANSACCION = "{year}-{mes}-{dia}".format(year=pedido["date"].year,mes=mes_transaccion,dia=dia_transaccion)

    #     TBK_HORA_TRANSACCION = dict_parametros["TBK_HORA_TRANSACCION"][0]

    #     hora_transaccion = TBK_HORA_TRANSACCION[:2]
    #     minutos_transaccion = TBK_HORA_TRANSACCION[2:4]
    #     segundo_transaccion = TBK_HORA_TRANSACCION[4:]

    #     TBK_HORA_TRANSACCION = "{hora}:{minutos}:{segundos}".format(hora=hora_transaccion,minutos=minutos_transaccion,segundos=segundo_transaccion)

    #     TBK_TIPO_CUOTA = TBK_TIPO_PAGO

    #     if TBK_TIPO_PAGO == "VD":
    #         TBK_TIPO_PAGO = "Redcompra"
    #     else:
    #         TBK_TIPO_PAGO = "Cr&eacute;dito"

    #     data = {
    #     "TBK_ORDEN_COMPRA":TBK_ORDEN_COMPRA,
    #     "TBK_TIPO_TRANSACCION":TBK_TIPO_TRANSACCION,
    #     "TBK_RESPUESTA":TBK_RESPUESTA,
    #     "TBK_MONTO":int(TBK_MONTO),
    #     "TBK_CODIGO_AUTORIZACION":TBK_CODIGO_AUTORIZACION,
    #     "TBK_FINAL_NUMERO_TARJETA":TBK_FINAL_NUMERO_TARJETA,
    #     "TBK_HORA_TRANSACCION":TBK_HORA_TRANSACCION,
    #     "TBK_ID_TRANSACCION":TBK_ID_TRANSACCION,
    #     "TBK_TIPO_PAGO":TBK_TIPO_PAGO,
    #     "TBK_NUMERO_CUOTAS":TBK_NUMERO_CUOTAS,
    #     "TBK_MAC":TBK_MAC,
    #     "TBK_FECHA_TRANSACCION":TBK_FECHA_TRANSACCION,
    #     "TBK_HORA_TRANSACCION":TBK_HORA_TRANSACCION,
    #     "TBK_TIPO_CUOTA":TBK_TIPO_CUOTA
    #     }

    #     self.render("store/success.html",data=data,pathSubmit=pathSubmit,webpay="si",detalle=lista)

    # TBK_ID_SESION:20141015235139
    # TBK_ORDEN_COMPRA:133

    def post(self):

        TBK_ID_SESION = self.get_argument("TBK_ID_SESION","")
        TBK_ORDEN_COMPRA = self.get_argument("TBK_ORDEN_COMPRA","")
        pathSubmit = url_local

        # referer = self.request.headers.get('Referer').replace(self.request.headers.get('Origin'),"")

        # if referer != "/xt_compra":
        #     self.render("store/failure.html",TBK_ID_SESION=TBK_ID_SESION,TBK_ORDEN_COMPRA=TBK_ORDEN_COMPRA,PATHSUBMIT=pathSubmit)

        order = Order()
        init_by_id = order.InitById(TBK_ORDEN_COMPRA)

        if "success" in init_by_id:
            # print str(order.state)
            if int(order.state) == Order.ESTADO_PENDIENTE:
                self.render(
                    "store/failure.html",
                    TBK_ID_SESION=TBK_ID_SESION,
                    TBK_ORDEN_COMPRA=TBK_ORDEN_COMPRA,
                    PATHSUBMIT=pathSubmit)
        else:

            # self.render(
            #     "store/failure.html",
            #     TBK_ID_SESION=TBK_ID_SESION,
            #     TBK_ORDEN_COMPRA=TBK_ORDEN_COMPRA,
            #     PATHSUBMIT=pathSubmit)
            self.render("beauty_error.html",message="Error verificando estado del pedido, {}".format(init_by_id["error"]))

        if os.name != "nt":
            myPath = "{}webpay/MAC01Normal{}.txt".format(
                                                    project_path, 
                                                    TBK_ID_SESION)
        else:
            myPath = "C:\Users\YiChun\Documents\giani\webpay\MAC01Normal{}.txt"\
                .format(TBK_ID_SESION)

        try:

            f = open(myPath,"r")
            linea = ""

            for l in f:
                if l.strip() != "":
                    linea = l

            f.close()

            # json_util.dumps(urlparse.parse_qs(linea))

            dict_parametros = urlparse.parse_qs(linea)

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

            # ej: 1006
            TBK_FECHA_TRANSACCION = dict_parametros["TBK_FECHA_TRANSACCION"][0]

            # aqui se repite la misma operacion para obtener mes y dia

            mes_transaccion = TBK_FECHA_TRANSACCION[:2]
            dia_transaccion = TBK_FECHA_TRANSACCION[2:]

            TBK_FECHA_TRANSACCION = "{year}-{mes}-{dia}".format(
                                                year=order.date.year,
                                                mes=mes_transaccion,
                                                dia=dia_transaccion)

            TBK_HORA_TRANSACCION = dict_parametros["TBK_HORA_TRANSACCION"][0]

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
                "TBK_FECHA_TRANSACCION":TBK_FECHA_TRANSACCION,
                "TBK_HORA_TRANSACCION":TBK_HORA_TRANSACCION,
                "TBK_TIPO_CUOTA":TBK_TIPO_CUOTA
            }

            id_bodega = cellar_id
            id_bodega_reserva = shipping_cellar

            cellar = Cellar()
            res_cellar = cellar.GetWebCellar()

            if "success" in res_cellar:
                id_bodega = res_cellar["success"]

            res_reservation_cellar = cellar.GetReservationCellar()

            if "success" in res_reservation_cellar:
                id_bodega_reserva = res_reservation_cellar["success"]

            detail = OrderDetail()

            lista = detail.ListByOrderId(TBK_ORDEN_COMPRA)

            if len(lista) > 0:

                detalle_orden = ""

                for l in lista:

                    # kardex = Kardex()

                    producto = Product()
                    response = producto.InitById(l["product_id"])

                    if "success" in response:

                        producto.sell_price = l["price"]

                    detalle_orden += """\
                        <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <td style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid; border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{quantity}</td>
                            <td style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid; border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6; border-top:1px solid #d6d6d6;">{name}</td>
                            <td style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{color}</td>
                            <td style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">{size}</td>
                            <td style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {price}</td>
                            <td style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {subtotal}</td>
                          </tr>
                    """.format(name=l["name"].encode("utf-8"),size=l["size"].encode("utf-8"),quantity=l["quantity"],color=l["color"],price=self.money_format(producto.sell_price).encode("utf-8"),subtotal=self.money_format(l["subtotal"]).encode("utf-8"))

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

                datos_facturacion = """\
                <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;"><tbody>
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
                </tbody></table>
                """.format(order_id=order.id,name=facturacion["name"],address=facturacion["address"],town="",city=facturacion["city"],country="",telephone=facturacion["telephone"],email=facturacion["email"])

                datos_despacho = """\
                <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;margin-top:20px;"><tbody>
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
                </tbody></table>
                """.format(order_id=order.id,name=despacho["name"],address=despacho["address"],town="",city=despacho["city"],country="",telephone=despacho["telephone"],email=despacho["email"])

                html = """\
                <html xmlns=""><head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <meta name="viewport" content="initial-scale=1.0"> 
                <meta name="format-detection" content="telephone=no">
                <link href="http://fonts.googleapis.com/css?family=Roboto:300,100,400" rel="stylesheet" type="text/css">

                <body style="font-size:12px; font-family:Roboto,Open Sans,Roboto,Open Sans, Arial,Tahoma, Helvetica, sans-serif; background-color:#ffffff; ">

                  <table width="100%" id="mainStructure" border="0" cellspacing="0" cellpadding="0" style="background-color:#ffffff;">  
                   <!--START TOP NAVIGATION ​LAYOUT-->
                   <tr>
                    <td valign="top">
                      <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">


                        <!-- START CONTAINER NAVIGATION -->
                        <tbody><tr>
                          <td align="center" valign="top">

                            <!-- start top navigation container -->
                            <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container">

                              <tbody><tr>
                                <td valign="top">


                                  <!-- start top navigaton -->
                                  <table width="560" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" >

                                    <!-- start space -->
                                    <tbody><tr>
                                      <td valign="top" height="20">
                                      </td>
                                    </tr>
                                    <!-- end space -->

                                    <tr>
                                      <td valign="middle">

                                        <table align="center" border="0" cellspacing="0" cellpadding="0" class="container2">

                                          <tbody><tr>
                                            <td align="center" valign="top">
                                             <a href="#"><img src="{url_local}/static/images/giani-logo-2-gris-260x119.png" width="250" style="max-width:250px;" alt="Logo" border="0" hspace="0" vspace="0"></a>
                                           </td>

                                         </tr>


                                         <!-- start space -->
                                         <tr>
                                          <td valign="top" class="increase-Height-20">

                                          </td>
                                        </tr>
                                        <!-- end space -->

                                      </tbody></table>

                                      <!--start content nav -->
                                      <!--end content nav -->

                                    </td>
                                  </tr>

                                  <!-- start space -->
                                  <tr>
                                    <td valign="top" height="20">
                                    </td>
                                  </tr>
                                  <!-- end space -->

                                </tbody></table>
                                <!-- end top navigaton -->
                              </td>
                            </tr>
                          </tbody></table>
                          <!-- end top navigation container -->

                        </td>
                      </tr>


                      <!-- END CONTAINER NAVIGATION -->

                    </tbody></table>
                  </td>
                </tr>
                <!--END TOP NAVIGATION ​LAYOUT-->
                <!-- START LAYOUT-1/1 --> 

                <tr>
                 <td align="center" valign="top" class="fix-box">

                   <!-- start  container width 600px --> 
                   <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color: #ffffff; ">


                     <tbody><tr>
                       <td valign="top">

                         <!-- start container width 560px --> 
                         <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;margin-top:10px;">


                           <!-- start text content --> 
                           <tbody><tr>
                             <td valign="top">
                               <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                 <tbody><tr>
                                   <td valign="top" width="auto" align="center">
                                     <!-- start button -->                         
                                     <table border="0" align="center" cellpadding="0" cellspacing="0">
                                       <tbody><tr>
                                         <td width="auto" align="center" valign="middle" height="28" style=" background-color:#ffffff; border:1px solid #ececed; background-clip: padding-box; font-size:18px; font-family:Roboto,Open Sans, Arial,Tahoma, Helvetica, sans-serif; text-align:center;  color:#a3a2a2; font-weight: 300; padding-left:18px; padding-right:18px; ">

                                           <span style="color: #a3a2a2; font-weight: 300;">
                                             <a href="#" style="text-decoration: none; color: #a3a2a2; font-weight: 300;">
                                               HOLA <span style="color: #FEBEBD; font-weight: 300;">{name}</span>
                                             </a>
                                           </span>
                                         </td>
                                       </tr>
                                     </tbody></table>
                                     <!-- end button -->   
                                   </td>
                                 </tr>



                               </tbody></table>
                             </td>
                           </tr>
                           <!-- end text content --> 


                         </tbody></table>
                         <!-- end  container width 560px --> 
                       </td>
                     </tr>
                   </tbody></table>
                   <!-- end  container width 600px --> 
                 </td>
                </tr>

                <!-- END LAYOUT-1/1 --> 


                <!-- START LAYOUT-1/2 --> 

                <tr>
                 <td align="center" valign="top" class="fix-box">

                   <!-- start  container width 600px --> 
                   <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color: #ffffff; ">


                     <tbody><tr>
                       <td valign="top">

                         <!-- start container width 560px --> 
                         <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;">


                           <!-- start text content --> 
                           <tbody><tr>
                             <td valign="top">
                               <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">


                                 <!-- start text content --> 
                                 <tbody><tr>
                                   <td valign="top">
                                     <table border="0" cellspacing="0" cellpadding="0" align="center">


                                       <!--start space height --> 
                                       <tbody><tr>
                                         <td height="15"></td>
                                       </tr>
                                       <!--end space height --> 

                                       <tr>
                                         <td style="font-size: 13px; line-height: 22px; font-family:Roboto,Open Sans,Arial,Tahoma, Helvetica, sans-serif; color:#a3a2a2; font-weight:300; text-align:center; ">


                                           Gracias por comprar en Giani da Firenze


                                         </td>
                                       </tr>

                                       <!--start space height --> 
                                       <tr>
                                         <td height="15"></td>
                                       </tr>
                                       <!--end space height --> 



                                     </tbody></table>
                                   </td>
                                 </tr>
                                 <!-- end text content -->

                                 <tr>
                                   <td valign="top" width="auto" align="center">

                                   </td>

                                 </tr>

                               </tbody></table>
                             </td>
                           </tr>
                           <!-- end text content --> 

                           <!--start space height --> 
                           <tr>
                             <td height="20"></td>
                           </tr>
                           <!--end space height --> 


                         </tbody></table>
                         <!-- end  container width 560px --> 
                       </td>
                     </tr>
                   </tbody></table>
                   <!-- end  container width 600px --> 
                 </td>
                </tr>

                <!-- END LAYOUT-1/2 --> 

                <!-- START LAYOUT-1/2 --> 

                <tr>
                 <td align="center" valign="top" class="fix-box">

                   <!-- start  container width 600px --> 
                   <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color: #ffffff; padding-bottom:20px; ">


                     <tbody><tr>
                       <td valign="top">

                         <!-- start container width 560px --> 
                         <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;">


                           <!-- start text content --> 
                           <tbody><tr>
                             <td valign="top">
                               <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">


                                 <!-- start text content --> 
                                 <tbody><tr>
                                   <td valign="top">
                                     <table border="0" cellspacing="0" cellpadding="0" align="center">


                                       <!--start space height --> 
                                       <tbody><tr>
                                         <td height="15"></td>
                                       </tr>
                                       <!--end space height --> 

                                       <tr>
                                         <td style="font-size: 13px; line-height: 22px; font-family:Roboto,Open Sans,Arial,Tahoma, Helvetica, sans-serif; color:#a3a2a2; font-weight:300; text-align:center; ">





                                         </td>
                                       </tr>

                                       <!--start space height --> 
                                       <tr>
                                         <td height="15"></td>
                                       </tr>
                                       <!--end space height --> 



                                     </tbody></table>
                                   </td>
                                 </tr>
                                 <!-- end text content -->

                                 <tr>
                                   <td valign="top" width="auto" align="center">

                                   </td>

                                 </tr>

                               </tbody></table>
                             </td>
                           </tr>
                           <!-- end text content --> 

                           <!--start space height --> 
                           <tr>
                             <td height="20"></td>
                           </tr>
                           <!--end space height --> 


                         </tbody></table>


                                        {datos_facturacion}
                                        {datos_despacho}

                                        <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;margin-top:20px;"><tbody>
                                          <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                                            <th colspan=2 style="line-height: 2.5;height: 30px; border: 1px;border-color: #d6d6d6; border-style: solid; text-align: center;">Datos compra</th>
                                          </tr>
                                        </tbody></table>
                                        <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;"><tbody>
                                          <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                                            <th style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;border-right: 1px solid #d6d6d6; ">Cantidad</th>
                                            <th style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Nombre producto</th>
                                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid; border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Color</th>
                                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Talla</th>
                                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Precio</th>
                                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Subtotal</th>
                                          </tr>
                                            {detalle_orden}

                                        </tbody></table>

                        <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;margin-top:20px;"><tbody>
                          <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th colspan=2 style="line-height: 2.5;height: 30px; border: 1px;border-color: #d6d6d6; border-style: solid; text-align: center;">Resumen</th>
                          </tr>
                          <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Subtotal </th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {order_subtotal}</td>
                          </tr>
                          <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Costo de Env&iacute;o</th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {costo_despacho}</td>
                          </tr>
                          <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Total</th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {order_total}</td>
                          </tr>
                        </tbody></table>
                        <!-- end  container width 560px --> 
                      </td>
                    </tr>
                  </tbody></table>
                  <!-- end  container width 600px --> 
                </td>
                </tr>

                <!-- END LAYOUT-1/2 --> 

                <!--START FOOTER LAYOUT-->
                <tr>
                  <td valign="top">
                    <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">


                      <!-- START CONTAINER  -->
                      <tbody><tr>
                        <td align="center" valign="top">

                          <!-- start footer container -->
                          <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container">

                            <tbody><tr>
                              <td valign="top">


                                <!-- start footer -->
                                <table width="560" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width">

                                  <!-- start space -->
                                  <tbody><tr>
                                    <td valign="top" height="20">
                                    </td>
                                  </tr>
                                  <!-- end space -->

                                  <tr>
                                    <td valign="middle">

                                      <table align="center" border="0" cellspacing="0" cellpadding="0" class="container2">

                                        <tbody><tr>
                                          <td align="center" valign="top">
                                           <a href="#"><img src="{url_local}/static/images/giani-logo-2-gris-260x119.png" width="114" style="max-width:114px;" alt="Logo" border="0" hspace="0" vspace="0"></a>
                                         </td>

                                       </tr>

                                       <!-- start space -->
                                       <tr>
                                        <td valign="top" class="increase-Height-20">
                                        </td>
                                      </tr>
                                      <!-- end space -->

                                    </tbody></table>

                                  </td>
                                </tr>

                                <!-- start space -->
                                <tr>
                                  <td valign="top" height="20">
                                  </td>
                                </tr>
                                <!-- end space -->

                              </tbody></table>
                              <!-- end footer -->
                            </td>
                          </tr>
                        </tbody></table>
                        <!-- end footer container -->

                      </td>
                    </tr>

                    <!-- END CONTAINER  -->

                  </tbody></table>
                </td>
                </tr>
                <!--END FOOTER ​LAYOUT-->

                <!--  START FOOTER COPY RIGHT -->

                <tr>
                  <td align="center" valign="top" style="background-color:#FEBEBD;">
                    <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color:#FEBEBD;">
                      <tbody><tr>
                        <td valign="top">
                          <table width="560" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color:#FEBEBD;">

                            <!--start space height -->                      
                            <tbody><tr>
                              <td height="10"></td>
                            </tr>
                            <!--end space height --> 

                            <tr>
                              <!-- start COPY RIGHT content -->  
                              <td valign="top" style="font-size: 13px; line-height: 22px; font-family:Roboto,Open Sans, Arial,Tahoma, Helvetica, sans-serif; color:#ffffff; font-weight:300; text-align:center; ">
                               GIANI DA FIRENZE 2014 ®
                             </td>
                             <!-- end COPY RIGHT content --> 
                           </tr>

                           <!--start space height -->                      
                           <tr>
                            <td height="10"></td>
                          </tr>
                          <!--end space height --> 


                        </tbody></table>
                      </td>
                    </tr>
                  </tbody></table>
                </td>
                </tr>
                <!--  END FOOTER COPY RIGHT -->
                </table>

                </table>
                </body></html>
                """.format(
                    name=self.current_user["name"].encode("utf-8"),
                    order_id=order.id,
                    datos_facturacion=datos_facturacion,
                    datos_despacho=datos_despacho,
                    detalle_orden=detalle_orden,
                    order_total=self.money_format(order.total+order.shipping),
                    order_subtotal=self.money_format(order.subtotal),
                    order_tax=self.money_format(order.tax),
                    url_local=url_local,
                    costo_despacho=self.money_format(order.shipping))

                # email_confirmacion = "yichun212@gmail.com"

                sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
                message = sendgrid.Mail()
                message.set_from("{nombre} <{mail}>".format(
                    nombre="Giani Da Firenze",
                    mail=email_giani))
                message.add_to(self.current_user["email"])

                message.set_subject("Giani Da Firenze - Compra Nº {}"
                                    .format(order.id))

                message.set_html(html)
                status, msg = sg.send(message)

                html = """\
                <html xmlns=""><head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <meta name="viewport" content="initial-scale=1.0"> 
                <meta name="format-detection" content="telephone=no">
                <link href="http://fonts.googleapis.com/css?family=Roboto:300,100,400" rel="stylesheet" type="text/css">

                <body style="font-size:12px; font-family:Roboto,Open Sans,Roboto,Open Sans, Arial,Tahoma, Helvetica, sans-serif; background-color:#ffffff; ">

                  <table width="100%" id="mainStructure" border="0" cellspacing="0" cellpadding="0" style="background-color:#ffffff;">  
                   <!--START TOP NAVIGATION ​LAYOUT-->
                   <tr>
                    <td valign="top">
                      <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">


                        <!-- START CONTAINER NAVIGATION -->
                        <tbody><tr>
                          <td align="center" valign="top">

                            <!-- start top navigation container -->
                            <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container">

                              <tbody><tr>
                                <td valign="top">


                                  <!-- start top navigaton -->
                                  <table width="560" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width">

                                    <!-- start space -->
                                    <tbody><tr>
                                      <td valign="top" height="20">
                                      </td>
                                    </tr>
                                    <!-- end space -->

                                    <tr>
                                      <td valign="middle">

                                        <table align="center" border="0" cellspacing="0" cellpadding="0" class="container2">

                                          <tbody><tr>
                                            <td align="center" valign="top">
                                             <a href="#"><img src="{url_local}/static/images/giani-logo-2-gris-260x119.png" width="250" style="max-width:250px;" alt="Logo" border="0" hspace="0" vspace="0"></a>
                                           </td>

                                         </tr>


                                         <!-- start space -->
                                         <tr>
                                          <td valign="top" class="increase-Height-20">

                                          </td>
                                        </tr>
                                        <!-- end space -->

                                      </tbody></table>

                                      <!--start content nav -->
                                      <!--end content nav -->

                                    </td>
                                  </tr>

                                  <!-- start space -->
                                  <tr>
                                    <td valign="top" height="20">
                                    </td>
                                  </tr>
                                  <!-- end space -->

                                </tbody></table>
                                <!-- end top navigaton -->
                              </td>
                            </tr>
                          </tbody></table>
                          <!-- end top navigation container -->

                        </td>
                      </tr>


                      <!-- END CONTAINER NAVIGATION -->

                    </tbody></table>
                  </td>
                </tr>
                <!--END TOP NAVIGATION ​LAYOUT-->
                <!-- START LAYOUT-1/1 --> 

                <tr>
                 <td align="center" valign="top" class="fix-box">

                   <!-- start  container width 600px --> 
                   <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color: #ffffff; ">


                     <tbody><tr>
                       <td valign="top">

                         <!-- start container width 560px --> 
                         <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;margin-top:10px;">


                           <!-- start text content --> 
                           <tbody><tr>
                             <td valign="top">
                               <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                 <tbody><tr>
                                   <td valign="top" width="auto" align="center">
                                     <!-- start button -->                         
                                     <table border="0" align="center" cellpadding="0" cellspacing="0">
                                       <tbody><tr>
                                         <td width="auto" align="center" valign="middle" height="28" style=" background-color:#ffffff; border:1px solid #ececed; background-clip: padding-box; font-size:18px; font-family:Roboto,Open Sans, Arial,Tahoma, Helvetica, sans-serif; text-align:center;  color:#a3a2a2; font-weight: 300; padding-left:18px; padding-right:18px; ">

                                           <span style="color: #a3a2a2; font-weight: 300;">
                                             <a href="#" style="text-decoration: none; color: #a3a2a2; font-weight: 300;">
                                               HOLA <span style="color: #FEBEBD; font-weight: 300;">{name}</span>
                                             </a>
                                           </span>
                                         </td>
                                       </tr>
                                     </tbody></table>
                                     <!-- end button -->   
                                   </td>
                                 </tr>



                               </tbody></table>
                             </td>
                           </tr>
                           <!-- end text content --> 


                         </tbody></table>
                         <!-- end  container width 560px --> 
                       </td>
                     </tr>
                   </tbody></table>
                   <!-- end  container width 600px --> 
                 </td>
                </tr>

                <!-- END LAYOUT-1/1 --> 


                <!-- START LAYOUT-1/2 --> 

                <tr>
                 <td align="center" valign="top" class="fix-box">

                   <!-- start  container width 600px --> 
                   <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color: #ffffff; ">


                     <tbody><tr>
                       <td valign="top">

                         <!-- start container width 560px --> 
                         <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;">


                           <!-- start text content --> 
                           <tbody><tr>
                             <td valign="top">
                               <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">


                                 <!-- start text content --> 
                                 <tbody><tr>
                                   <td valign="top">
                                     <table border="0" cellspacing="0" cellpadding="0" align="center">


                                       <!--start space height --> 
                                       <tbody><tr>
                                         <td height="15"></td>
                                       </tr>
                                       <!--end space height --> 

                                       <tr>
                                         <td style="font-size: 13px; line-height: 22px; font-family:Roboto,Open Sans,Arial,Tahoma, Helvetica, sans-serif; color:#a3a2a2; font-weight:300; text-align:center; ">


                                           Ha llegado un pedido de {name}


                                         </td>
                                       </tr>

                                       <!--start space height --> 
                                       <tr>
                                         <td height="15"></td>
                                       </tr>
                                       <!--end space height --> 



                                     </tbody></table>
                                   </td>
                                 </tr>
                                 <!-- end text content -->

                                 <tr>
                                   <td valign="top" width="auto" align="center">

                                   </td>

                                 </tr>

                               </tbody></table>
                             </td>
                           </tr>
                           <!-- end text content --> 

                           <!--start space height --> 
                           <tr>
                             <td height="20"></td>
                           </tr>
                           <!--end space height --> 


                         </tbody></table>
                         <!-- end  container width 560px --> 
                       </td>
                     </tr>
                   </tbody></table>
                   <!-- end  container width 600px --> 
                 </td>
                </tr>

                <!-- END LAYOUT-1/2 --> 

                <!-- START LAYOUT-1/2 --> 

                <tr>
                 <td align="center" valign="top" class="fix-box">

                   <!-- start  container width 600px --> 
                   <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color: #ffffff; padding-bottom:20px; ">


                     <tbody><tr>
                       <td valign="top">

                         <!-- start container width 560px --> 
                         <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;">


                           <!-- start text content --> 
                           <tbody><tr>
                             <td valign="top">
                               <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">


                                 <!-- start text content --> 
                                 <tbody><tr>
                                   <td valign="top">
                                     <table border="0" cellspacing="0" cellpadding="0" align="center">


                                       <!--start space height --> 
                                       <tbody><tr>
                                         <td height="15"></td>
                                       </tr>
                                       <!--end space height --> 

                                       <tr>
                                         <td style="font-size: 13px; line-height: 22px; font-family:Roboto,Open Sans,Arial,Tahoma, Helvetica, sans-serif; color:#a3a2a2; font-weight:300; text-align:center; ">





                                         </td>
                                       </tr>

                                       <!--start space height --> 
                                       <tr>
                                         <td height="15"></td>
                                       </tr>
                                       <!--end space height --> 



                                     </tbody></table>
                                   </td>
                                 </tr>
                                 <!-- end text content -->

                                 <tr>
                                   <td valign="top" width="auto" align="center">

                                   </td>

                                 </tr>

                               </tbody></table>
                             </td>
                           </tr>
                           <!-- end text content --> 

                           <!--start space height --> 
                           <tr>
                             <td height="20"></td>
                           </tr>
                           <!--end space height --> 


                         </tbody></table>


                                        {datos_facturacion}
                                        {datos_despacho}

                                        <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;margin-top:20px;"><tbody>
                                          <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                                            <th colspan=2 style="line-height: 2.5;height: 30px; border: 1px;border-color: #d6d6d6; border-style: solid; text-align: center;">Datos compra</th>
                                          </tr>
                                        </tbody></table>
                                        <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;"><tbody>
                                          <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                                            <th style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Cantidad</th>
                                            <th style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Nombre producto</th>
                                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid; border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Color</th>
                                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Talla</th>
                                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Precio</th>
                                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Subtotal</th>
                                          </tr>

                                            {detalle_orden}

                                            </tbody></table>

                        <table width="540" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width" bgcolor="#ffffff" style="background-color:#ffffff;margin-top:20px;"><tbody>
                          <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th colspan=2 style="line-height: 2.5;height: 30px; border: 1px;border-color: #d6d6d6; border-style: solid; text-align: center;">Resumen</th>
                          </tr>
                          <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Subtotal </th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {order_subtotal}</td>
                          </tr>
                          <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Costo de Env&iacute;o</th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {costo_despacho}</td>
                          </tr>
                          <tr style="font-family: Arial;background-color: #FFFFFF;text-align: center; font-size:12px;">
                            <th style="line-height: 2.5;margin-right: -1px;height: 30px;border-left: 1px;border-left-color: #d6d6d6; border-left-style: solid;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">Total</th>
                            <td style="line-height: 2.5;margin-left: -1px;height: 30px;border-right: 1px;border-right-color: #d6d6d6; border-right-style: solid;border-bottom: 1px; border-bottom-style: solid;border-bottom-color: #d6d6d6;">$ {order_total}</td>
                          </tr>
                        </tbody></table>
                        <!-- end  container width 560px --> 
                      </td>
                    </tr>
                  </tbody></table>
                  <!-- end  container width 600px --> 
                </td>
                </tr>

                <!-- END LAYOUT-1/2 --> 


                <!--START FOOTER LAYOUT-->
                <tr>
                  <td valign="top">
                    <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">


                      <!-- START CONTAINER  -->
                      <tbody><tr>
                        <td align="center" valign="top">

                          <!-- start footer container -->
                          <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container">

                            <tbody><tr>
                              <td valign="top">


                                <!-- start footer -->
                                <table width="560" align="center" border="0" cellspacing="0" cellpadding="0" class="full-width">

                                  <!-- start space -->
                                  <tbody><tr>
                                    <td valign="top" height="20">
                                    </td>
                                  </tr>
                                  <!-- end space -->

                                  <tr>
                                    <td valign="middle">

                                      <table align="center" border="0" cellspacing="0" cellpadding="0" class="container2">

                                        <tbody><tr>
                                          <td align="center" valign="top">
                                           <a href="#"><img src="{url_local}/static/images/giani-logo-2-gris-260x119.png" width="114" style="max-width:114px;" alt="Logo" border="0" hspace="0" vspace="0"></a>
                                         </td>

                                       </tr>

                                       <!-- start space -->
                                       <tr>
                                        <td valign="top" class="increase-Height-20">
                                        </td>
                                      </tr>
                                      <!-- end space -->

                                    </tbody></table>

                                  </td>
                                </tr>

                                <!-- start space -->
                                <tr>
                                  <td valign="top" height="20">
                                  </td>
                                </tr>
                                <!-- end space -->

                              </tbody></table>
                              <!-- end footer -->
                            </td>
                          </tr>
                        </tbody></table>
                        <!-- end footer container -->

                      </td>
                    </tr>

                    <!-- END CONTAINER  -->

                  </tbody></table>
                </td>
                </tr>
                <!--END FOOTER ​LAYOUT-->



                <!--  START FOOTER COPY RIGHT -->

                <tr>
                  <td align="center" valign="top" style="background-color:#FEBEBD;">
                    <table width="600" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color:#FEBEBD;">
                      <tbody><tr>
                        <td valign="top">
                          <table width="560" align="center" border="0" cellspacing="0" cellpadding="0" class="container" style="background-color:#FEBEBD;">

                            <!--start space height -->                      
                            <tbody><tr>
                              <td height="10"></td>
                            </tr>
                            <!--end space height --> 

                            <tr>
                              <!-- start COPY RIGHT content -->  
                              <td valign="top" style="font-size: 13px; line-height: 22px; font-family:Roboto,Open Sans, Arial,Tahoma, Helvetica, sans-serif; color:#ffffff; font-weight:300; text-align:center; ">
                               GIANI DA FIRENZE 2014 ®
                             </td>
                             <!-- end COPY RIGHT content --> 
                           </tr>

                           <!--start space height -->                      
                           <tr>
                            <td height="10"></td>
                          </tr>
                          <!--end space height --> 


                        </tbody></table>
                      </td>
                    </tr>
                  </tbody></table>
                </td>
                </tr>
                <!--  END FOOTER COPY RIGHT -->
                </table>

                </table>
                </body></html>
                """.format(
                    name=self.current_user["name"].encode("utf-8"),
                    order_id=order.id,
                    datos_facturacion=datos_facturacion,
                    datos_despacho=datos_despacho,
                    detalle_orden=detalle_orden,
                    order_total=self.money_format(order.total+order.shipping),
                    order_subtotal=self.money_format(order.subtotal),
                    order_tax=self.money_format(order.tax),
                    url_local=url_local,
                    costo_despacho=self.money_format(order.shipping))

                mensaje = sendgrid.Mail()
                mensaje.set_from("{nombre} <{mail}>"
                                 .format(
                                    nombre=self.current_user["name"],
                                    mail=self.current_user["email"]))
                mensaje.add_to(email_giani)
                mensaje.set_subject("Giani Da Firenze - Compra Nº {}"
                                    .format(order.id))
                mensaje.set_html(html)
                estado, msj = sg.send(mensaje)

                if estado != 200:
                    print msj

                if status == 200:

                    cart = Cart()
                    cart.user_id = self.current_user["id"]

                    carro = cart.GetCartByUserId()

                    for l in lista:

                        if len(carro) > 0:

                            cart.RemoveByUserId()

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

                                kardex.date = str(datetime.now().isoformat()) 
                                kardex.user = "Sistema - Reservar Producto"
                                kardex.units = l["quantity"]
                                kardex.price = producto.price

                                res_kardex = kardex.Insert()

                                if debugMode and "error" in res_kardex:
                                    print res_kardex["error"]

                                kardex.cellar_identifier = id_bodega_reserva
                                kardex.operation_type = Kardex.OPERATION_MOV_IN

                                res_kardex = kardex.Insert()

                                if debugMode and "error" in res_kardex:
                                    print res_kardex["error"]

                            elif debugMode:
                                print response["error"]

                    self.render("store/success.html",
                                data=data,
                                pathSubmit=pathSubmit,
                                webpay="si",
                                detalle=lista,
                                order=order)
                else:
                    self.render(
                        "beauty_error.html",
                        message="Error al enviar correo de confirmación, {}"
                                .format(msg))

        except:

            self.render("store/failure.html",
                        TBK_ID_SESION=TBK_ID_SESION,
                        TBK_ORDEN_COMPRA=TBK_ORDEN_COMPRA,
                        PATHSUBMIT=pathSubmit)

        # self.render("store/success.html",
        #               data=data,
        #               pathSubmit=pathSubmit, 
        #               webpay="si")


class FracasoHandler(BaseHandler):

    def post(self):

        PATHSUBMIT = url_local
        TBK_ID_SESION = self.get_argument("TBK_ID_SESION","")
        TBK_ORDEN_COMPRA = self.get_argument("TBK_ORDEN_COMPRA","")

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

        client = Client(url='http://b2b.correos.cl:8008/ServicioTarificadorPersonasExterno/cch/ws/tarificacion/externo/implementacion/ServicioExternoTarificadorPersonas.asmx?WSDL')

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
        self.render( "aboutus.html" )


class HistoryHandler(BaseHandler):

    def get(self):
        self.render( "history.html" )


class ConditionsHandler(BaseHandler):

    def get(self):
        self.render( "conditions.html" )


class FaqHandler(BaseHandler):

    def get(self):
        self.render( "faq.html" )


class UserHandler(BaseHandler):

    def get(self):
        self.render( "user.html" )
