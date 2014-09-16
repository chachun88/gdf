#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basemodel import BaseModel
# from salesmanpermission import SalesmanPermission
# from bson.objectid import ObjectId
import psycopg2
import psycopg2.extras
from datetime import datetime


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
	
	
	
	def __init__(self):
		BaseModel.__init__(self)
		self.table = 'Temp_Cart'
		self._product_id = -1
		self._date = datetime.now()
		self._quantity = 0
		self._subtotal = 0
		self._user_id = -1
		self._size = ''
		self._shipping_id = 0
		self._billing_id = 0
		self._payment_type = 1
		self._shipping_type = 1


	def Remove(self):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
		
		try:
			q = '''update "Temp_Cart" set bought = 1 where id = %(id)s'''
			p = {
			"id":self.id
			}
			cur.execute(q,p)
			self.connection.commit()
			return self.ShowSuccessMessage(str(self.id))
		except Exception, e:
			return self.ShowError(str(e))
		finally:
			cur.close()
			self.connection.close()

	def InitById(self, idd):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		q = '''select * from "Temp_Cart" where id = %(id)s'''
		p = {
		"id":idd
		}
		try:
			cur.execute(q,p)
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

				return self.ShowSuccessMessage("cart has been initizalized successfully")
			else:
				return self.ShowError("user : {} not found".format(idd))
		except Exception,e:
			return self.ShowError("cannot find cart with id {}, error:{}".format(idd,str(e)))

	def Save(self):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		existe = False

		try:
			q = '''select id from "Temp_Cart" where user_id = %(user_id)s and product_id = %(product_id)s and size = %(size)s limit 1'''
			p = {
			"product_id":self.product_id,
			"user_id":self.user_id,
			"size":self.size
			}
			cur.execute(q,p)

			if cur.rowcount > 0:
				self.id = cur.fetchone()[0]
				existe = True

		except Exception, e:
			pass


		if not existe:

			try:
				q = '''insert into "Temp_Cart" (product_id,date,quantity,subtotal,user_id,size) values (%(product_id)s,%(date)s,%(quantity)s,%(subtotal)s,%(user_id)s,%(size)s) returning id'''
				p = {
				"product_id":self.product_id,
				"date":datetime.now(),
				"quantity":self.quantity,
				"subtotal":self.subtotal,
				"user_id":self.user_id,
				"size":self.size
				}
				cur.execute(q,p)
				self.connection.commit()
				self.id = cur.fetchone()[0]

				return self.ShowSuccessMessage(str(self.id))

			except Exception,e:
				return self.ShowError("failed to add item to cart, error:{}".format(str(e)))

			finally:
				cur.close()
				self.connection.close()

		else:

			try:
				q = '''update "Temp_Cart" set quantity = quantity + %(quantity)s, subtotal = subtotal + %(subtotal)s where id = %(id)s returning id'''
				p = {
				"id":self.id,
				"quantity":self.quantity,
				"subtotal":self.subtotal
				}
				cur.execute(q,p)
				self.connection.commit()
				self.id = cur.fetchone()[0]

				return self.ShowSuccessMessage(str(self.id))

			except Exception,e:
				return self.ShowError("failed to update item to cart, error:{}".format(str(e)))

			finally:
				cur.close()
				self.connection.close()

	def GetCartByUserId(self, page=1, items=5, bought=0):

		page = int(page)
		items = int(items)
		offset = (page-1)*items
		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
		try:
			q = '''select tc.id, p.name,tc.size,p.color,tc.quantity,tc.subtotal,p.price, p.image, tc.billing_id, tc.shipping_id, tc.shipping_type, tc.payment_type, tc.product_id from "Temp_Cart" tc left join "Product" p on tc.product_id = p.id left join "Category" c on c.id = p.category_id where tc.user_id = %(user_id)s and tc.bought = %(bought)s limit %(limit)s offset %(offset)s'''
			p = {
			"user_id":self.user_id,
			"limit":items,
			"offset":offset,
			"bought":bought
			}
			cur.execute(q,p)

			lista = cur.fetchall()
			return lista
		except Exception,e:
			print str(e)
			return {}

	def Edit(self):

		parametros = {
			"product_id":self.product_id,
			"quantity":self.quantity,
			"subtotal":self.subtotal,
			"user_id":self.user_id,
			"size":self.size,
			"shipping_id":self.shipping_id,
			"billing_id":self.billing_id,
			"payment_type":self.payment_type,
			"id":self.id,
			"shipping_type":self.shipping_type
		}

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		query = '''update "Temp_Cart" set product_id = %(product_id)s,
		                                  quantity = %(quantity)s,
		                                  subtotal = %(subtotal)s,
		                                  user_id = %(user_id)s,
		                                  size = %(size)s,
		                                  shipping_id = %(shipping_id)s,
		                                  billing_id = %(billing_id)s,
		                                  payment_type = %(payment_type)s,
		                                  shipping_type = %(shipping_type)s
		                            where id = %(id)s and bought = 0'''

		try:
			cur.execute(query,parametros)
			self.connection.commit()

			if cur.rowcount > 0:
				return self.ShowSuccessMessage("cart has been updated successfully")
			else:
				return self.ShowSuccessMessage("no cart to be updated")

		except Exception,e:
			print "Error al editar carro {}".format(str(e))
			return self.ShowError(str(e))






