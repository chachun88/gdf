#!/usr/bin/python
# -*- coding: UTF-8 -*-

from bson import json_util
# from bson.objectid import ObjectId
from basemodel import BaseModel
import psycopg2
import psycopg2.extras

class Contact(BaseModel):

	@property
	def id(self):
		return self._id
	@id.setter
	def id(self, value):
		self._id = value

	@property
	def user_id(self):
		return self._user_id
	@user_id.setter
	def user_id(self, value):
		self._user_id = value

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

	@property
	def city(self):
	    return self._city
	@city.setter
	def city(self, value):
	    self._city = value
	
	@property
	def zip_code(self):
	    return self._zip_code
	@zip_code.setter
	def zip_code(self, value):
	    self._zip_code = value

	@property
	def additional_info(self):
	    return self._additional_info
	@additional_info.setter
	def additional_info(self, value):
	    self._additional_info = value

	@property
	def town(self):
	    return self._town
	@town.setter
	def town(self, value):
	    self._town = value
	
	
	

	def __init__(self):
		BaseModel.__init__(self)
		self._id = ""
		self._name = ""
		self._type = 3
		self._telephone = ""
		self._email = ""
		self._address = ""
		self._user_id = ""
		self._lastname = ""
		self._city = ""
		self._zip_code = ""
		self._additional_info = ""
		self._town = ""

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
			return json_util.dumps(contact)
		except:
			return ""

	def Save(self):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		contact = {
		"name": self.name,
		"type_id": self.type,
		"telephone": self.telephone,
		"email": self.email,
		"user_id": self.user_id,
		"address": self.address,
		"lastname": self.lastname,
		"city": self.city,
		"zip_code": self.zip_code,
		"additional_info":self.additional_info,
		"town":self.town
		}

		query = '''select id from "Contact" where name = %(name)s and email = %(email)s and address = %(address)s'''

		try:
			cur.execute(query,contact)
			if cur.rowcount > 0:
				self.id = int(cur.fetchone()["id"])
				return self.ShowSuccessMessage("{}".format(self.id))
		except Exception,e:
			return self.ShowError("Error al obtener contacto {}".format(str(e)))

		
			
		if self.id == "":

			query = '''insert into "Contact" (name,type_id,telephone,email,user_id,address, lastname, city, zip_code,additional_info,town)
			values (%(name)s,%(type_id)s,%(telephone)s,%(email)s,%(user_id)s,%(address)s,%(lastname)s,%(city)s,%(zip_code)s,%(additional_info)s,%(town)s) returning id'''
		
			# return self.ShowError(cur.mogrify(query,contact))

			try:
				cur.execute(query,contact)
				self.connection.commit()
				self.id = cur.fetchone()["id"]
				return self.ShowSuccessMessage("{}".format(self.id))
			except Exception, e:

				return self.ShowError(str(e))

		

		

	def Edit(self):

		#print "Edit WS id:{}\n".format(self.id)

		contact = {
		"name": self.name,
		"type_id": self.type,
		"telephone": self.telephone,
		"email": self.email,
		"user_id": self.user_id,
		"address":self.address,
		"id":self.id,
		"city":self.city,
		"zip_code":self.zip_code,
		"lastname":self.lastname,
		"additional_info":self.additional_info,
		"town":self.town
		}

		# try:
		# 	self.collection.update({"id":int(self.id)},{"$set":contact})
		# 	return self.id
		# except Exception, e:

		# 	return str(e)

		try:

			# self.collection.insert(contact)
			cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)
			query = '''update "Contact" set 
										name = %(name)s, 
										type_id = %(type_id)s, 
										telephone = %(telephone)s, 
										email = %(email)s, 
										user_id = %(user_id)s, 
										address = %(address)s, 
										lastname = %(lastname)s,
										zip_code = %(zip_code)s,
										additional_info = %(additional_info)s,
										town = %(town)s
						where id = %(id)s'''

			cur.execute(query,contact)
			self.connection.commit()
			return self.ShowSuccessMessage("{}".format(self.id))

		except Exception, e:

			return self.ShowError(str(e))

	def ListByUserId(self, _user_id):

		# contacts = self.collection.find({"user_id":_user_id})

		# if contacts:
		# 	return contacts
		# else:
		# 	return []

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

		try:

			query = '''select * from "Contact" where user_id = %(user_id)s'''
			parametros = {
			"user_id":_user_id
			}
			cur.execute(query,parametros)
			contactos = cur.fetchall()

			if cur.rowcount > 0:
				return self.ShowSuccessMessage(json_util.dumps(contactos))
			else:
				return self.ShowError("No se han encontrado contactos")

		except Exception,e:
			return self.ShowError(str(e))
			

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

	def RemoveByUserId(self,user_id):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

		query = '''delete from "Contact" where user_id = %(user_id)s'''

		parametros = {
		"user_id":user_id
		}

		try:
			cur.execute(query,parametros)
			self.connection.commit()
			return self.ShowSuccessMessage(user_id)
		except Exception,e:
			return self.ShowError("Error deleting contacts by user_id {user_id}, error:{error}".format(user_id=user_id,error=str(e)))