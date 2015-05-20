from lp.tools.scriptloader import ScriptLoader
from config import *
from lp.globals import host_name

sl = ScriptLoader()
sl.dbname = ONTEST_DB_NAME
sl.user = ONTEST_USER
sl.host = ONTEST_HOST
sl.password = ONTEST_PASSWORD
sl.script_file = "dbscripts/schema.sql"

if host_name == "MacBook-Pro.local":
    sl.delete_old("postgres", "postgres", "12345")
else:
    sl.delete_old()
sl.execute()
