#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basemodel import BaseModel
from cart import Cart
from size import Size
import psycopg2
import psycopg2.extras
from datetime import datetime
import pytz

class Kardex(BaseModel):

    def __init__(self):
        BaseModel.__init__(self)
        self._product_sku = ''
        self._cellar_identifier = ''
        self._operation_type = Kardex.OPERATION_BUY
        self._units = 0
        self._price = 0.0
        self._sell_price = 0.0
        self._size = ''
        self._color = ''
        self._total = 0.0
        self._balance_units = 0
        self._balance_price = 0.0
        self._balance_total = 0.0
        self._date = str(datetime.now(pytz.timezone('Chile/Continental')).isoformat())
        self._user = ""
        self._size_id = ""
        self._order_id = None

    OPERATION_BUY = "buy"
    OPERATION_SELL = "sell"
    OPERATION_MOV_IN = "mov_in"
    OPERATION_MOV_OUT = "mov_out"

    @property
    def user(self):
        return self._user

    @user.setter
    def user(self, value):
        self._user = value

    @property
    def product_sku(self):
        return self._product_sku

    @product_sku.setter
    def product_sku(self, value):
        self._product_sku = value

    @property
    def cellar_identifier(self):
        return self._cellar_identifier

    @cellar_identifier.setter
    def cellar_identifier(self, value):
        self._cellar_identifier = value

    @property
    def operation_type(self):
        return self._operation_type

    @operation_type.setter
    def operation_type(self, value):
        self._operation_type = value

    @property
    def units(self):
        return self._units

    @units.setter
    def units(self, value):
        self._units = value

    @property
    def price(self):
        return self._price

    @price.setter
    def price(self, value):
        self._price = value

    @property
    def sell_price(self):
        return self._sell_price

    @sell_price.setter
    def sell_price(self, value):
        self._sell_price = value

    @property
    def size(self):
        return self._size

    @size.setter
    def size(self, value):
        self._size = value

    @property
    def color(self):
        return self._color

    @color.setter
    def color(self, value):
        self._color = value

    @property
    def total(self):
        return self._total

    @total.setter
    def total(self, value):
        self._total = value

    @property
    def balance_units(self):
        return self._balance_units

    @balance_units.setter
    def balance_units(self, value):
        self._balance_units = value

    @property
    def balance_price(self):
        return self._balance_price

    @balance_price.setter
    def balance_price(self, value):
        self._balance_price = value

    @property
    def balance_total(self):
        return self._balance_total

    @balance_total.setter
    def balance_total(self, value):
        self._balance_total = value

    @property
    def date(self):
        return self._date

    @date.setter
    def date(self, value):
        self._date = value

    @property
    def size_id(self):
        return self._size_id

    @size_id.setter
    def size_id(self, value):
        self._size_id = value

    @property
    def order_id(self):
        return self._order_id

    @order_id.setter
    def order_id(self, value):
        self._order_id = value

    def Save(self):
        return ''

    def InitById(self, idd):
        return ''

    def FindKardex(self, product_sku, cellar_identifier, size_id):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select * from "Kardex" where product_sku = %(product_sku)s and cellar_id = %(cellar_id)s and size_id = %(size_id)s order by date desc, id desc limit 1'''

        parametros = {
            "product_sku": product_sku,
            "cellar_id": cellar_identifier,
            "size_id": size_id
        }

        try:
            cur.execute(query, parametros)
            kardex = cur.fetchone()

            self.id = kardex["id"]
            self.product_sku = kardex["product_sku"]
            self.operation_type = kardex["operation_type"]
            self.units = kardex["units"]
            self.price = kardex["price"]
            self.sell_price = kardex["sell_price"]
            self.size_id = kardex["size_id"]
            self.color = kardex["color"]
            self.total = kardex["total"]
            self.balance_units = kardex["balance_units"]
            self.balance_price = kardex["balance_price"]
            self.balance_total = kardex["balance_total"]
            self.date = kardex["date"]
            self.user = kardex["user"]
            self.cellar_identifier = kardex["cellar_id"]
            self.order_id = kardex["order_id"]
            return self.ShowSuccessMessage("kardex has been initialized")
        except Exception, e:
            return self.ShowError("kardex not found, {}".format(str(e)))

    # take care of an infinite loop
    # return last kardex in the database
    def GetPrevKardex(self):

        # new_kardex = Kardex()

        # new_kardex.product_sku = self.product_sku
        # new_kardex.cellar_identifier = self.cellar_identifier

        # try:
        #   data = self.collection.find({
        #                               "product_sku":self.product_sku,
        #                               "cellar_identifier":self.cellar_identifier
        #                               }).sort("_id",-1)

        #   if data.count() >= 1:
        #       new_kardex.identifier = str(data[0]["_id"])
        #       new_kardex.operation_type = data[0]["operation_type"]
        #       new_kardex.units = data[0]["units"]
        #       new_kardex.price = data[0]["price"]
        #       new_kardex.sell_price = data[0]["sell_price"]
        #       new_kardex.size =data[0]["size"]
        #       new_kardex.color = data[0]["color"]
        #       new_kardex.total = data[0]["total"]
        #       new_kardex.balance_units = data[0]["balance_units"]
        #       new_kardex.balance_price = data[0]["balance_price"]
        #       new_kardex.balance_total = data[0]["balance_total"]
        #       new_kardex.date = data[0]["date"]
        #       if "user" in data[0]:
        #           new_kardex.user = data[0]["user"]
        # except Exception, e:
        #   pass

        # return new_kardex

        new_kardex = Kardex()

        try:
            new_kardex.product_sku = self.product_sku
            new_kardex.cellar_identifier = self.cellar_identifier

            cur = self.connection.cursor(
                cursor_factory=psycopg2.extras.DictCursor)

            query = '''select * from "Kardex" where product_sku = %(product_sku)s and cellar_id = %(cellar_id)s and size_id = %(size_id)s order by id desc limit 1'''

            parametros = {
                "product_sku": self.product_sku,
                "cellar_id": self.cellar_identifier,
                "size_id": self.size_id
            }
            cur.execute(query, parametros)
            # print "QUERY:{}".format(cur.query)
            kardex = cur.fetchone()

            if kardex:
                new_kardex.id = kardex["id"]
                new_kardex.operation_type = kardex["operation_type"]
                new_kardex.units = kardex["units"]
                new_kardex.price = kardex["price"]
                new_kardex.sell_price = kardex["sell_price"]
                new_kardex.size_id = kardex["size_id"]
                new_kardex.color = kardex["color"]
                new_kardex.total = kardex["total"]
                new_kardex.balance_units = kardex["balance_units"]
                new_kardex.balance_price = kardex["balance_price"]
                new_kardex.balance_total = kardex["balance_total"]
                new_kardex.date = kardex["date"]
                new_kardex.user = kardex["user"]
                new_kardex.cellar_identifier = kardex["cellar_id"]
                new_kardex.order_id = kardex["order_id"]
        except:
            return self.ShowError("kardex not found")

        return self.ShowSuccessMessage(new_kardex)

    def Insert(self):

        response_prevkardex = self.GetPrevKardex()

        prev_kardex = Kardex()

        if "success" in response_prevkardex:
            prev_kardex = response_prevkardex["success"]
        else:
            return self.ShowError("error al obtener kardex {}".format(response_prevkardex["error"]))

        # parsing all to float
        self.price = float(self.price)
        self.total = float(self.total)
        self.balance_price = float(self.balance_price)
        self.balance_total = float(self.balance_total)
        self.units = int(self.units)

        # doing maths...
        if self.operation_type == Kardex.OPERATION_SELL or self.operation_type == Kardex.OPERATION_MOV_OUT:
            self.price = prev_kardex.balance_price  # calculate price
        if self.price == "0":
            self.price = prev_kardex.balance_price

        self.total = self.units * self.price

        if self.operation_type == Kardex.OPERATION_BUY or self.operation_type == Kardex.OPERATION_MOV_IN:
            self.sell_price = "0"
            self.balance_units = prev_kardex.balance_units + self.units
            self.balance_total = prev_kardex.balance_total + self.total
        else:
            self.balance_units = prev_kardex.balance_units - self.units
            self.balance_total = prev_kardex.balance_total - self.total

        if self.balance_units != 0:  #  prevent division by zero
            self.balance_price = self.balance_total / self.balance_units

        #  truncate
        self.price = float(int(self.price * 100)) / 100.0
        self.total = round(float(int(self.total * 100)) / 100.0)
        self.balance_price = float(int(self.balance_price * 100)) / 100.0
        self.balance_total = round(
            float(int(self.balance_total * 100)) / 100.0)

        '''
        ## detect if product exists
        product_data = db.products.find({"_id":ObjectId(self.product_sku)}).count()
        ## detect if cellar exists
        cellar_data = db.cellar.find({"_id":ObjectId(self.cellar_identifier)}).count()

        print "product_data:" + product_data

        if cellar_data == 0 or product_data == 0:
            return self.ShowError("the cellar does not exist")
        '''

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select * from "Kardex" where product_sku = %(product_sku)s and cellar_id = %(cellar_id)s and size_id = %(size_id)s order by id desc limit 1'''

        parametros = {
            "product_sku": self.product_sku,
            "cellar_id": self.cellar_identifier,
            "operation_type": self.operation_type,
            "units": self.units,
            "price": self.price,
            "sell_price": self.sell_price,
            "size_id": self.size_id,
            "color": self.color,
            "total": self.total,
            "balance_units": self.balance_units,
            "balance_price": self.balance_price,
            "balance_total": self.balance_total,
            "date": self.date,
            "user": self.user,
            "order_id": self.order_id
        }

        try:
            query = '''\
                    insert into "Kardex" (balance_total,
                                            product_sku,
                                            cellar_id,
                                            operation_type,
                                            units,
                                            price,
                                            sell_price,
                                            size_id,
                                            color,
                                            total,
                                            balance_units,
                                            balance_price,
                                            date,
                                            "user",
                                            order_id) 
                    values (%(balance_total)s,
                            %(product_sku)s,
                            %(cellar_id)s,
                            %(operation_type)s,
                            %(units)s,
                            %(price)s,
                            %(sell_price)s,
                            %(size_id)s,
                            %(color)s,
                            %(total)s,
                            %(balance_units)s,
                            %(balance_price)s,
                            %(date)s,
                            %(user)s,
                            %(order_id)s)'''
            cur.execute(query, parametros)
            # return cur.mogrify(query,parametros)
            self.connection.commit()
            return self.ShowSuccessMessage("products has been added")
        except Exception, e:
            return self.ShowError("an error ocurred, error:{}".format(str(e)))
        finally:
            cur.close()
            self.connection.close()

        # self.collection.save({
        #       "product_sku":self.product_sku,
        #       "cellar_identifier":self.cellar_identifier,
        #       "operation_type":self.operation_type,
        #       "units":self.units,
        #       "price":self.price,
        #       "sell_price":self.sell_price,
        #       "size":self.size,
        #       "color":self.color,
        #       "total":self.total,
        #       "balance_units":self.balance_units,
        #       "balance_price":self.balance_price,
        #       "balance_total":self.balance_total,
        #       "date":self.date,
        #       "user":self.user
        #   })

    # only for debugging.
    def Debug(self, product_sku, cellar_identifier, size):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        query = '''select * from "Kardex" where product_sku = %(product_sku)s and cellar_id = %(cellar_id)s and size = %(size)s order by id desc limit 1'''

        parameters = {
            "product_sku": product_sku,
            "cellar_id": cellar_identifier,
            "size": size
        }

        # data = self.collection.find({
        #                   "product_sku":self.product_sku,
        #                   "cellar_identifier":self.cellar_identifier
        #                   }).sort("_id",1)

        try:
            cur.execute(query, parameters)
            data = cur.fetchone()

            for d in data:
                print d["operation_type"]
                print " units :     {}".format(d["units"])
                print " price :     {}".format(d["price"])
                print " sell_price :    {}".format(d["sell_price"])
                print " size :  {}".format(d["size"])
                print " color :     {}".format(d["color"])
                print " total :     {}".format(d["total"])
                print " balance units :     {}".format(d["balance_units"])
                print " balance price :     {}".format(d["balance_price"])
                print " balance total :     {}".format(d["balance_total"])

        except Exception, e:
            print str(e)
            pass

    def checkStock(self, lista, cellar_id):

        errors = []

        for l in lista:
            product_sku = l["sku"]
            product_size = l["size"]
            quantity = l["quantity"]
            name = l["name"]

            size = Size()
            size.name = product_size
            res_name = size.initByName()

            if "success" in res_name:
                product_size = size.id

            res_kardex = self.FindKardex(product_sku, cellar_id, product_size)

            if "success" in res_kardex:

                # print "quantity: {} units: {}\n".format(quantity,
                # self.balance_units)

                if self.balance_units < quantity:

                    # cart = Cart()
                    # cart.id = l["id"]
                    # res_remove = cart.Remove()

                    # if "error" in res_remove:
                    #   print res_remove["error"]

                    if self.balance_units > 0:
                        errors.append(
                            {"sku": name, "error": "queda {} unidades".format(self.balance_units)})
                    else:
                        errors.append({"sku": '', "error": "El producto {} que tienes en tu carrito \
                            ya no tiene stock, lo sentimos!!!, \
                            por favor elimina ese producto del carro \
                            para poder continuar con tu compra".format(name)})
            else:

                errors.append(
                    {"sku": product_sku, "error": res_kardex["error"]})

        # print errors

        if len(errors) > 0:
            return self.ShowError(errors)
        else:
            return self.ShowSuccessMessage("ok")
