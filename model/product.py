#!/usr/bin/python
# -*- coding: UTF-8 -*-
import psycopg2
import psycopg2.extras
import json

from basemodel import BaseModel

class Product(BaseModel):
	def __init__(self):
		BaseModel.__init__(self)
		self._name = '' #nombre de producto
		self._sku = '' #id de producto
		self._description = '' #descripcion de producto
		self._brand = '' #marca de producto
		self._manufacturer = '' #proveedor
		self._size = [] #tallas
		self._color = [] #color
		self._material = '' #material
		self._bullet_1 = '' #viñeta 1
		self._bullet_2 = '' #viñeta 2
		self._bullet_3 = '' #viñeta 3
		self._currency = '' #divisa
		self._image = '' #imagen 1
		self._image_2 = '' #imagen 2
		self._image_3 = '' #imagen 3
		self._category = '' #categoria
		self._upc = '' #articulo
		self._price='' #precio compra
		self._sell_price = 0 #precio venta

	@property
	def upc(self):
	    return self._upc
	@upc.setter
	def upc(self, value):
	    self._upc = value

	@property
	def name(self):
		return self._name
	@name.setter
	def name(self, value):
		self._name = value

	@property
	def sku(self):
		return self._sku
	@sku.setter
	def sku(self, value):
		self._sku = value

	@property
	def description(self):
		return self._description
	@description.setter
	def description(self, value):
		self._description = value

	@property
	def brand(self):
		return self._brand
	@brand.setter
	def brand(self, value):
		self._brand = value

	@property
	def manufacturer(self):
		return self._manufacturer
	@manufacturer.setter
	def manufacturer(self, value):
		self._manufacturer = value

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
	def material(self):
		return self._material
	@material.setter
	def material(self, value):
		self._material = value

	@property
	def bullet_1(self):
		return self._bullet_1
	@bullet_1.setter
	def bullet_1(self, value):
		self._bullet_1 = value

	@property
	def bullet_2(self):
		return self._bullet_2
	@bullet_2.setter
	def bullet_2(self, value):
		self._bullet_2 = value

	@property
	def bullet_3(self):
		return self._bullet_3
	@bullet_3.setter
	def bullet_3(self, value):
		self._bullet_3 = value

	@property
	def currency(self):
		return self._currency
	@currency.setter
	def currency(self, value):
		self._currency = value

	@property
	def image(self):
		return self._image
	@image.setter
	def image(self, value):
		self._image = value

	@property
	def image_2(self):
		return self._image_2
	@image_2.setter
	def image_2(self, value):
		self._image_2 = value

	@property
	def image_3(self):
		return self._image_3
	@image_3.setter
	def image_3(self, value):
		self._image_3 = value

	@property
	def category(self):
		return self._category
	@category.setter
	def category(self, value):
		self._category = value

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

	def GetList(self, page=1, items=30):

		page = int(page)
		items = int(items)
		offset = (page-1)*items
		cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)
		try:
			q = '''select p.*,c.name as category from "Product" p left join "Category" c on c.id = p.category_id  limit %(items)s offset %(offset)s'''
			p = {
				"items":items,
				"offset":offset
				}
			cur.execute(q,p)
			lista = cur.fetchall()
			return lista
		except Exception,e:
			print str(e)
			return {}
		finally:
			cur.close()
			self.connection.close()

	def InitBySku(self, sku):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		q = '''select p.*,c.name as category from "Product" p left join "Category" c on c.id = p.category_id where p.sku = %(sku)s limit 1'''
		p = {
		"sku":sku
		}
		try:
			cur.execute(q,p)
			producto = cur.fetchone()

			if cur.rowcount > 0:
				return json.dumps(producto)
			else:
				return self.ShowError("product not found")
		except Exception,e:
			return self.ShowError("product cannot be initialized:{}".format(str(e)))
		finally:
			cur.close()
			self.connection.close()
		

	def InitById(self, identifier):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		q = '''select p.*,c.name as category from "Product" p left join "Category" c on c.id = p.category_id where p.id = %(id)s limit 1'''
		p = {
		"id":identifier
		}
		try:
			cur.execute(q,p)
			producto = cur.fetchone()

			if cur.rowcount > 0:
				return json.dumps(producto)
			else:
				return self.ShowError("product cannot be initialized")
		except Exception,e:
			return self.ShowError("product cannot be initialized, error: {}".format(str(e)))
		finally:
			cur.close()
			self.connection.close()

	def GetCombinations(self,name):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
		q = '''select p.*,c.name as category from "Product" p left join "Category" c on c.id = p.category_id where p.name = %(name)s limit 4'''
		p = {
		"name":name
		}
		try:
			cur.execute(q,p)
			combinations = cur.fetchall()
			return combinations
		except Exception,e:
			print "cannot get combinations:{}".format(str(e))
			return {}
		finally:
			cur.close()
			self.connection.close()

	def GetRandom(self):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
		q = '''SELECT * FROM "Product" OFFSET random()*(select count(*) from "Product") LIMIT 4'''
		try:
			cur.execute(q)
			randomized = cur.fetchall()
			return randomized
		except Exception,e:
			print str(e)
			return {}
		finally:
			cur.close()
			self.connection.close()