#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basemodel import BaseModel
# from salesmanpermission import SalesmanPermission
# from bson.objectid import ObjectId
import psycopg2
import psycopg2.extras
from datetime import datetime


class Vote(BaseModel):
	
	@property
	def user_id(self):
	    return self._user_id
	@user_id.setter
	def user_id(self, value):
	    self._user_id = value
	
	@property
	def product_id(self):
	    return self._product_id
	@product_id.setter
	def product_id(self, value):
	    self._product_id = value
	
	
	def __init__(self):
		BaseModel.__init__(self)
		self.table = 'Voto'
		

	def VoteProduct(self, user_id,product_id):

		response = self.IfVoted(user_id,product_id)

		voted = 0

		if "success" in response:
			voted = int(response["success"])

		if voted == 0:

			cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

			query = '''insert into "Voto" (user_id,product_id) values (%(user_id)s,%(product_id)s)'''
			parameters = {
			"product_id":product_id,
			"user_id":user_id
			}

			try:
				cur.execute(query,parameters)
				self.connection.commit()
				return self.ShowSuccessMessage("Voto efectuado exitosamente")
			except Exception,e:
				return self.ShowError("on vote product:{}".format(str(e)))
			finally:
				cur.close()
				self.connection.close()
		else:
			return self.ShowError("Usted ya ha votado por esta idea")

	def IfVoted(self, user_id,product_id):

		cursor = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		query = '''select count(*) as cantidad from "Voto" where user_id = %(user_id)s and product_id = %(product_id)s'''
		parameters = {
		"product_id":int(product_id),
		"user_id":int(user_id)
		}

		try:
			cursor.execute(query,parameters)
			cantidad = cursor.fetchone()["cantidad"]
			if cantidad > 0:
				return self.ShowSuccessMessage(1)
			else:
				return self.ShowSuccessMessage(0)
		except Exception,e:
			return self.ShowError("on if voted:{}".format(str(e)))
		finally:
			cursor.close()
			self.connection.close()

		

	def GetVotes(self, product_id):

		cursor = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		query = '''select count(*) as cantidad from "Voto" where product_id = %(product_id)s'''
		parameters = {
		"product_id":int(product_id)
		}

		try:
			print cursor.mogrify(query,parameters)
			cursor.execute(query,parameters)
			cantidad = cursor.fetchone()["cantidad"]
			return self.ShowSuccessMessage(cantidad)
		except Exception,e:
			return self.ShowError("on if voted:{}".format(str(e)))
		finally:
			cursor.close()
			self.connection.close()


