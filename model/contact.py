#!/usr/bin/python
# -*- coding: UTF-8 -*-

# from bson import json_util
# from bson.objectid import ObjectId
from basemodel import BaseModel
import psycopg2
import psycopg2.extras

import json

class Contact(BaseModel):

	@property
	def id(self):
		return self._id
	@id.setter
	def id(self, value):
		self._id = value

	@property
	def customer_id(self):
		return self._customer_id
	@customer_id.setter
	def customer_id(self, value):
		self._customer_id = value

	@property
	def name(self):
		return self._name
	@name.setter
	def name(self, value):
		self._name = value
	
	@property
	def type(self):
		return self._type
	@type.setter
	def type(self, value):
		self._type = value
	
	@property
	def address(self):
		return self._address
	@address.setter
	def address(self, value):
		self._address = value
	
	@property
	def telephone(self):
		return self._telephone
	@telephone.setter
	def telephone(self, value):
		self._telephone = value
	
	@property
	def email(self):
		return self._email
	@email.setter
	def email(self, value):
		self._email = value

	@property
	def lastname(self):
	    return self._lastname
	@lastname.setter
	def lastname(self, value):
	    self._lastname = value
	

	def __init__(self):
		BaseModel.__init__(self)
		self._id = ""
		self._name = ""
		self._type = ""
		self._telephone = ""
		self._email = ""
		self._address = ""
		self._customer_id = ""
		self._lastname = ""

	def InitById(self, _id):

		# contact = self.collection.find_one({"id":int(_id)})

		# if contact:
		# 	return contact
		# else:
		# 	return ""

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		query = '''select * from "Contact" where id = %(id)s limit 1'''

		parametros = {
		"id":_id
		}

		try:
			cur.execute(query,parametros)
			contact = cur.fetchone()
			return json.dumps(contact)
		except:
			return ""

	def Save(self):

		#new_id = db.seq.find_and_modify(query={'seq_name':'contact_seq'},update={'$inc': {'id': 1}},fields={'id': 1, '_id': 0},new=True,upsert=True)["id"]

		contact = {
		"name": self.name,
		"type_id": self.type,
		"telephone": self.telephone,
		"email": self.email,
		"customer_id": self.customer_id,
		"address": self.address,
		"lastname": self.lastname
		}

		try:

			# self.collection.insert(contact)
			cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)
			query = '''insert into "Contact" (name,type_id,telephone,email,customer_id,address)
			values (%(name)s,%(type_id)s,%(telephone)s,%(email)s,%(customer_id)s,%(address)s) returning id'''
			cur.execute(query,contact)
			self.connection.commit()
			new_id = cur.fetchone()[0]
			return new_id

		except Exception, e:

			return str(e)

	def Edit(self):

		print "Edit WS id:{}\n".format(self.id)

		contact = {
		"name": self.name,
		"type_id": self.type,
		"telephone": self.telephone,
		"email": self.email,
		"customer_id": self.customer_id,
		"address":self.address,
		"id":self.id,
		"lastname":self.lastname
		}

		# try:
		# 	self.collection.update({"id":int(self.id)},{"$set":contact})
		# 	return self.id
		# except Exception, e:

		# 	return str(e)

		try:

			# self.collection.insert(contact)
			cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)
			query = '''update "Contact" set name = %(name)s, type_id = %(type_id)s, telephone = %(telephone)s, email = %(email)s, customer_id = %(customer_id)s
		, address = %(address)s, lastname = %(lastname)s where id = %(id)s'''
			print cur.mogrify(query,contact)
			cur.execute(query,contact)
			self.connection.commit()
			return self.ShowSuccessMessage("{}".format(self.id))

		except Exception, e:

			return self.ShowError(str(e))

	def ListByCustomerId(self, _customer_id):

		# contacts = self.collection.find({"customer_id":_customer_id})

		# if contacts:
		# 	return contacts
		# else:
		# 	return []

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

		try:

		
			query = '''select * from "Contact" where customer_id = %(customer_id)s'''
			parametros = {
			"customer_id":_customer_id
			}
			cur.execute(query,parametros)
			contactos = cur.fetchall()

			if contactos:
				return contactos
			else:
				return []

		except:

			return []

	def Remove(self,ids):
		print ids
		# self.collection.remove({"id":{"$in":[int(n) for n in ids.split(",")]}})

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

		query = '''delete from "Contact" where id in %(id)s'''

		parametros = {
		"id":[int(n) for n in ids.split(",")]
		}

		try:
			cur.execute(query,parametros)
			self.connection.commit()
		except:
			pass