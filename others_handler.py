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
        segundo_transaccion = TBK_HORA_TRANSACCION[5:6]

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

        self.render("exito.html",data=data,pathSubmit=pathSubmit)

