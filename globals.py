''' 
CONFIG
'''

debugMode = True 

token = ""

PORT=8502
DEBUG_PORT=8502

if (debugMode):
    port = DEBUG_PORT
else:
    port = PORT

               
# connection = pymongo.Connection("mongodb://dev_bluups:loadingplay007@184.106.133.195:27017") 
if debugMode:
    connection = pymongo.Connection("198.61.180.245", 27017)   
    self.db = connection.dev_bluups
else:
    connection = pymongo.Connection("localhost", 27017)   
    self.db = connection.bluups

url = webservice_url + "/access_token?appid=100"
token = urllib.urlopen(url).read()
print token