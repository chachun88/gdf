#!/usr/bin/python
# -*- coding: UTF-8 -*-

import unittest
from lp.model.basemodel import BaseModel
from model.user import User, UserType


class TestUser(unittest.TestCase):

    def resetDB(self):
        BaseModel.execute_query( 'TRUNCATE "User" CASCADE;' )
        BaseModel.execute_query( 'TRUNCATE "User_Types" CASCADE')

        BaseModel.execute_query( 'ALTER SEQUENCE "User_id_seq" RESTART WITH 1')
        BaseModel.execute_query( 'ALTER SEQUENCE "User_Types_id_seq" RESTART WITH 1')

    def setUp(self):
        self.resetDB()
        BaseModel.execute_query( '''INSERT INTO "User_Types" (id, name) VALUES (1, 'Cliente')''' )

    def tearDown(self):
        self.resetDB()

    def test_register_user(self):

        # create a new user instance
        user = User()
        user.name = "foo"
        user.email = "foo@foo"
        user.password = "1234"
        user.user_type = UserType.CLIENTE
        user.permissions = []
        user.rut = ''

        # save user on database
        message = user.Save()

        assert "success" in message

        # init just created user
        other_instance = (User()).InitById(1)

        assert "error" not in other_instance
        assert other_instance["name"] == "foo"

        # try to loin after creating user
        response_obj = user.Login( user.email, user.password )

        # must contains a success message
        assert "success" in response_obj
