#!/usr/bin/python
# -*- coding: UTF-8 -*-
import psycopg2
import psycopg2.extras

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
			self.connection.close()