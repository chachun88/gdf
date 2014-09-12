''' 
CONFIG
'''

PORT=8502
DEBUG_PORT=8502

debugMode = True 
port = 0
url_bodega = ""

if (debugMode):
    port = DEBUG_PORT
    url_bodega = "http://giani.loadingplay.com"
else:
    port = PORT
    url_bodega = "http://giani.loadingplay.com"

print "Debug Mode:{} Port:{}".format(debugMode,port)