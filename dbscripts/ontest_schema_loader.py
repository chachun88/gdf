from lp.tools.scriptloader import ScriptLoader
from config import *
from lp.globals import *

sl = ScriptLoader()
sl.dbname = ONTEST_DB_NAME
sl.user = ONTEST_USER
sl.host = ONTEST_HOST
sl.password = ONTEST_PASSWORD
sl.script_file = "dbscripts/schema.sql"

if host_name == "MacBook-Pro.local":
    sl.delete_old(database="postgres", user="postgres", password="12345")
else:
    sl.delete_old(database="giani", user="yichun", password="chachun88")
sl.execute()
