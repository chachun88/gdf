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

from globals import email_giani

import sendgrid

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
        TBK_ORDEN_COMPRA = self.get_argument("TBK_ORDEN_COMPRA","")
        TBK_ID_SESION = self.get_argument("TBK_ID_SESION","")
        TBK_URL_EXITO = self.get_argument("TBK_URL_EXITO","")
        TBK_URL_FRACASO = self.get_argument("TBK_URL_FRACASO","")

        myPath = "/var/www/giani.ondev/webpay/dato{}.log".format(TBK_ID_SESION)

        f = open(myPath, "w+");
        linea = "{};{}".format(TBK_MONTO,TBK_ORDEN_COMPRA)
        f.write(linea);
        f.close();

        data = {
        "TBK_TIPO_TRANSACCION":TBK_TIPO_TRANSACCION,
        "TBK_MONTO":TBK_MONTO,
        "TBK_ORDEN_COMPRA":TBK_ORDEN_COMPRA,
        "TBK_ID_SESION":TBK_ID_SESION,
        "TBK_URL_EXITO":TBK_URL_EXITO,
        "TBK_URL_FRACASO":TBK_URL_FRACASO
        }

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


        if acepta:
            # print "si acepto"
            self.write("ACEPTADO")
        else:
            # print "no acepto"
            self.write("RECHAZADO")

class ExitoHandler(BaseHandler):

    def get(self):

        TBK_ID_SESION = self.get_argument("TBK_ID_SESION","1")
        TBK_ORDEN_COMPRA = self.get_argument("TBK_ORDEN_COMPRA","1")

        myPath = "/var/www/giani.ondev/webpay/MAC01Normal{}.txt".format(TBK_ID_SESION)
        pathSubmit = "http://giani.ondev.today"

        f = open(myPath,"r")
        linea = ""

        for l in f:
            if l.strip() != "":
                linea = l

        f.close()

        print urlparse.parse_qs(linea)

        # detalle = linea.split("&")

        # TBK_ORDEN_COMPRA = detalle[0].split("=");
        # TBK_TIPO_TRANSACCION = detalle[1].split("=");
        # TBK_RESPUESTA = detalle[2].split("=");
        # TBK_MONTO = detalle[3].split("=");
        # TBK_CODIGO_AUTORIZACION = detalle[4].split("=");
        # TBK_FINAL_NUMERO_TARJETA = detalle[5].split("=");
        # TBK_FECHA_CONTABLE = detalle[6].split("=");
        # TBK_FECHA_TRANSACCION = detalle[7].split("=");
        # TBK_HORA_TRANSACCION = detalle[8].split("=");
        # TBK_ID_TRANSACCION = detalle[10].split("=");
        # TBK_TIPO_PAGO = detalle[11].split("=");
        # TBK_NUMERO_CUOTAS = detalle[12].split("=");
        # TBK_MAC = detalle[13].split("=");
        # TBK_FECHA_CONTABLE = 


# //Rescate de los valores informados por transbank
# $fic = fopen($myPath, "r");
# $linea = fgets($fic);
# fclose($fic);
# $detalle = explode("&", $linea);
# $TBK_ORDEN_COMPRA = explode("=", $detalle[0]);
# $TBK_TIPO_TRANSACCION = explode("=", $detalle[1]);
# $TBK_RESPUESTA = explode("=", $detalle[2]);
# $TBK_MONTO = explode("=", $detalle[3]);
# $TBK_CODIGO_AUTORIZACION = explode("=", $detalle[4]);
# $TBK_FINAL_NUMERO_TARJETA = explode("=", $detalle[5]);
# $TBK_FECHA_CONTABLE = explode("=", $detalle[6]);
# $TBK_FECHA_TRANSACCION = explode("=", $detalle[7]);
# $TBK_HORA_TRANSACCION = explode("=", $detalle[8]);
# $TBK_ID_TRANSACCION = explode("=", $detalle[10]);
# $TBK_TIPO_PAGO = explode("=", $detalle[11]);
# $TBK_NUMERO_CUOTAS = explode("=", $detalle[12]);
# $TBK_MAC = explode("=", $detalle[13]);
# $TBK_FECHA_CONTABLE[1] = substr($TBK_FECHA_CONTABLE[1], 2, 2) . "-
# " . substr($TBK_FECHA_CONTABLE[1], 0, 2);
# $TBK_FECHA_TRANSACCION[1] = substr($TBK_FECHA_TRANSACCION[1], 2, 2) . "-
# " . substr($TBK_FECHA_TRANSACCION[1], 0, 2);
# $TBK_HORA_TRANSACCION[1] = substr($TBK_HORA_TRANSACCION[1], 0, 2).":".substr($TBK_HORA_TRANSACCION[1], 2, 2).":" . substr($TBK_HORA_TRANSACCION[1], 4, 2);
# ?>


