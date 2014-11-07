#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basemodel import BaseModel
# from bson.objectid import ObjectId

from kardex import Kardex
from product import Product
from bson import json_util

import psycopg2
import psycopg2.extras

import time
import datetime

import re

from user import User

class Cellar(BaseModel):
    def __init__(self):
        BaseModel.__init__(self)
        self._name = ''
        self._description = ''
        self.table = 'Cellar'

    @property
    def name(self):
        return self._name 
    @name.setter
    def name(self, value):
        self._name = value

    @property
    def description(self):
        return self._description
    @description.setter
    def description(self, value):
        self._description = value

    @property
    def city_id(self):
        return self._city_id
    @city_id.setter
    def city_id(self, value):
        self._city_id = value
    

    ## override
    def Remove(self):
        # #validate if cellar still has products
        # data = self.db.kardex.find({ "cellar_identifier": self.identifier })
        # is_empty = True

        # for d in data:
        #   #detect if product exists
        #   product_data = self.db.kardex.find({"product_sku": d["product_sku"], "cellar_identifier": self.identifier}).sort("_id", -1).limit(1)

        #   for dat in product_data:
                
        #       if int(dat["balance_units"]) >=1:
        #           is_empty = False
        #   # if ( product_data.count() >= 1 ):
        #   #   ##validate
        #   #   is_empty = False
        # if (is_empty):

        #   ## remove permissions from user
        #   try:
        #       self.db.salesman.update({"permissions":self.name},{"$pull": { "permissions": self.name} }, multi=True);

        #   except Exception, e:
        #       self.ShowError(str( e ))
            
        #   return BaseModel.Remove(self)
        # else:
        #   return self.ShowError("No se puede eliminar, aún contiene productos.")

        is_empty = True

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select * from "Kardex" where cellar_id = %(cellar_id)s'''

        parametros = {
        "cellar_id":self.id
        }

        cur.execute(query,parametros)

        kardex = cur.fetchall()

        for k in kardex:

            query = '''select * from "Kardex" where product_sku = %(product_sku)s and cellar_id = %(cellar_id)s and size = %(size)s order by id desc limit 1'''

            parametros = {
            "product_sku":k["product_sku"],
            "cellar_id":self.id,
            "size":k["size"]
            }

            cur.execute(query,parametros)

            _kardex = cur.fetchone()

            if _kardex:
                if int(_kardex["balance_units"]) >=1:
                    is_empty = False

        if is_empty:
            
            query = '''update "User" set cellar_permissions = cellar_permissions - array[%(cellar_id)s]'''
            parametros = {
            "cellar_id":self.id
            }

            cur.execute(query,parametros)
            self.connection.commit()


            return BaseModel.Remove(self)

        else:
            return self.ShowError("No se puede eliminar, aún contiene productos.")


    def GetTotalUnits(self):

        

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select distinct product_sku, size from "Kardex" where cellar_id = %(id)s'''
        parametros = {
        "id":self.id
        }
        cur.execute(query,parametros)
        psku = cur.fetchall()

        kardex = Kardex()
        total_units = 0

        for p in psku:

            response = kardex.FindKardex(p["product_sku"],self.id,p["size"])

            if "success" in response:
                total_units += kardex.balance_units
            else:
                print response["error"]
            

        return int(total_units)

    def GetTotalPrice(self):
        

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select distinct product_sku, size from "Kardex" where cellar_id = %(id)s'''
        parametros = {
        "id":self.id
        }
        cur.execute(query,parametros)
        psku = cur.fetchall()

        kardex = Kardex()
        total_price = 0

        for p in psku:

            response = kardex.FindKardex(p["product_sku"],self.id,p["size"])

            if "success" in response:
                total_price += kardex.balance_total
            # else:
            #     print response["error"]

        return int(total_price)

    #@return json
    def Print(self):
        try:
            me = {"id":self.id,
                "name" : self.name,
                "description": self.description,
                "total_price": self.GetTotalPrice(),
                "total_units": self.GetTotalUnits(),
                "city_id": self.city_id}

            return me
        except Exception,e:
            # return self.ShowError("failed to print cellar, error:{}".format(e))
            pass

    @staticmethod
    def CellarExists( cellar_name ):

        # data = db.cellar.find({"name" : cellar_name })
        
        # if data.count() >= 1:
        #   return True
        # return False

        bm = BaseModel()

        cur = bm.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select * from "Cellar" where name = %(name)s limit 1'''
        parametros = {
        "name":cellar_name
        }
        cur.execute(query,parametros)
        cellar = cur.fetchone()

        if cellar:
            return True
        else:
            return False

    ## validates and save cellar, it could be validated by name
    def Save(self):

        # try:

        #   ## validate if already exists a cellar with this name
        #   data_name = self.collection.find({"name": self.name})
        #   if data_name.count() >= 1:
        #       self.identifier = str(self.collection.update(
        #           {"_id":data_name[0]["_id"]},
        #           {"$set": {
        #               "name" : self.name,
        #               "description" : self.description
        #           }}))

        #       self.InitById(str(data_name[0]["_id"]))

        #       return self.ShowSuccessMessage(data_name[0]["_id"])

        #   ##validate if the identifier exists
        #   if self.identifier == "":
        #       self.identifier = str(self.collection.insert({
        #           "name": self.name,
        #           "description": self.description
        #           }))

        #       self.InitById(self.identifier)

        #       return self.ShowSuccessMessage(self.identifier)

        #   data = self.collection.find({"_id":ObjectId(self.identifier)})

        #   if data.count() >= 1:
        #       self.identifier = str(self.collection.update(
        #           {"_id":data[0]["_id"]},
        #           {"$set": {
        #               "name" : self.name,
        #               "description" : self.description
        #           }}))
        #       self.InitById(self.identifier)

        #   return self.ShowSuccessMessage(str(object_id))
        # except Exception, e:
        #   print str(e)
        #   return self.ShowError("failed to save cellar " + self.name)

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select * from "Cellar" where name = %(name)s limit 1'''
        parametros = {
        "name":self.name
        }
        cur.execute(query,parametros)
        cellar = cur.fetchone()

        if cellar:

            try:
                query = '''update "Cellar" set description = %(description)s, name = %(name)s, city_id = %(city_id)s where id = %(id)s returning id'''
                parametros = {
                "description": self.description,
                "name": self.name,
                "id":cellar['id'],
                "city_id":self.city_id
                }
                cur.execute(query,parametros)
                self.connection.commit()
                self.id = cur.fetchone()[0]
                self.InitById(self.id)

                return self.ShowSuccessMessage(self.id)

            except Exception,e:
                return self.ShowError("failed to save cellar {}, error:{}".format(self.name,str(e)))

        else:

            try:
                query = '''insert into "Cellar" (description, name, city_id) values (%(description)s,%(name)s,%(city_id)s) returning id'''
                parametros = {
                "description": self.description,
                "name": self.name,
                "city_id": self.city_id
                }
                cur.execute(query,parametros)
                self.connection.commit()
                self.id = cur.fetchone()[0]
                self.InitById(self.id)

                return self.ShowSuccessMessage(self.id)

            except Exception,e:
                return self.ShowError("failed to save cellar {}, error:{}".format(self.name,str(e)))            
        

    def GetList(self, page, items):
        # #validate inputs
        # page = int(page)
        # items = int(items)
        # data = self.collection.find().skip((page-1)*items).limit(items)

        # data_rtn = [] ## return this data

        # for d in data:

        #   cellar = Cellar()
        #   cellar.identifier = str(d["_id"])
        #   cellar.name = d["name"]
        #   cellar.description = d["description"]

        #   data_rtn.append(cellar.Print())
        # return data_rtn

        page = int(page)
        items = int(items)
        offset = items * (page - 1)

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select * from "Cellar" limit %(items)s offset %(offset)s'''
        parametros = {
        "items":items,
        "offset":offset
        }

        cur.execute(query,parametros)
        cellars = cur.fetchall()

        data_rtn = [] ## return this data

        for d in cellars:

          cellar = Cellar()
          cellar.id = d["id"]
          cellar.name = d["name"]
          cellar.description = d["description"]

          data_rtn.append(cellar.Print())

        return data_rtn

        # return json_util.dumps(cellars)

    ### WARNING: this method is not opmitimized
    #@return direct database collection
    @staticmethod
    def GetAllCellars():
        # data = db.cellar.find()

        # data_rtn = [] ## return this data

        # for d in data:

        #   cellar = Cellar()
        #   cellar.identifier = str(d["_id"])
        #   cellar.name = d["name"]
        #   cellar.description = d["description"]

        #   data_rtn.append(cellar.Print())
        # return data_rtn

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select * from "Cellar"'''
        cur.execute(query)
        cellar = cur.fetchall()

        data_rtn = []

        for c in cellar:
            cellar = Cellar()
            self.id = c['id']
            self.name = c['name']
            self.description = c['description']

            data_rtn.append(cellar.Print())

        return data_rtn

    def InitByName(self, name):
        # try:
        #   datas = self.collection.find({"name": name})

        #   if datas >= 1:
        #       data = datas[0]
        #       self.identifier = str(data["_id"])
        #       self.name = data["name"]
        #       self.description = data["description"]

        #       return self.ShowSuccessMessage("cellar initialized")
        #   else:
        #       raise
        # except:
        #   return self.ShowError("item not found")

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select * from "Cellar" where name = %(name)s limit 1'''
        parametros = {
        "name":name
        }
        cur.execute(query,parametros)
        cellar = cur.fetchone()

        if cellar:
            self.id = cellar['id']
            self.name = cellar['name']
            self.description = cellar['description']
            self.city_id = cellar["city_id"]

            return self.ShowSuccessMessage("cellar initialized")

        else:

            return self.ShowError("item not found")

    def InitById(self, idd):
        # try:
        #   datas = self.collection.find({"_id": ObjectId(idd)})

        #   if datas >= 1:
        #       data = datas[0]
        #       self.identifier = str(data["_id"])
        #       self.name = data["name"]
        #       self.description = data["description"]

        #       return self.ShowSuccessMessage("cellar initialized")
        #   else:
        #       raise
        # except:
        #   return self.ShowError("item not found")

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select * from "Cellar" where id = %(id)s limit 1'''
        parametros = {
        "id":idd
        }
        cur.execute(query,parametros)
        cellar = cur.fetchone()

        if cellar:
            self.id = cellar['id']
            self.name = cellar['name']
            self.description = cellar['description']
            self.city_id = cellar["city_id"]

            return self.ShowSuccessMessage("cellar initialized")

        else:

            return self.ShowError("item not found")

    def ListProducts(self, page, items):
        # data = db.kardex.find({"cellar_identifier":self.identifier})

        # data = db.kardex.aggregate([
        #   {"$match":
        #       {"cellar_identifier":self.identifier}
        #   },{
        #       "$group":
        #           {"_id":{ "product_sku":"$product_sku"}}
        #   }])

        # rtn_data = []

        # kardex = Kardex()

        # for x in data["result"]:
        #   product = Product()
        #   product.InitBySku(str(x["_id"]["product_sku"]))
        #   #print "idddddddddd"+str(x["_id"]["product_sku"])
        #   prod_print = product.Print()
        #   #print "product print "+json_util.dumps(prod_print)

        #   if "error" not in prod_print:
        #       kardex.FindKardex(str(prod_print["sku"]), self.identifier)
        #       prod_print["balance_units"] = kardex.balance_units
        #       prod_print["balance_price"] = kardex.balance_price
        #       prod_print["balance_total"] = kardex.balance_total

        #       rtn_data.append(prod_print)
        
        # return rtn_data

        rtn_data = []

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select distinct product_sku, size from "Kardex" where cellar_id = %(id)s'''
        parametros = {
        "id":self.id
        }
        cur.execute(query,parametros)
        psku = cur.fetchall()

        kardex = Kardex()

        for p in psku:
            product = Product()
            # print "SKU:{}".format(p["product_sku"])
            response_obj = product.InitBySku(p["product_sku"])

            if "error" not in response_obj:

                prod_print = response_obj["success"]

                response_obj = kardex.FindKardex(p["sku"], self.id, p["size"])

                if "success" in response_obj:

                    prod_print["balance_units"] = kardex.balance_units
                    prod_print["balance_price"] = kardex.balance_price
                    prod_print["balance_total"] = kardex.balance_total
                    prod_print["size"]          = kardex.size

                    rtn_data.append(prod_print)

                else:
                    print "error en findkardex"
                    return response_obj

            else:
                print response_obj["error"]
                # return response_obj
        
        return rtn_data


    def ListKardex(self, page, items, day, fromm, until):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        if day == "today":
            # now = datetime.datetime.now()
            # yesterday = now - datetime.timedelta(days=1)
            query = """select * from "Kardex" where date(date) = DATE 'today'"""
        if day == "yesterday":
            # now = datetime.datetime.now() - datetime.timedelta(days=1)
            # yesterday = now - datetime.timedelta(days=2)
            query = """select * from "Kardex" where date(date) = DATE 'yesterday'"""

        if day == "today" or day == "yesterday":

            # start_date = datetime.datetime(yesterday.year, yesterday.month, yesterday.day, 23, 59, 59)
            # end_date = datetime.datetime(now.year, now.month, now.day, 23, 59, 59)
            # oid_start = ObjectId.from_datetime(start_date)
            # oid_stop = ObjectId.from_datetime(end_date)

            # str_query = '{ "$and" : [{"operation_type":"sell"},{ "_id" : { "$gte" : { "$oid": "%s" }, "$lt" : { "$oid": "%s" } } }]}' % ( str(oid_start), str(oid_stop) )

            query += """ and operation_type = 'sell'"""
            # data = db.kardex.find( json_util.loads(str_query) )
            cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)
            cur.execute(query)
            data = cur.fetchall()

            return data
            
        if day == "period":

            # ffrom=fromm.split("-")

            # from_y=int(ffrom[0])
            # from_m=int(ffrom[1])
            # from_d=int(ffrom[2])

            # untill= until.split("-")

            # until_y=int(untill[0])
            # until_m=int(untill[1])
            # until_d=int(untill[2])

            # # now = datetime.datetime.now()
            # # yesterday = now - datetime.timedelta(days=30)   

            # start_date = datetime.datetime(from_y, from_m, from_d, 0, 0, 0)
            # end_date = datetime.datetime(until_y, until_m, until_d, 23, 59, 59)
            # oid_start = ObjectId.from_datetime(start_date)
            # oid_stop = ObjectId.from_datetime(end_date)

            # str_query = '{ "$and" : [{"operation_type":"sell"},{ "_id" : { "$gte" : { "$oid": "%s" }, "$lt" : { "$oid": "%s" } } }]}' % ( str(oid_start), str(oid_stop) )
            # data = db.kardex.find( json_util.loads(str_query) )
            # return data

            query = """select * from "Kardex" where date(date) between %(start_date)s and %(end_date)s and operation_type = 'sell'"""
            # data = db.kardex.find( json_util.loads(str_query) )
            cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)
            cur.execute(query)
            data = cur.fetchall()
            return data

    def FindProductKardex(self, product_sku, cellar_identifier, size):

        # try:

        #   if cellar_identifier == "remove" and size == "remove":
        #       str_query = [
        #           {'$match':{'product_sku': product_sku}}
        #           ,
        #           {'$group':{'_id':'$operation_type', 'total':{'$sum':'$units'}}}
        #           ] 

        #       eps = db.kardex.aggregate(pipeline=str_query)


        #       return eps['result']

        #   else:   
        #       # str_query = '[{$match:{"product_sku":"%s", "cellar_identifier":"%s", "size":"%s.0" }},{$group:{"_id":"$operation_type", 
                # total:{$sum:"$units"}}}]' % ( str(product_sku), str(cellar_identifier), size )
        #       str_query = [
        #           {'$match':{'product_sku': product_sku, 'cellar_identifier':cellar_identifier, 'size':size }}
        #           ,
        #           {'$group':{'_id':'$operation_type', 'total':{'$sum':'$units'}}}
        #           ] 

        #       eps = db.kardex.aggregate(pipeline=str_query)


        #       return eps['result']

        #       # str_query = '{"product_sku":"%s", "cellar_identifier": "%s", "size":"%s.0", "operation_type":"sell"}' % ( str(product_sku), str(cellar_identifier), size )
        #       # data2 = db.kardex.find( json_util.loads(str_query)).sort("_id", -1)
                
        #       # return data2

        # except Exception, e:          
        #   print e 

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)     

        if cellar_identifier == "remove" and size == "remove":
            
            query = '''select sum(units) as total, operation_type from "Kardex" where product_sku = %(product_sku)s and size = %(size)s group by operation_type'''
            parametros = {
            "product_sku":product_sku,
            "size":size
            }
            cur.execute(query, parametros)
            result = cur.fetchall()
            return result
        else:

            query = '''select sum(units) as total, operation_type from "Kardex" where product_sku = %(product_sku)s and cellar_id = %(cellar_id)s and size = %(size)s group by operation_type'''
            parametros = {
            "product_sku":product_sku,
            "cellar_id":cellar_identifier,
            "size":size
            }
            cur.execute(query, parametros)
            result = cur.fetchall()
            return result



    def Rename(self, new_name):
        # try:

        #   if new_name == "":
        #       raise

        #   self.collection.update({"_id":ObjectId(self.identifier)},
        #       {"$set":{
        #           "name":new_name
        #       }})
        #   self.name = new_name
        #   self.ShowSuccessMessage("name changed correctly")
        # except:
        #   self.ShowError("error changing name")

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        try:

            if new_name == "":
                raise

            query = '''update "Cellar" set name = %(name)s where id = %(id)s'''
            parametros = {
            "name":new_name,
            "id":self.id
            }

            cur.execute(query,parametros)
            self.connection.commit()
            self.name = new_name
            self.ShowSuccessMessage("name changed correctly")
        except:
            self.ShowError("error changing name")

    def GetWebCellar(self):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        try:
            query = '''select id from "Cellar" where for_sale = 1 limit 1'''
            cur.execute(query)
            cellar = cur.fetchone()["id"]
            return self.ShowSuccessMessage(cellar)
        except Exception,e:
            return self.ShowError(str(e))
        finally:
            self.connection.close()
            cur.close()