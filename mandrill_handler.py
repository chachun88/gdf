#!/usr/bin/python
# -*- coding: UTF-8 -*-

import mandrill
import sendgrid
from bson import json_util
from globals import *

try:
    subject = "Giani Da Firenze - Compra Nº {} Procesando".format(1)
    mandrill_client = mandrill.Mandrill(mailchimp_api_key)
    mandrill_client.templates.update(processing_order_template, 
                                     subject=subject)
    info = mandrill_client.templates.info(processing_order_template)

    template_content = [{"name": "", "content": info["code"]}]
    merge_vars = [
        {"name": "name", "content": 'nombre'},
        {"name": "order_id", "content": 1},
        {"name": "company", "content": "Giani Da Firenze"},
        {"name": "current_year", "content": 2015},
        {"name": "list_address_html", "content": 'contacto@gianidafirenze.cl'}
    ]

    html = mandrill_client.templates.render(processing_order_template, template_content, merge_vars)
    sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
    mensaje = sendgrid.Mail()
    mensaje.set_from("{nombre} <{mail}>".format(nombre=info["from_name"], 
                                                mail=info["from_email"]))
    mensaje.add_to('yichun212@gmail.com')
    mensaje.set_subject(info["subject"])
    mensaje.set_html(html["html"])
    status, msg = sg.send(mensaje)
    print msg
except Exception, e:
    print 'enviando correo procesamiento, {}'.format(str(e))

# mandrill_client = mandrill.Mandrill(mailchimp_api_key)
# mandrill_client.templates.update("test", 
#                                 subject="Giani Da Firenze - Compra Nº {}".format(1))
# info = mandrill_client.templates.info("test")
# template_content = [{"name": "footer", "content": "<p>domethin *|NAME|*</p>"}]
# merge_vars = [{"name": "name", "content": "Wan Yu Lin"}]
# html = mandrill_client.templates.render("test", template_content, merge_vars)
# # print '-----------------------'
# # print json_util.dumps(info, indent=4)
# # print '-----------------------'

# # print mandrill_client.webhooks.list()

# sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
# mensaje = sendgrid.Mail()
# mensaje.set_from(
#     "{nombre} <{mail}>".format(nombre=info["from_name"], mail=info["from_email"]))
# mensaje.add_to('yichun212@gmail.com')
# mensaje.set_subject(info["subject"])
# mensaje.set_html(html["html"])
# status, msg = sg.send(mensaje)

# print msg

# c32c7b24697647260dc49efa85d9ea55-us5

# https://us5.api.mailchimp.com/3.0/lists?apikey=c32c7b24697647260dc49efa85d9ea55

# from mailchimp import Mailchimp
# mailchimp = Mailchimp('c32c7b24697647260dc49efa85d9ea55-us5')
# mailchimp.campaigns.list
