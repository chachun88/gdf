#!/usr/bin/python
# -*- coding: UTF-8 -*-
'''
Created on 25/02/2013

@author: Yi Chun
'''
import tornado.web
from tornado.options import options
from globals import url_bodega, url_local, url_cgi
import locale
import os
import unicodedata
import re

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
        # lpsetCurrentLang("en", self)

    def get_current_user(self):
        user_json = self.get_secure_cookie("user_giani")        
        if user_json:
            return tornado.escape.json_decode(user_json)
        else:
            return None

    def canonical_url(self, url):

        _url = ""

        # pattern = re.compile(r"[^a-zA-Z\d_]+")

        _url = self.strip_accents(url).encode("utf-8")
        _url = _url.replace(" ","_")

        # _url = re.sub(pattern,"",_url)

        return _url

    def strip_accents(self, s):
        _s = s.decode("utf-8")
        return ''.join(c for c in unicodedata.normalize('NFD', _s) if unicodedata.category(c) != 'Mn')

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

    @staticmethod
    def money_format(value):

        if os.name == "posix":
            locale.setlocale( locale.LC_NUMERIC, 'es_ES.UTF-8' )
        elif os.name == "nt":
            locale.setlocale( locale.LC_NUMERIC, 'Spanish_Spain.1252' )
        return locale.format('%d', value, True)

    @property
    def next(self):
        return self.get_argument("next", "/")

    def render(self, template_name ,**kwargs):

        # kwargs["lptranslate"] = lptranslate
        kwargs["truncate_decimal"] = self.truncate_decimal
        kwargs["canonical_url"] = self.canonical_url
        kwargs["nxt"] = self.get_argument("next", "/")
        kwargs["facebook_api_key"] = options.facebook_api_key
        kwargs["current_user"] = self.get_current_user()
        kwargs["url_bodega"] = url_bodega
        kwargs["url_local"] = url_local
        kwargs["url_cgi"] = url_cgi
        kwargs["money_format"] = self.money_format

        tornado.web.RequestHandler.render(self, template_name, **kwargs)

"""
Script para la validación de RUN Chileno.
@author: felcontreras@gmail.com
"""


def filtra(rut):
    """
    Esta funcion cumple el trabajo de filtrar el RUN.
    Omitiendo asi los puntos (.) y Guiones (-) y cualquier otro caracter
    que no incluya la variable 'caracteres'.
    """
    caracteres = "1234567890k"
    rutx = ""
    for cambio in rut.lower():
        if cambio in caracteres:
            rutx += cambio
    return rutx


def valida(rut):
    """
    Esta funcion cumple el trabajo de realizar la logica de negocio,
    ya sea matematica como logica.
    """
    rfiltro = filtra(rut)
    rutx = str(rfiltro[0:len(rfiltro)-1])
    digito = str(rfiltro[-1])
    multiplo = 2
    total = 0

    for reverso in reversed(rutx):
        total += int(reverso) * multiplo
        if multiplo == 7:
            multiplo = 2
        else:
            multiplo += 1
        modulus = total % 11
        verificador = 11 - modulus
        if verificador == 10:
            div = "k"
        elif verificador == 11:
            div = "0"
        else:
            if verificador < 10:
                div = verificador

    if str(div) == str(digito):
        return True
    else:
        return False

def isEmailValid(email):

    pattern = r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)"

    return bool(re.match(pattern, email))
