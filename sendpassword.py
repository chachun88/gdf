#!/usr/bin/python
# -*- coding: UTF-8 -*-

'''
Created on 25/02/2013

@author: Yi Chun
'''
from basehandler import BaseHandler
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from tornado.options import options
from random import randrange
import hashlib
from tornado.options import define, options

from globals import url_local
# from loadingplay.multilang.lang import lploadLanguage, lpautoSelectCurrentLang,\
#     lptranslate, lpsetCurrentLang

class EnviarClaveHandler(BaseHandler):
    def post(self):
        email = self.get_argument("email")
        if(len(email) > 0):
            usuario = self.db.user.find_one({"mail":email,"tipo":"registrado"})
            if usuario:
                clave = str(randrange(100))
                clave = hashlib.md5(clave).hexdigest()[:6]
                self.db.user.update({"_id":usuario["_id"]},{"$set":{"password":clave}})
                
                # if lptranslate("lang") == "es":
                Email(usuario["mail"], str(usuario["_id"]), clave)
                # elif lptranslate("lang") == "en":
                #     EmailEn(usuario["mail"], str(usuario["_id"]), clave)
                    
                self.redirect("/")
            else:
                self.write("Usuario no se encuentra registrado")
        else:
            self.write("Ingrese email por favor")
            
def Email(to, userid, clave):
      
    fromaddr = options.email  
    toaddrs = to  
    msg = MIMEMultipart('alternative')
    msg['Subject'] = "Restablecimiento de clave de la cuenta Giani da Firenze"
    msg['From'] = "Giani da Firenze " + "<" + fromaddr + ">"
    msg['To'] = toaddrs  
      
      
    # Credentials (if needed)  
    username = options.user  
    password = options.password
    
    text = "Hola, tu nueva clave es: " + clave + "\n por favor ingresa aqui para reestablecer tu clave : " + url_local + "/auth/nuevaclave/" + userid
    html = "<html>"
    html += "<head></head>"
    html += "<body>"
    html += "<p>Hola,<br><br>"
    html += "Cambiar tu contraseña es simple. Por favor usa el siguiente link<br/> <a href=\"" + url_local + "/auth/nuevaclave/" + userid +"\">"+url_local+"/auth/nuevaclave/" + userid +"</a><br/><br/>"
    html += "Contraseña antigua : "
    html += clave
    html += "<br><br/>"
    html += "</p>"
    html += "<p>Gracias,</p>"
    html += "<p>El Equipo Giani da Firenze</p>"
    html += "</body>"
    html += "</html>"

    # Record the MIME types of both parts - text/plain and text/html.
    part1 = MIMEText(text, 'plain')
    part2 = MIMEText(html, 'html')

    # Attach parts into message container.
    # According to RFC 2046, the last part of a multipart message, in this case
    # the HTML message, is best and preferred.
    msg.attach(part1)
    msg.attach(part2)  
      
    # The actual mail send  
    server = smtplib.SMTP('smtp.gmail.com:587')  
    server.starttls()  
    server.login(username, password)  
    server.sendmail(fromaddr, toaddrs, msg.as_string())  
    server.quit()
    
def EmailEn(to, userid, clave):
      
    fromaddr = options.email  
    toaddrs = to  
    msg = MIMEMultipart('alternative')
    msg['Subject'] = "Giani da Firenze account password restoration"
    msg['From'] = "Giani da Firenze " + "<" + fromaddr + ">"
    msg['To'] = toaddrs  
      
      
    # Credentials (if needed)  
    username = options.user  
    password = options.password
    
    text = lptranslate("hi") + ", your new password is: " + clave + "\n Changing your password is simple. Please use the link below : http://challenges.global-nomad.org/nuevaclave/" + userid
    html = "<html>"
    html += "<head></head>"
    html += "<body>"
    html += "<p>" + lptranslate("hi") + ",<br><br>"
    html += "Changing your password is simple. Please use the link below<br/> <a href=\"http://challenges.global-nomad.org/nuevaclave/" + userid +"\">http://challenges.global-nomad.org/nuevaclave/" + userid +"</a><br/><br/>"
    html += lptranslate("registro_contrasena") + ":"
    html += clave
    html += "<br><br/>"
    html += "</p>"
    html += "<p>Thank you,</p>"
    html += "<p>The Giani da Firenze Team</p>"
    html += "</body>"
    html += "</html>"

    # Record the MIME types of both parts - text/plain and text/html.
    part1 = MIMEText(text, 'plain')
    part2 = MIMEText(html, 'html')

    # Attach parts into message container.
    # According to RFC 2046, the last part of a multipart message, in this case
    # the HTML message, is best and preferred.
    msg.attach(part1)
    msg.attach(part2)  
      
    # The actual mail send  
    server = smtplib.SMTP('smtp.gmail.com:587')  
    server.starttls()  
    server.login(username, password)  
    server.sendmail(fromaddr, toaddrs, msg.as_string())  
    server.quit()