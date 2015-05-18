#!/usr/bin/python
# -*- coding: UTF-8 -*-
import sendgrid
from globals import sendgrid_pass, sendgrid_user, email_giani, to_giani


class SendEmail():

    def main(self):

        sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
        mensaje = sendgrid.Mail()
        mensaje.set_from("{nombre} <{mail}>".format(nombre='Test Yi',mail=["yichun212@gmail.com","yi.neko@gmail.com"]))
        mensaje.add_to(to_giani)
        mensaje.set_subject("test email invalido")
        mensaje.set_html("holaaaaa")
        status, msg = sg.send(mensaje)
        print "{} {}".format(status, msg)

send_email = SendEmail()
send_email.main()
