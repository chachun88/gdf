'''
Created on 25/02/2013

@author: Yi Chun
'''
import tornado.web
from loadingplay.multilang.lang import lploadLanguage, lpautoSelectCurrentLang,\
    lptranslate, lpsetCurrentLang
from globals import admin_url
import re

class BaseHandler(tornado.web.RequestHandler):
    @property
    def db(self):
        return self.application.db
    
    def __init__(self, application, request, **kwargs):
        tornado.web.RequestHandler.__init__(self, application, request, **kwargs)
        
        # detecto el lenguage del navegador del usuario
        lpautoSelectCurrentLang(self)
        #lpsetCurrentLang("en", self)
    
    def get_current_user(self):
        user_json = self.get_secure_cookie("user")        
        if not user_json: return None
        return tornado.escape.json_decode(user_json)

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

    def string_to_hours(self, cadena=""):

        _cadena = cadena.strip()

        horas = 0
        minutos = 0

        regex_tiempo = re.compile(r"((?P<horas>\d+)h)*\s*((?P<minutos>\d+)m)*",re.IGNORECASE)
        match_tiempo = regex_tiempo.match(_cadena)

        if match_tiempo:
            horas = match_tiempo.group("horas")
            minutos = match_tiempo.group("minutos")
            if horas is None:
                horas = 0
            if minutos is None:
                minutos = 0

        total_minutos = int(horas) * 60 + int(minutos)
        total_horas = float(total_minutos)/60
        total_horas = round(total_horas,2)

        if total_horas < 1:
            return '''{}<span class="tamano-hora" >m</span>'''.format(total_minutos)

        return '''{}<span class="tamano-hora" >h</span>'''.format(total_horas)

    def render(self, template_name ,**kwargs):
       kwargs["lptranslate"] = lptranslate
       kwargs["truncate_decimal"] = self.truncate_decimal
       kwargs["canonical_url"] = self.canonical_url
       kwargs["admin_url"] = admin_url
       kwargs["string_to_hours"] = self.string_to_hours
       tornado.web.RequestHandler.render(self, template_name, **kwargs)