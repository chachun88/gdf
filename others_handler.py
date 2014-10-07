#!/usr/bin/python
# -*- coding: UTF-8 -*-

import os.path

import tornado.auth
import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
from tornado.options import define, options
from basehandler import BaseHandler

from model.kardex import Kardex
from datetime import datetime

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

        # f=open("dato201410071642.log","w")
        # f.write("machacando\n")
        # f.close()

        self.render("testpago.html")

class XtCompraHandler(BaseHandler):

    def get(self):


        TBK_RESPUESTA=self.get_argument("TBK_RESPUESTA")
        TBK_ORDEN_COMPRA=self.get_argument("TBK_ORDEN_COMPRA")
        TBK_MONTO=self.get_argument("TBK_MONTO")
        TBK_ID_SESION=self.get_argument("TBK_ID_SESION")

        myPath = "/var/www/giani.ondev/webpay/dato{}.log".format(TBK_ID_SESION)

        filename_txt = "/var/www/giani.ondev/webpay/MAC01Normal{}.txt".format(TBK_ID_SESION)

        cmdline = "/var/www/cgiani.ondev/cgi-bin/tbk_check_mac.cgi {}".format(filename_txt)


        acepta=False;

        f=open(myPath,"r")

        linea = f.readline()

        while linea != "":
            linea = f.readline()

        f.close()

        detalle=linea.split(";")

        ''''hasta aqui llego la conversion'''

        if (count($detalle)>=1){
        $monto=$detalle[0];
        $ordenCompra=$detalle[1];
        }

        //guarda los datos del post uno a uno en archivo para la ejecución del MAC
        $fp=fopen($filename_txt,"wt");
        while(list($key, $val)=each($_POST)){
        fwrite($fp, "$key=$val&");
        }
        fclose($fp);
        //Validación de respuesta de Transbank, solo si es 0 continua con la pagina de cierre
        if($TBK_RESPUESTA=="0"){ $acepta=true; } else { $acepta=false; }
        //validación de monto y Orden de compra
        if ($TBK_MONTO==$monto && $TBK_ORDEN_COMPRA==$ordenCompra && $acepta==true){ $acepta=true;}
        else{ $acepta=false;}
        //Validación MAC
        if ($acepta==true){
        exec ($cmdline, $result, $retint);
        if ($result [0] =="CORRECTO") $acepta=true; else $acepta=false;
        }
        log_me("XT_COMPRA","XT_COMPRA");
        ?>
        <html>

        <?php if ($acepta==true){?>
        ACEPTADO
        <?php } else {?>
        RECHAZADO
        <?php }?>
        </html>

        self.write("ACEPTADO")
        
