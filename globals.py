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


if enviroment == Enviroment.LOCAL:

    print "local enviroment"

    port = DEBUG_PORT
    url_bodega = "http://giani.gianidafirenze.cl"
    url_local = "http://localhost:8502"
    url_cgi = "http://cgiani.ondev.today"

    facebook_api_key = "839778829389863"
    facebook_secret = "5e533cd56091707c73e88c2113ffb13d"

    email_giani = "yi.neko@gmail.com"

    project_path = "/var/www/giani.ondev/"
    cgi_path = "/var/www/cgiani.gianidafirenze.cl/"

elif enviroment == Enviroment.ONDEV:
    port = DEBUG_PORT
    url_bodega = "http://bgiani.ondev.today"
    url_local = "http://giani.ondev.today"
    url_cgi = "http://cgiani.ondev.today"

    facebook_api_key = "839753546059058"
    facebook_secret = "26bbd6af2dad046a3dd17b14ab81da67"

    email_giani = "contacto@gianidafirenze.cl"

    project_path = "/var/www/giani.ondev/"
    cgi_path = "/var/www/cgiani.gianidafirenze.cl/"

elif enviroment == Enviroment.ONTEST:
    port = DEBUG_PORT
    url_bodega = "http://bgiani.gianidafirenze.cl"
    url_local = "http://giani.ondev.today"
    url_cgi = "http://cgiani.ondev.today"

    facebook_api_key = "940357995998612"
    facebook_secret = "cf2e025731e33f686bc8c37493c7ee74"

    email_giani = "contacto@gianidafirenze.cl"

    project_path = "/var/www/giani.ondev/"
    cgi_path = "/var/www/cgiani.gianidafirenze.cl/"


elif enviroment == Enviroment.PRODUCTION:
    port = PORT
    url_bodega = "http://bgiani.gianidafirenze.cl"
    url_local = "http://giani.gianidafirenze.cl"
    url_cgi = "http://cgiani.gianidafirenze.cl"

    facebook_api_key = "839753546059058"
    facebook_secret = "26bbd6af2dad046a3dd17b14ab81da67"

    email_giani = "contacto@gianidafirenze.cl"

    project_path = "/var/www/gianidafirenze.cl/giani/"
    cgi_path = "/var/www/c.gianidafirenze.cl/cgiani.ondev/"


define("facebook_api_key", help="your Facebook application API key", default=facebook_api_key)
define("facebook_secret", help="your Facebook application secret", default=facebook_secret)

define("port", default=port, help="run on the given port", type=int)
define("protocol", default="https", help="run on the given port", type=str)

define("email", help="remitente email", default="info@gianidafirenze.cl")
define("user", help="cuenta usuario remitente", default="info@gianidafirenze.cl")
define("password", help="clave remitente", default="loadingplay007")

print "Debug Mode:{} Port:{}".format(debugMode,port)
