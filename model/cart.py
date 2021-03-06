#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basemodel import BaseModel
from basehandler import BaseHandler
import psycopg2
import psycopg2.extras
from datetime import datetime
from contact import Contact
from order import Order
from product import Product
import pytz


class Cart(BaseModel):

    @property
    def product_id(self):
        return self._product_id

    @product_id.setter
    def product_id(self, value):
        self._product_id = value

    @property
    def date(self):
        return self._date

    @date.setter
    def date(self, value):
        self._date = value

    @property
    def quantity(self):
        return self._quantity

    @quantity.setter
    def quantity(self, value):
        self._quantity = value

    @property
    def subtotal(self):
        return self._subtotal

    @subtotal.setter
    def subtotal(self, value):
        self._subtotal = value

    @property
    def user_id(self):
        return self._user_id

    @user_id.setter
    def user_id(self, value):
        self._user_id = value

    @property
    def size(self):
        return self._size

    @size.setter
    def size(self, value):
        self._size = value

    @property
    def shipping_id(self):
        return self._shipping_id

    @shipping_id.setter
    def shipping_id(self, value):
        self._shipping_id = value

    @property
    def billing_id(self):
        return self._billing_id

    @billing_id.setter
    def billing_id(self, value):
        self._billing_id = value

    @property
    def payment_type(self):
        return self._payment_type

    @payment_type.setter
    def payment_type(self, value):
        self._payment_type = value

    @property
    def shipping_type(self):
        return self._shipping_type

    @shipping_type.setter
    def shipping_type(self, value):
        self._shipping_type = value

    @property
    def price(self):
        return self._price

    @price.setter
    def price(self, value):
        self._price = value

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
        self.table = 'Temp_Cart'
        self._product_id = -1
        self._date = datetime.now(pytz.timezone('Chile/Continental')).isoformat()
        self._quantity = 0
        self._subtotal = 0
        self._user_id = -1
        self._size = ''
        self._shipping_id = 0
        self._billing_id = 0
        self._payment_type = 1
        self._shipping_type = 1
        self._price = 0
        self._shipping_info          = ""
        self._billing_info           = ""

    def Remove(self):

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)

        try:
            q = '''delete from "Temp_Cart" where id = %(id)s'''
            p = {
                "id": self.id
            }
            cur.execute(q, p)
            self.connection.commit()
            return self.ShowSuccessMessage(str(self.id))
        except Exception, e:
            return self.ShowError(str(e))
        finally:
            cur.close()
            self.connection.close()

    def RemoveByUserId(self):

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)

        try:
            q = '''delete from "Temp_Cart" where user_id = %(user_id)s'''
            p = {
                "user_id": self.user_id
            }
            cur.execute(q, p)
            self.connection.commit()
            return self.ShowSuccessMessage(str(self.user_id))
        except Exception, e:
            return self.ShowError(str(e))
        finally:
            cur.close()
            self.connection.close()

    def InitById(self, idd):

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)

        q = '''select * from "Temp_Cart" where id = %(id)s'''
        p = {
            "id": idd
        }
        try:
            cur.execute(q, p)
            usuario = cur.fetchone()
            if cur.rowcount > 0:
                self.id = usuario["id"]
                self.product_id = usuario["product_id"]
                self.date = usuario["date"]
                self.quantity = usuario["quantity"]
                self.subtotal = usuario["subtotal"]
                self.user_id = usuario["user_id"]
                self.size = usuario["size"]
                self.shipping_id = usuario["shipping_id"]
                self.billing_id = usuario["billing_id"]
                self.payment_type = usuario["payment_type"]
                self.price = usuario["price"]
                self.shipping_info = usuario['shipping_info']
                self.billing_info = usuario['billing_info']

                return self.ShowSuccessMessage("cart has been initizalized successfully")
            else:
                return self.ShowError("user : {} not found".format(idd))
        except Exception, e:
            return self.ShowError("cannot find cart with id {}, error:{}".format(idd, str(e)))

    def Save(self):

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)

        existe = False

        try:
            q = '''select id from "Temp_Cart" where user_id = %(user_id)s and product_id = %(product_id)s and size = %(size)s and bought = 0 limit 1'''
            p = {
                "product_id": self.product_id,
                "user_id": self.user_id,
                "size": self.size
            }

            # print cur.mogrify(q, p)

            cur.execute(q, p)

            if cur.rowcount > 0:
                self.id = cur.fetchone()["id"]
                existe = True

        except Exception, e:
            return self.ShowError("failed getting cart, error:{}".format(str(e)))

        if not existe:

            try:
                q = '''\
                    insert into "Temp_Cart" (product_id,
                                            date,
                                            quantity,
                                            subtotal,
                                            user_id,
                                            size,
                                            price) 
                    values (%(product_id)s,
                            %(date)s,
                            %(quantity)s,
                            %(subtotal)s,
                            %(user_id)s,
                            %(size)s,
                            %(price)s) 
                    returning id'''
                p = {
                    "product_id": self.product_id,
                    "date": self.date,
                    "quantity": self.quantity,
                    "subtotal": self.subtotal,
                    "user_id": self.user_id,
                    "size": self.size,
                    "price": self.price
                }
                # print cur.mogrify(q, p)
                cur.execute(q, p)
                self.connection.commit()
                self.id = cur.fetchone()["id"]

                return self.ShowSuccessMessage(str(self.id))

            except Exception, e:
                return self.ShowError("failed to add item to cart, error:{}".format(str(e)))

            finally:
                cur.close()
                self.connection.close()

        else:

            try:
                q = '''update "Temp_Cart" set quantity = quantity + %(quantity)s, subtotal = subtotal + %(subtotal)s where id = %(id)s returning id'''
                p = {
                    "id": self.id,
                    "quantity": self.quantity,
                    "subtotal": self.subtotal
                }
                cur.execute(q, p)
                self.connection.commit()
                self.id = cur.fetchone()["id"]

                return self.ShowSuccessMessage(str(self.id))

            except Exception, e:
                return self.ShowError("failed to update item to cart, error:{}".format(str(e)))

            finally:
                cur.close()
                self.connection.close()

    # quitar en algun momento el argumento bought porque ya no se usara mas
    def GetCartByUserId(self, page=1, items=5, bought=0):

        page = int(page)
        items = int(items)
        offset = (page - 1) * items
        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)
        try:
            q = '''select tc.id,
                    p.sku,
                    p.name,
                    c.name as category,
                    tc.size,
                    p.color,
                    tc.quantity,
                    tc.subtotal,
                    tc.price,
                    p.image,
                    tc.billing_id,
                    tc.shipping_id,
                    tc.shipping_type,
                    tc.payment_type,
                    tc.shipping_info,
                    tc.billing_info,
                    tc.product_id from "Temp_Cart" tc 
                    inner join "Product" p on tc.product_id = p.id 
                    inner join "Category" c on c.id = p.category_id 
                    where tc.user_id = %(user_id)s'''
            p = {
                "user_id": self.user_id
            }
            # print cur.mogrify(q, p)
            cur.execute(q, p)

            lista = cur.fetchall()
            return lista
        except Exception, e:
            print str(e)
            return {}

    def Edit(self):

        parametros = {
            "product_id": self.product_id,
            "quantity": self.quantity,
            "subtotal": self.subtotal,
            "user_id": self.user_id,
            "size": self.size,
            "shipping_id": self.shipping_id,
            "billing_id": self.billing_id,
            "payment_type": self.payment_type,
            "id": self.id,
            "shipping_type": self.shipping_type,
            "price": self.price,
            "shipping_info": self.shipping_info,
            "billing_info": self.billing_info
        }

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)

        query = '''update "Temp_Cart" set product_id = %(product_id)s,
                                          quantity = %(quantity)s,
                                          subtotal = %(subtotal)s,
                                          user_id = %(user_id)s,
                                          size = %(size)s,
                                          shipping_id = %(shipping_id)s,
                                          billing_id = %(billing_id)s,
                                          payment_type = %(payment_type)s,
                                          shipping_type = %(shipping_type)s,
                                          price = %(price)s,
                                          shipping_info = %(shipping_info)s,
                                          billing_info = %(billing_info)s
                                    where id = %(id)s and bought = 0'''

        try:
            cur.execute(query, parametros)
            self.connection.commit()

            if cur.rowcount > 0:
                return self.ShowSuccessMessage("cart has been updated successfully")
            else:
                return self.ShowSuccessMessage("no cart to be updated")

        except Exception, e:
            print "Error al editar carro {}".format(str(e))
            return self.ShowError(str(e))

    def MoveTempToLoggedUser(self, old_user_id, current_user_id):

        new_cart = []

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)

        query = '''select * from "Temp_Cart" where user_id = %(old_user_id)s'''
        parameters = {
            "current_user_id": current_user_id,
            "old_user_id": old_user_id
        }

        try:
            cur.execute(query, parameters)
            new_cart = cur.fetchall()
            self.connection.commit()
        except Exception, e:
            pass
        finally:
            cur.close()
            self.connection.close()

        for item in new_cart:

            cur0 = self.connection.cursor(
                cursor_factory=psycopg2.extras.RealDictCursor)

            query = '''\
                    select id from "Temp_Cart" 
                    where user_id = %(current_user_id)s 
                    and product_id = %(product_id)s
                    and size = %(size)s'''
            parameters = {
                "current_user_id": current_user_id,
                "old_user_id": old_user_id,
                "product_id": item["product_id"],
                "size": item["size"]
            }

            try:
                cur0.execute(query, parameters)
                tc = cur0.fetchone()
                self.connection.commit()

                if tc is not None:
                    cur1 = self.connection.cursor(
                        cursor_factory=psycopg2.extras.RealDictCursor)
                    q = '''update "Temp_Cart" set quantity = quantity + %(quantity)s, subtotal = (quantity + %(quantity)s) * price where id = %(id)s'''
                    p = {
                        "id": tc["id"],
                        "quantity": item["quantity"]
                    }
                    try:
                        cur1.execute(q, p)
                        self.connection.commit()
                    except:
                        pass
                    finally:
                        cur1.close()
                        self.connection.close()
                else:
                    cur2 = self.connection.cursor(
                        cursor_factory=psycopg2.extras.RealDictCursor)
                    q = '''\
                        update "Temp_Cart" set user_id = %(current_user_id)s 
                        where id = %(id)s'''
                    p = {
                        "current_user_id": current_user_id,
                        "id": item["id"]
                    }
                    try:
                        cur2.execute(q, p)
                        self.connection.commit()
                    except:
                        pass
                    finally:
                        cur2.close()
                        self.connection.close()
            except Exception, e:
                pass
            finally:
                cur0.close()
                self.connection.close()

        # contact = Contact()
        # order = Order()

        # response_obj = order.RemoveByUserId(old_user_id)

        # if "success" in response_obj:

        #     response = contact.RemoveByUserId(old_user_id)

        #     if "success" in response:

        #         query = '''delete from "User" where id = %(old_user_id)s'''
        #         parameters = {
        #             "old_user_id": old_user_id
        #         }

        #         try:
        #             cur.execute(query, parameters)
        #             self.connection.commit()
        #             return self.ShowSuccessMessage("Cart has been move to logged user")
        #         except Exception, e:
        #             return self.ShowError(str(e))

        #     else:

        #         return self.ShowError(response["error"])
        # else:
        #     return self.ShowError(response_obj["error"])

    def UpdateCartQuantity(self, cart_id, quantity):

        try:

            cur = self.connection.cursor(
                cursor_factory=psycopg2.extras.RealDictCursor)

            query = '''\
                    select tc.quantity, 
                        tc.user_id, 
                        tc.price 
                    from "Product" p 
                    inner join "Temp_Cart" tc on tc.product_id = p.id 
                    where tc.id = %(cart_id)s'''
            parameters = {"cart_id": cart_id}

            price = 0
            old_quantity = 0
            total = 0
            user_id = None

            cur.execute(query, parameters)
            res = cur.fetchone()

            price = res["price"]

            old_quantity = res["quantity"]
            user_id = res["user_id"]

            query = '''update "Temp_Cart" set quantity = %(quantity)s, subtotal = %(quantity)s * price where id = %(cart_id)s'''
            parameters = {
                "quantity": int(quantity), "cart_id": cart_id}

            cur.execute(query, parameters)
            self.connection.commit()

            query = '''select sum(subtotal) as total from "Temp_Cart" where user_id = %(user_id)s'''
            parameters = {"user_id": user_id}

            cur.execute(query, parameters)

            total = cur.fetchone()["total"]

            return self.ShowSuccessMessage({"subtotal": int(quantity) * int(price), "total": total})

        except Exception, e:
            return self.ShowError("obtener cantidad: {}".format(str(e)))
        finally:
            self.connection.close()
            cur.close()

    def updatePrice(self, detail, user):

        counter = 0

        for item in detail:
            product = Product()
            res_product = product.InitBySku(item["sku"])

            if "success" in res_product:

                price = item["price"]
                subtotal = item["subtotal"]

                if product.promotion_price != 0:
                    subtotal = int(product.promotion_price) * item["quantity"]
                    price = product.promotion_price
                else:
                    subtotal = int(product.sell_price) * item["quantity"]
                    price = product.sell_price

                if user:
                    if user["type_id"] == 4:
                        subtotal = int(product.bulk_price) * item["quantity"]
                        price = product.bulk_price

                if item["price"] != price:
                    cart = Cart()
                    cart.InitById(item["id"])
                    cart.price = price
                    cart.quantity = item["quantity"]
                    cart.subtotal = subtotal
                    res_edit = cart.Edit()

                    if "success" in res_edit:
                        counter += 1

        return self.ShowSuccessMessage(counter)

