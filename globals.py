''' 
CONFIG
'''

from tornado.options import define

import socket


host_name = socket.gethostname()


class Enviroment(object):
    LOCAL = 1
    ONDEV = 2
    ONTEST = 3
    PRODUCTION = 4

enviroment = Enviroment.LOCAL

if host_name == "development":
    enviroment = Enviroment.ONDEV
elif host_name == "production":
    enviroment = Enviroment.PRODUCTION


PORT = 8502
DEBUG_PORT = 8502

debugMode = True 
port = 0
url_bodega = ""
url_local = ""
email_giani = ""
shipping_cellar = 12
cellar_id = 5


facebook_api_key = ""
facebook_secret = ""

project_path = "/var/www/giani.ondev/"
cgi_path = "/var/www/cgiani.gianidafirenze.cl/"

sendgrid_user = 'nailuj41'
sendgrid_pass = 'Equipo_2112'
dir_image = 'uploads/images/'

email_giani = 'contacto@gianidafirenze.cl'
to_giani = ['contacto@gianidafirenze.cl']

iva = 0.19

mailchimp_api_key = 'RC57FKi_1IVqO6m46flAJQ'
processing_order_template = "test2"
payment_template_id = "ayuda-cliente-giani"

if enviroment == Enviroment.LOCAL:

    print "local enviroment"

    port = DEBUG_PORT
    url_bodega = "http://localhost:9007"
    url_local = "http://localhost:8502"
    url_cgi = "http://cgiani.ondev.today"

    facebook_api_key = "1067063349985852"
    facebook_secret = "bbf044ebf55c524f9791e0fb23db610e"

    project_path = ""
    cgi_path = "/var/www/cgiani.ondev/"
    dir_image = '../bodegas/uploads/images/'

    to_giani = ['julian@loadingplay.com','ricardo@loadingplay.com']
    email_giani = 'ricardo@loadingplay.com'

    debugMode = True

elif enviroment == Enviroment.ONDEV:
    debugMode = False
    port = DEBUG_PORT
    url_bodega = "http://bgiani.ondev.today"
    url_local = "http://giani.ondev.today"
    url_cgi = "http://cgiani.ondev.today"

    facebook_api_key = "839753546059058"
    facebook_secret = "26bbd6af2dad046a3dd17b14ab81da67"

    project_path = "/var/www/giani.ondev/"
    cgi_path = "/var/www/cgiani.ondev/"
    dir_image = '../bgiani.ondev/uploads/images/'
    to_giani = ['ricardo@loadingplay.com', 'julian@loadingplay.com']
    email_giani = 'ricardo@loadingplay.com'

elif enviroment == Enviroment.ONTEST:
    port = DEBUG_PORT
    url_bodega = "http://bgiani.gianidafirenze.cl"
    url_local = "http://giani.ondev.today"
    url_cgi = "http://cgiani.ondev.today"

    facebook_api_key = "940357995998612"
    facebook_secret = "cf2e025731e33f686bc8c37493c7ee74"

    project_path = "/var/www/giani.ondev/"
    cgi_path = "/var/www/cgiani.gianidafirenze.cl/"
    dir_image = '/var/www/bgiani.ondev/uploads/images/'
    to_giani = ['ricardo@loadingplay.com']


elif enviroment == Enviroment.PRODUCTION:
    debugMode = False
    port = PORT
    url_bodega = "http://bodegas.gianidafirenze.cl"
    url_local = "http://www.gianidafirenze.cl"
    url_cgi = "http://c.gianidafirenze.cl"

    facebook_api_key = "1067063349985852"
    facebook_secret = "bbf044ebf55c524f9791e0fb23db610e"

    project_path = "/var/www/gianidafirenze.cl/giani/"
    cgi_path = "/var/www/c.gianidafirenze.cl/cgiani.ondev/"
    dir_image = '../bodegas/uploads/images/'

    to_giani = ['contacto@gianidafirenze.cl','julian@loadingplay.com','ricardo@loadingplay.com']



define("facebook_api_key", help="your Facebook application API key", default=facebook_api_key)
define("facebook_secret", help="your Facebook application secret", default=facebook_secret)

define("port", default=port, help="run on the given port", type=int)
define("protocol", default="https", help="run on the given port", type=str)

define("email", help="remitente email", default="info@gianidafirenze.cl")
define("user", help="cuenta usuario remitente", default="info@gianidafirenze.cl")
define("password", help="clave remitente", default="loadingplay007")

print "Debug Mode:{} Port:{}".format(debugMode,port)
