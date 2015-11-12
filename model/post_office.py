#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basemodel import BaseModel
import psycopg2
import psycopg2.extras


class PostOffice(BaseModel):

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value

    def __init__(self):
        BaseModel.__init__(self)
        self._name = ''
        self.table = 'Post_Office'

    def InitById(self, _id):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        try:
            cur.execute('''select * from "Post_Office" where id = %(id)s''', {"id":_id})
            post_offices = cur.fetchone()
            self.id = post_offices["id"]
            self.name = post_offices["name"]
            return self.ShowSuccessMessage(post_offices)
        except Exception,e:
            return self.ShowError(str(e))
        finally:
            cur.close()
            self.connection.close()

    def List(self):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        try:
            cur.execute('''select * from "Post_Office"''')
            post_offices = cur.fetchall()
            return self.ShowSuccessMessage(post_offices)
        except Exception,e:
            return self.ShowError(str(e))
        finally:
            cur.close()
            self.connection.close()

    def ListOnlyWithShippingCost(self):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        try:
            cur.execute('''select po.* from "Post_Office" po inner join "Shipping" s on s.post_office_id = po.id''')
            post_offices = cur.fetchall()
            return self.ShowSuccessMessage(post_offices)
        except Exception,e:
            return self.ShowError(str(e))
        finally:
            cur.close()
            self.connection.close()
