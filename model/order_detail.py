#!/usr/bin/env python

from bson import json_util
from bson.objectid import ObjectId
from basemodel import BaseModel
import psycopg2
import psycopg2.extras

class OrderDetail(BaseModel):

	@property
	def id(self):
	    return self._id
	@id.setter
	def id(self, value):
	    self._id = value
	
	@property
	def order_id(self):
	    return self._order_id
	@order_id.setter
	def order_id(self, value):
	    self._order_id = value
	
	@property
	def product_id(self):
	    return self._product_id
	@product_id.setter
	def product_id(self, value):
	    self._product_id = value
	
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
	def size(self):
	    return self._size
	@size.setter
	def size(self, value):
	    self._size = value
	
	@property
	def price(self):
	    return self._price

	@price.setter
	def price(self, value):
	    self._price = value
	

	def __init__(self):
		BaseModel.__init__(self)
		self._id	= ""
		self._order_id 	= ""
		self._quantity	= ""
		self._product_id = ""
		self._subtotal 	= ""
		self._size = ""
		self._price = ""

	def Save(self):
		#save the object and return the id


		# new_id = db.seq.find_and_modify(query={'seq_name':'order_detail_seq'},update={'$inc': {'id': 1}},fields={'id': 1, '_id': 0},new=True,upsert=True)["id"]

		# object_id = self.collection.insert(
		# 	{
		# 	"id":new_id,
		# 	"order_id":self.order_id,
		# 	"quantity":self.quantity,
		# 	"product_id":self.product_id,
		# 	"subtotal":self.subtotal
		# 	})

		# return str(object_id)

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

		query = '''\
				insert into "Order_Detail" (order_id,
											quantity,
											product_id,
											subtotal,
											size,
											price) 
				values (%(order_id)s,
						%(quantity)s,
						%(product_id)s,
						%(subtotal)s,
						%(size)s,
						%(price)s) 
				returning id'''

		parametros = {
			"order_id":self.order_id,
			"quantity":self.quantity,
			"product_id":self.product_id,
			"subtotal":float(self.subtotal),
			"size":self.size,
			"price": self.price
		}

		try:

			cur.execute(query,parametros)

			self.connection.commit()
			self.id = cur.fetchone()[0]

			return self.ShowSuccessMessage("{}".format(self.id))

		except Exception,e:

			return self.ShowError("Error saving order detail {}".format(str(e)))
		finally:
			cur.close()
			self.connection.close()

	def ListByOrderId(self, order_id, page=1, limit=20):

		skip = (int(page) - 1) * int(limit)

		# order_detail = self.collection.find({"order_id":order_id}).skip(skip).limit(int(limit))

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		try:

			if page == 0 and limit == 0:
				query = '''\
						select od.*,
								p.name,
								p.color 
						from "Order_Detail" od 
						left join "Product" p on od.product_id = p.id 
						where order_id = %(order_id)s'''
				parameters = {
				"order_id":order_id
				}
			else:
				query = '''\
						select od.*,
								p.name,
								p.color 
						from "Order_Detail" od 
						left join "Product" p on od.product_id = p.id 
						where order_id = %(order_id)s 
						limit %(limit)s offset %(offset)s'''
				parameters = {
				"order_id":order_id,
				"limit":int(limit),
				"offset":skip
				}
			cur.execute(query,parameters)
			order_detail = cur.fetchall()
			return order_detail
		except:
			return {}

	def GetDetail(self, _id):

		# order_detail = self.collection.find_one({"id":_id})

		# return json_util.dumps(order_detail)

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

		try:
			query = '''select * from "Order_Detail" where id = %(id)s limit 1'''
			parameters = {
			"id":_id
			}
			cur.execute(query,parameters)
			order_detail = cur.fetchone()
			return order_detail
		except:
			return {}


	def RemoveByOrderId(self,order_id):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

		query = '''delete from "Order_Detail" where order_id = %(order_id)s'''

		parametros = {
		"order_id":order_id
		}

		try:
			cur.execute(query,parametros)
			self.connection.commit()
			return self.ShowSuccessMessage(order_id)
		except Exception,e:
			return self.ShowError("Error deleting contacts by order_id {order_id}, error:{error}".format(user_id=user_id,error=str(e)))