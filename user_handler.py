#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basehandler import BaseHandler

# libreria prescindible
from bson import json_util

from model.user import User


class AddAnonimousHandler(BaseHandler):

    def get(self):

        user_id = int(self.get_argument("user_id",0))

        user = User()

        if user_id != 0:

            exists_response = user.Exist('',user_id)

            if "success" in exists_response:
                existe = exists_response["success"]

                if not existe:
                    response_obj = user.Save()
                    self.write(json_util.dumps(response_obj))
                else:
                    self.write(json_util.dumps({"success":user_id}))

            else:
                self.write(json_util.dumps(exists_response))

        else:

            if self.current_user:
                self.write(json_util.dumps({"success":self.current_user["id"]}))
            else:
                response_obj = user.Save()
                self.write(json_util.dumps(response_obj))


class UserExistHandler(BaseHandler):

    def get(self):

        user_id = self.get_argument("user_id","")

        if user_id != "":
            user = User()
            response_obj = user.Exist('',user_id)
            if "success" in response_obj:
                if response_obj["success"]:
                    self.write("true")
                else:
                    self.write("false")
            else:
                self.write("false")
        else:
            self.write("false")
