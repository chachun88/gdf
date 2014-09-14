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
	

	def __init__(self):
		BaseModel.__init__(self)
		self.table = 'Temp_Cart'
		self._product_id = -1
		self._date = datetime.now()
		self._quantity = 0
		self._subtotal = 0
		self._user_id = -1
		self._size = ''

	def Remove(self):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)
		
		try:
			q = '''delete from "Temp_Cart" where id = %(id)s'''
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

		q = '''select u.*, STRING_AGG(distinct p.name, ',') as permissions_name, STRING_AGG(distinct c.name, ',') as cellars_name from "User" u left join "Permission" p on p.id = any(u.permissions) left join "Cellar" c on c.id = any(u.cellar_permissions) where u.id = %(id)s group by u.id limit 1'''
		p = {
		"id":idd
		}
		try:
			cur.execute(q,p)
			usuario = cur.fetchone()
			if usuario:
				return usuario
			else:
				return self.ShowError("user : " + idd + " not found")
		except:
			return self.ShowError("user : " + idd + " not found")


	def Save(self):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

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


	def GetCartByUserId(self, page=1, items=5):

		page = int(page)
		items = int(items)
		offset = (page-1)*items
		cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)
		try:
			q = '''select tc.id, p.name,tc.size,p.color,tc.quantity,tc.subtotal from "Temp_Cart" tc left join "Product" p on tc.product_id = p.id left join "Category" c on c.id = p.category_id where tc.user_id = %(user_id)s limit %(limit)s offset %(offset)s'''
			p = {
			"user_id":self.user_id,
			"limit":items,
			"offset":offset
			}
			cur.execute(q,p)

			lista = cur.fetchall()
			return lista
		except Exception,e:
			print str(e)
			return {}


