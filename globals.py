''' 
CONFIG
'''
from tornado.options import define, options

class Enviroment(object):
	LOCAL = 1
	ONDEV = 2
	ONTEST = 3
	PRODUCTION = 4

enviroment = Enviroment.LOCAL


PORT=8502
DEBUG_PORT=8502

debugMode = True 
port = 0
url_bodega = ""
url_local = ""
cellar_id = 5


facebook_api_key = ""
facebook_secret = ""



if enviroment == Enviroment.LOCAL:
	port = DEBUG_PORT
	url_bodega = "http://giani.loadingplay.com"
	url_local = "http://localhost:8502"

	facebook_api_key = "839778829389863"
	facebook_secret = "5e533cd56091707c73e88c2113ffb13d"

elif enviroment == Enviroment.ONDEV:
	port = DEBUG_PORT
	url_bodega = "http://giani.loadingplay.com"
	url_local = "http://giani.ondev.today"

	facebook_api_key = "839753546059058"
	facebook_secret = "26bbd6af2dad046a3dd17b14ab81da67"

	# define("facebook_api_key", help="your Facebook application API key", default="839753546059058")
	# define("facebook_secret", help="your Facebook application secret", default="26bbd6af2dad046a3dd17b14ab81da67")

elif enviroment == Enviroment.ONTEST:
	port = DEBUG_PORT
	url_bodega = "http://giani.loadingplay.com"
	url_local = "http://giani.ondev.today"

	facebook_api_key = "839753546059058"
	facebook_secret = "26bbd6af2dad046a3dd17b14ab81da67"

	# define("facebook_api_key", help="your Facebook application API key", default="839753546059058")
	# define("facebook_secret", help="your Facebook application secret", default="26bbd6af2dad046a3dd17b14ab81da67")

elif enviroment == Enviroment.PRODUCTION:
	port = PORT
	url_bodega = "http://giani.loadingplay.com"
	url_local = "http://giani.ondev.today"

	# define("facebook_api_key", help="your Facebook application API key", default="839753546059058")
	# define("facebook_secret", help="your Facebook application secret", default="26bbd6af2dad046a3dd17b14ab81da67")



define("facebook_api_key", help="your Facebook application API key", default=facebook_api_key)
define("facebook_secret", help="your Facebook application secret", default=facebook_secret)

define("port", default=port, help="run on the given port", type=int)
define("protocol", default="https", help="run on the given port", type=str)

define("email", help="remitente email", default="ricardo.silva.16761@gmail.com")
define("user", help="cuenta usuario remitente", default="ricardo.silva.16761@gmail.com")
define("password", help="clave remitente", default="yichunTAM")


print "Debug Mode:{} Port:{}".format(debugMode,port)