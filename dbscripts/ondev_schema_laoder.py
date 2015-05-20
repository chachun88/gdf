from lp.tools.scriptloader import ScriptLoader

sl = ScriptLoader()
sl.dbname = "test_giani"
sl.user = "yichun"
sl.host = "locahost"
sl.password = "chachun88"
sl.script_file = "back20150517.sql"


sl.delete_old()
sl.execute()
