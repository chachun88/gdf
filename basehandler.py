'''
Created on 25/02/2013

@author: Yi Chun
'''
import tornado.web
from globals import url_bodega
import locale
# from loadingplay.multilang.lang import lploadLanguage, lpautoSelectCurrentLang,\
#     lptranslate, lpsetCurrentLang

class BaseHandler(tornado.web.RequestHandler):
    @property
    def db(self):
        return self.application.db
    
    def __init__(self, application, request, **kwargs):
        tornado.web.RequestHandler.__init__(self, application, request, **kwargs)
        
        # detecto el lenguage del navegador del usuario
        # lpautoSelectCurrentLang(self)
        #lpsetCurrentLang("en", self)
    
    def get_current_user(self):
        user_json = self.get_secure_cookie("user_giani")        
        if user_json:
            return tornado.escape.json_decode(user_json)
        else:
            return None

    def canonical_url(self,url):

        _url = ""

        _url = url.replace(" ","-")

        return _url


    def truncate_decimal(self, decimal):

        _int = 0

        # print type(decimal)

        if type(decimal) is str:
            _float = float(decimal)
            _int = int(_float)
        elif type(decimal) is float:
            _int = int(decimal)
        elif type(decimal) is unicode:
            _string = decimal.encode("utf-8")
            _float = float(_string)
            _int = int(_float)

        
        return _int

    def money_format(self, value):

        locale.setlocale( locale.LC_NUMERIC, '' )
        return locale.format('%d', value, True)

    def render(self, template_name ,**kwargs):
       # kwargs["lptranslate"] = lptranslate
       kwargs["truncate_decimal"] = self.truncate_decimal
       kwargs["canonical_url"] = self.canonical_url
       # kwargs["admin_url"] = admin_url
       kwargs["current_user"] = self.get_current_user()
       kwargs["url_bodega"] = url_bodega
       kwargs["money_format"] = self.money_format
       tornado.web.RequestHandler.render(self, template_name, **kwargs)