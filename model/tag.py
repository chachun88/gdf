#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basemodel import BaseModel
import psycopg2
import psycopg2.extras
from datetime import datetime

class Tag(BaseModel):

	@property
	def name(self):
	    return self._name
	@name.setter
	def name(self, value):
	    self._name = value

	
	def __init__(self):
		BaseModel.__init__(self)
		self.table = 'Tag'

	def GetProductsByTags(self,_tags,page=1,items=30):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		page = int(page)
		items = int(items)
		offset = (page-1)*items

		query = '''select product_id from "Tag_Product" tp left join "Tag" t on t.id = tp.tag_id where t.name = any(%(tags)s)'''
		parameters = {
		"tags":_tags
		}

		try:
			cur.execute(query,parameters)
			id_productos = cur.fetchall()

			productos = []

			for p in id_productos:
				productos.append(p['product_id'])

			q = '''select p.*,c.name as category from "Product" p left join "Category" c on c.id = p.category_id where p.id = any(%(productos)s) limit %(items)s offset %(offset)s'''
			p = {
				"productos":productos,
				"items":items,
				"offset":offset
				}

			try:
				cur.execute(q,p)
				products = cur.fetchall()
				return self.ShowSuccessMessage(products)

			except Exception,e:
				return self.ShowError("Error al obtener lista por tags, {}".format(str(e)))
			finally:
				cur.close()
				self.connection.close()

		except Exception,e:
			return self.ShowError("Error al lista de product_id por tags, {}".format(str(e)))
		finally:
			cur.close()
			self.connection.close()

	def GetItemsByTags(self,_tags):
	
		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		query = '''select product_id from "Tag_Product" tp left join "Tag" t on t.id = tp.tag_id where t.name = any(%(tags)s)'''
		parameters = {
		"tags":_tags
		}

		try:
			cur.execute(query,parameters)
			id_productos = cur.fetchall()

			productos = []

			for p in id_productos:
				productos.append(p['id'])

			q = '''select count(*) as cantidad from "Product" where id = any(%(productos)s)'''
			p = {
				"productos":productos
				}

			try:
				cur.execute(q,p)
				items = cur.fetchone()["cantidad"]
				return self.ShowSuccessMessage(items)

			except Exception,e:
				return self.ShowError("Error al obtener cantidad de items por tags, {}".format(str(e)))

			finally:
				cur.close()
				self.connection.close()

		except Exception,e:
			return self.ShowError("Error al lista de product_id por tags, {}".format(str(e)))

		finally:
			cur.close()
			self.connection.close()

	def ListVisibleTags(self):
		
		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		query = '''select * from "Tag" where visible = %(visible)s'''
		parameters = {
		"visible":1
		}

		try:
			cur.execute(query,parameters)
			tags = cur.fetchall()
			return self.ShowSuccessMessage(tags)

		except Exception,e:
			return self.ShowError("Error al lista de product_id por tags, {}".format(str(e)))

		finally:
			cur.close()
			self.connection.close()
		
