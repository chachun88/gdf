#!/usr/bin/python
# -*- coding: UTF-8 -*-

import unittest
from config import *
from tornado.options import define
from lp.globals import Enviroment


# define("protocol", default="https", help="run on the given port", type=str)

define("enviroment", default=Enviroment.ONTEST, type=str)
define("db_name", default=ONTEST_DB_NAME, help="", type=str)
define("db_user", default=ONTEST_USER, help="", type=str)
define("db_host", default=ONTEST_HOST, help="", type=str)
define("db_password", default=ONTEST_PASSWORD, help="", type=str)

import dbscripts.ontest_schema_loader
from handler_kardex_test import TestStock
# from model_user_test import TestUser

if __name__ == '__main__': 
    unittest.main() 