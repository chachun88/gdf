#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basemodel import BaseModel
import psycopg2
import psycopg2.extras
# from bson.objectid import ObjectId

class City(BaseModel):
    def __init__(self):
        BaseModel.__init__(self)
        self._name = ''
        self.table = 'City'

    @property
    def name(self):
        return self._name
    @name.setter
    def name(self, value):
        self._name = value


    def List(self):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        try:
            cur.execute('''select * from "City"''')
            cities = cur.fetchall()
            return self.ShowSuccessMessage(cities)
        except Exception,e:
            return self.ShowError(str(e))
        finally:
            cur.close()
            self.connection.close()

    def Save(self):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        query = '''select id from "City" where lower(name) = lower(%(name)s)'''
        parameters = {
        "name":self.name
        }

        try:
            cur.execute(query,parameters)
            if cur.rowcount > 0:
                self.id = cur.fetchone()["id"]
                return self.ShowError("Ciudad ya existe en la lista")
        except Exception,e:
            return self.ShowError(str(e))
        finally:
            self.connection.close()
            cur.close()

        if self.id != "":

            cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
            query = '''update "City" set name = %(name)s where id = %(id)s'''
            parameters = {
            "id":self.id,
            "name":self.name
            }

            try:
                cur.execute(query,parameters)
                self.connection.commit()
                return self.ShowSuccessMessage(self.id)
            except Exception,e:
                return self.ShowError(str(e))
            finally:
                self.connection.close()
                cur.close()

        else:

            cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
            query = '''insert into "City" (name) values (%(name)s) returning id'''
            parameters = {
            "name":self.name
            }

            try:
                cur.execute(query,parameters)
                self.id = cur.fetchone()["id"]
                self.connection.commit()
                return self.ShowSuccessMessage(self.id)
            except Exception,e:
                return self.ShowError(str(e))
            finally:
                self.connection.close()
                cur.close()

    def InitById(self):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        query = '''select * from "City" where id = %(id)s'''
        parameters = {
        "id":self.id
        }

        try:
            cur.execute(query,parameters)
            ciudad = cur.fetchone()
            return self.ShowSuccessMessage(ciudad)
        except Exception,e:
            return self.ShowError(str(e))
        finally:
            self.connection.close()
            cur.close()


    def ListByFromCityId(self):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        try:
            query = '''\
                    select distinct c.* 
                    from "City" c 
                    inner join "Shipping" s on s.to_city_id = c.id 
                    where s.from_city_id = %(from_city_id)s and s.post_office_id is null
                    order by c.name asc'''
            parameters = {
            "from_city_id":self.from_city_id
            }
            # print cur.mogrify(query,parameters)
            cur.execute(query,parameters)
            cities = cur.fetchall()
            return self.ShowSuccessMessage(cities)
        except Exception,e:
            return self.ShowError(str(e))
        finally:
            cur.close()
            self.connection.close()

    def getNameById(self, id):
        """
        Funcion que por medio del id obtiene nombre de la ciudad 
        @param {int} id El valor de esta variable corresponde a id de la ciudad
        @return {string} name Esta variable corresponde al nombre de la ciudad
        @author : Chien-Hung
        """

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        try:
            query = '''SELECT name FROM "City" WHERE id = %(id)s'''
            parameters = {
                "id": id
            }

            cur.execute(query, parameters)
            name = cur.fetchone()

            return self.ShowSuccessMessage(name)

        except Exception,e:
            return self.ShowError(str(e))

        finally:
            cur.close()
            self.connection.close()

    def getIdByName(self, name):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        query = '''select id from "City" where lower(name) = lower(%(name)s)'''
        parameters = {
            "name": name
        }

        try:
            cur.execute(query,parameters)
            if cur.rowcount > 0:
                self.id = cur.fetchone()["id"]
                return self.ShowSuccessMessage(self.id)
        except Exception,e:
            return self.ShowError(str(e))
        finally:
            self.connection.close()
            cur.close()