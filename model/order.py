#!/usr/bin/python
# -*- coding: UTF-8 -*-

# from bson import json_util
# from bson.objectid import ObjectId
from basemodel import BaseModel
from order_detail import OrderDetail
import psycopg2
import psycopg2.extras
from datetime import datetime
import pytz

class Order(BaseModel):

    ESTADO_PENDIENTE = 1
    ESTADO_CONFIRMADO = 2
    ESTADO_PARA_DESPACHO = 3
    ESTADO_DESPACHADO = 4
    ESTADO_CANCELADO = 5
    ESTADO_PENDIENTE_WP = 6

    TIPO_WEB = 1

    @property
    def salesman(self):
        return self._salesman

    @salesman.setter
    def salesman(self, value):
        self._salesman = value

    @property
    def user_id(self):
        return self._user_id

    @user_id.setter
    def user_id(self, value):
        self._user_id = value

    @property
    def subtotal(self):
        return self._subtotal

    @subtotal.setter
    def subtotal(self, value):
        self._subtotal = value

    @property
    def shipping(self):
        return self._shipping

    @shipping.setter
    def shipping(self, value):
        self._shipping = value

    @property
    def tax(self):
        return self._tax

    @tax.setter
    def tax(self, value):
        self._tax = value

    @property
    def total(self):
        return self._total

    @total.setter
    def total(self, value):
        self._total = value

    @property
    def address(self):
        return self._address

    @address.setter
    def address(self, value):
        self._address = value

    @property
    def town(self):
        return self._town

    @town.setter
    def town(self, value):
        self._town = value

    @property
    def city(self):
        return self._city

    @city.setter
    def city(self, value):
        self._city = value

    @property
    def date(self):
        return self._date

    @date.setter
    def date(self, value):
        self._date = value

    # si es persona o empresa
    @property
    def type(self):
        return self._type

    @type.setter
    def type(self, value):
        self._type = value

    # web, tablet, etc...
    @property
    def source(self):
        return self._source

    @source.setter
    def source(self, value):
        self._source = value

    @property
    def country(self):
        return self._country

    @country.setter
    def country(self, value):
        self._country = value

    @property
    def items_quantity(self):
        return self._items_quantity

    @items_quantity.setter
    def items_quantity(self, value):
        self._items_quantity = value
    
    @property
    def products_quantity(self):
        return self._products_quantity

    @products_quantity.setter
    def products_quantity(self, value):
        self._products_quantity = value

    #recibida, reservada, despachada, etc...
    @property
    def state(self):
        return self._state

    @state.setter
    def state(self, value):
        self._state = value

    @property
    def billing_id(self):
        return self._billing_id

    @billing_id.setter
    def billing_id(self, value):
        self._billing_id = value
    
    @property
    def shipping_id(self):
        return self._shipping_id

    @shipping_id.setter
    def shipping_id(self, value):
        self._shipping_id = value
    
    @property
    def payment_type(self):
        return self._payment_type

    @payment_type.setter
    def payment_type(self, value):
        self._payment_type = value

    @property
    def voucher(self):
        return self._voucher

    @voucher.setter
    def voucher(self, value):
        self._voucher = value

    @property
    def shipping_info(self):
        return self._shipping_info

    @shipping_info.setter
    def shipping_info(self, value):
        self._shipping_info = value

    @property
    def billing_info(self):
        return self._billing_info

    @billing_info.setter
    def billing_info(self, value):
        self._billing_info = value

    def __init__(self):
        BaseModel.__init__(self)
        self._id                     = ""
        self._date                   = ""
        self._type                   = 1  # por defecto 1 para personas
        self._salesman               = ""
        self._user_id                = ""
        self._subtotal               = ""
        self._shipping               = ""
        self._tax                    = ""
        self._total                  = ""
        self._address                = ""
        self._town                   = ""
        self._city                   = ""
        self._source                 = ""
        self._country                = ""
        self._items_quantity         = ""
        self._products_quantity      = ""
        self._state                  = self.ESTADO_PENDIENTE
        self._billing_id             = -1
        self._shipping_id            = -1
        self._address_id             = -1
        self._payment_type           = 1
        self._voucher                = ""
        self._shipping_info          = ""
        self._billing_info           = ""

    def GetOrderById(self, _id):

        # order = self.collection.find_one({"id":int(_id)})

        # if order:
        #     return json_util.dumps(order)
        # else:
        #     return "{}"

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select * from "Order" where id = %(id)s limit 1'''

        parametros = {
            "id":_id
        }

        cur.execute(query,parametros)

        order = cur.fetchone()

        if order:
            return order
        else:
            return {}

    def Save(self):

        # new_id = db.seq.find_and_modify(query={'seq_name':'order_seq'},update={'$inc': {'id': 1}},fields={'id': 1, '_id': 0},new=True,upsert=True)["id"]

        # # validate contrains
        # object_id = self.collection.insert({
        #     "id": new_id,
        #     "date": self.date,
        #     "source": self.source,
        #     "country": self.country,
        #     "items_quantity": self.items_quantity,
        #     "products_quantity": self.products_quantity,
        #     "state": self.state,
        #     "salesman" : self.salesman,
        #     "customer" : self.customer,
        #     "subtotal" : self.subtotal,
        #     "shipping" : self.shipping,
        #     "tax" : self.tax,
        #     "total" : self.total,
        #     "address" : self.address,
        #     "town" : self.town,
        #     "city" : self.city,
        #     "type" : self.type
        #     })

        # return str(object_id)

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''
                insert into "Order" (voucher,
                                    date,
                                    type,
                                    subtotal,
                                    shipping,
                                    tax,
                                    total,
                                    items_quantity,
                                    products_quantity,
                                    user_id,
                                    billing_id,
                                    shipping_id,
                                    payment_type,
                                    shipping_info,
                                    billing_info,
                                    state) 
            values (%(voucher)s,
                    %(date)s,
                    %(type)s,
                    %(subtotal)s,
                    %(shipping)s,
                    %(tax)s,
                    %(total)s,
                    %(items_quantity)s,
                    %(products_quantity)s,
                    %(user_id)s,
                    %(billing_id)s,
                    %(shipping_id)s,
                    %(payment_type)s,
                    %(shipping_info)s,
                    %(billing_info)s,
                    %(state)s) 
        returning id'''

        parametros = {
            "voucher":self.voucher,
            "type":self.type,
            "subtotal":self.subtotal,
            "shipping":self.shipping,
            "tax":self.tax,
            "total":self.total,
            "items_quantity":self.items_quantity,
            "products_quantity":self.products_quantity,
            "user_id":self.user_id,
            "billing_id":self.billing_id,
            "shipping_id":self.shipping_id,
            "payment_type":self.payment_type,
            "date": datetime.now(pytz.timezone('Chile/Continental')).isoformat(),
            "billing_info": self.billing_info,
            "shipping_info": self.shipping_info,
            "state": self.state
        }

        try:
            # print cur.mogrify(query, parametros)
            cur.execute(query,parametros)

            self.connection.commit()

            self.id = cur.fetchone()[0]

            return self.ShowSuccessMessage("{}".format(self.id))

        except Exception,e:

            return self.ShowError(str(e))

        finally:
            cur.close()
            self.connection.close()

    def DeleteOrders(self,ids):
        self.collection.remove({"id":{"$in":ids}})
        od = OrderDetail()
        for i in ids:
            od.Remove(i)

    def ChangeStateOrders(self,ids,state):
        print ids
        self.collection.update({"id":{"$in":ids}},{"$set":{"state":state}},multi=True)

    def GetLastOrderByCustomerId(self, _id):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select * from "Order" where user_id = %(user_id)s order by id desc limit 1'''

        parametros = {
            "user_id":_id
        }

        cur.execute(query,parametros)

        order = cur.fetchone()

        if order:
            return order
        else:
            return {}

    def Edit(self):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''
                update "Order" 
                set voucher = %(voucher)s,
                    type = %(type)s,
                    subtotal = %(subtotal)s,
                    shipping = %(shipping)s,
                    tax = %(tax)s,
                    total = %(total)s,
                    items_quantity = %(items_quantity)s,
                    products_quantity = %(products_quantity)s,
                    user_id = %(user_id)s,
                    billing_id = %(billing_id)s,
                    shipping_id = %(shipping_id)s,
                    payment_type = %(payment_type)s, 
                    state = %(state)s,
                    billing_info = %(billing_info)s,
                    shipping_info = %(shipping_info)s 
                where id = %(id)s'''

        parametros = {
            "voucher":self.voucher,
            "type":self.type,
            "subtotal":self.subtotal,
            "shipping":self.shipping,
            "tax":self.tax,
            "total":self.total,
            "items_quantity":self.items_quantity,
            "products_quantity":self.products_quantity,
            "user_id":self.user_id,
            "billing_id":self.billing_id,
            "shipping_id":self.shipping_id,
            "payment_type":self.payment_type,
            "state":self.state,
            "id":self.id,
            "billing_info": self.billing_info,
            "shipping_info": self.shipping_info
        }

        try:
            cur.execute(query,parametros)

            self.connection.commit()

            return self.ShowSuccessMessage("Order edited correctly")

        except Exception,e:

            return self.ShowError(str(e))

        finally:
            cur.close()
            self.connection.close()

    def RemoveByUserId(self,user_id):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        od = OrderDetail()

        query = '''select id from "Order" where user_id = %(user_id)s'''

        parametros = {
            "user_id":user_id
        }

        try:
            cur.execute(query,parametros)
            ordenes = cur.fetchall()

            for o in ordenes:
                od.RemoveByOrderId(o["id"])

        except Exception,e:
            return self.ShowError("Error deleting order details, {}".format(str(e)))

        query = '''delete from "Order" where user_id = %(user_id)s'''

        parametros = {
            "user_id":user_id
        }

        try:
            cur.execute(query,parametros)
            self.connection.commit()
            return self.ShowSuccessMessage(user_id)
        except Exception,e:
            return self.ShowError("Error deleting orders by user_id {user_id}, error:{error}".format(user_id=user_id,error=str(e)))

    def InitById(self, _id):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select * from "Order" where id = %(id)s limit 1'''

        parametros = {
            "id":_id
        }

        try:
            cur.execute(query,parametros)
            order = cur.fetchone()

            if cur.rowcount > 0:
                self.id = order["id"]
                self.date = order["date"]
                self.type = order["type"]
                self.subtotal = order["subtotal"]
                self.shipping = order["shipping"]
                self.tax = order["tax"]
                self.total = order["total"]
                self.items_quantity = order["items_quantity"]
                self.products_quantity = order["products_quantity"]
                self.user_id = order["user_id"]
                self.billing_id = order["billing_id"]
                self.shipping_id = order["shipping_id"]
                self.payment_type = order["payment_type"]
                self.source = order["source"]
                self.voucher = order["voucher"]
                self.state = order["state"]
                self.shipping_info = order['shipping_info']
                self.billing_info = order['billing_info']

                return self.ShowSuccessMessage(self.id)
            else:
                return self.ShowError("order not found")

        except Exception,e:
            return self.ShowError(str(e))
