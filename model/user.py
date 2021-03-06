#!/usr/bin/python
# -*- coding: UTF-8 -*-

from lp.model.basemodel import BaseModel as lp_model
from basemodel import BaseModel
# from salesmanpermission import SalesmanPermission
# from bson.objectid import ObjectId
import psycopg2
import psycopg2.extras
from datetime import datetime
from sendpassword import Email
import random
import hashlib
import pytz
from bson import json_util
from lp.globals import enviroment, Enviroment


class UserType(object):

    VENDEDOR = "Vendedor"
    ADMINISTRADOR = "Administrador"
    CLIENTE = "Cliente"
    EMPRESA = "Cliente Mayorista"
    VISITA = "Visita"
    BODEGA = "Bodega"


class User(BaseModel):

    PENDIENTE = 1
    ACEPTADO = 2

    def __init__(self):
        BaseModel.__init__(self)
        # self.collection = db.salesman
        self.table = 'User'
        self._salesman_id = ''
        self._name = ''
        self._password = '' 
        self._email = ''
        self._permissions = []
        self._cellars = []
        self._permissions_name = []
        self._cellars_name = []
        self._user_type = UserType.VISITA  # se debe pasar el nombre del tipo de usuario, no el id
        self._bussiness = ''
        self._rut = ''
        self._status = User.PENDIENTE

    @property
    def salesman_id(self):
        return self._salesman_id

    @salesman_id.setter
    def salesman_id(self, value):
        self._salesman_id = value   

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value

    @property
    def password(self):
        return self._password

    @password.setter
    def password(self, value):
        self._password = value

    @property
    def email(self):
        return self._email

    @email.setter
    def email(self, value):
        self._email = value

    @property
    def permissions(self):
        return self._permissions

    @permissions.setter
    def permissions(self, value):
        self._permissions = value

    @property
    def user_type(self):
        return self._user_type

    @user_type.setter
    def user_type(self, value):
        self._user_type = value

    @property
    def permissions_name(self):
        return self._permissions_name

    @permissions_name.setter
    def permissions_name(self, value):
        self._permissions_name = value

    @property
    def cellars(self):
        return self._cellars

    @cellars.setter
    def cellars(self, value):
        self._cellars = value

    @property
    def cellars_name(self):
        return self._cellars_name

    @cellars_name.setter
    def cellars_name(self, value):
        self._cellars_name = value

    @property
    def bussiness(self):
        return self._bussiness

    @bussiness.setter
    def bussiness(self, value):
        self._bussiness = value

    @property
    def rut(self):
        return self._rut

    @rut.setter
    def rut(self, value):
        self._rut = value

    @property
    def status(self):
        return self._status

    @status.setter
    def status(self, value):
        self._status = value 

    def Print(self):
        return {
            "id":self.id,
            "name":self.name,
            "email":self.email,
            "password":self.password,
            "permissions":self.permissions,
            "salesman_id":self.salesman_id,
            "permissions_name":self.permissions_name,
            "cellars":self.cellars,
            "cellars_name":self.cellars_name,
            "bussiness": self.bussiness,
            "rut": self.rut
        }

    def Remove(self):
        try:
            return BaseModel.Remove(self)
        except Exception, e:
            return self.ShowError("error removing user, {}".format(str(e)))

    def Login(self, username, password):
        # data = self.collection.find({"email":username, "password":password})

        # if data.count() >= 1:
        #   self.InitByEmail(username) ## init user
        #   return True
        # return False

        m = hashlib.md5()
        m.update(password)
        password = m.hexdigest()

        q = '''\
            select u.*, 
                STRING_AGG(distinct p.name, ',') as permissions_name, 
                STRING_AGG(distinct c.name, ',') as cellars_name 
            from "User" u 
            left join "Permission" p on p.id = any(u.permissions) 
            left join "Cellar" c on c.id = any(u.cellar_permissions) 
            where u.email = %(email)s and 
                u.password = %(password)s and
                u.status = %(status)s and
                u.type_id = any(%(user_type)s)
            group by u.id limit 1'''

        p = {
            "email":username,
            "password":password,
            "status": self.ACEPTADO,
            "user_type": [self.getUserTypeID(UserType.CLIENTE),self.getUserTypeID(UserType.VISITA)]
        }

        # print lp_model.mogrify(q,p)

        try:
            # print curs.mogrify( q, p )
            user = lp_model.execute_query(q, p)

            if len(user) > 0:
                user = user[0]

                self.updateLastView(user['id'], datetime.now(pytz.timezone('Chile/Continental')).isoformat())

                return self.ShowSuccessMessage(json_util.dumps(user))
            else:
                return self.ShowError("usuario y contraseña no coinciden o no tiene permiso para acceder".format(lp_model.mogrify(q,p)))
        except Exception,e:
            return self.ShowError("cannot login user: {}".format(str(e)))

    def getUserTypeID(self, user_type):

        query = '''SELECT id FROM "User_Types" WHERE name = %(name)s'''
        params = {"name" : user_type}
        return lp_model.execute_query(query, params)[0]["id"]

    def updateLastView(self, identifier, last_view):

        try:
            query = '''update "User" set last_view = %(last_view)s where id = %(identifier)s'''
            params = {
                "identifier": identifier,
                "last_view": last_view
            }
            # print lp_model.mogrify(query, params)
            lp_model.execute_query_real(query, params)
        except Exception, e:
            # print str(e)
            pass

    def InitByEmail(self, email):

        # try:
        #   data = self.collection.find({"email":email})
        #   if data.count() >= 1:
        #       self.name       = data[0]["name"]
        #       self.password   = data[0]["password"]
        #       self.email      = email
        #       self.identifier = str(data[0]["_id"])
        #       self.permissions= data[0]["permissions"]
        #       self.id         = data[0]["salesman_id"]

        #       return self.ShowSuccessMessage("user initialized")
        #   else:
        #       raise
        # except Exception, e:
        #   return self.ShowError("user : " + email + " not found")

        type_id = self.getUserTypeID(self.user_type)

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        q = '''\
            select u.*, 
                STRING_AGG(distinct p.name, ',') as permissions_name, 
                STRING_AGG(distinct c.name, ',') as cellars_name 
            from "User" u 
            left join "Permission" p on p.id = any(u.permissions) 
            left join "Cellar" c on c.id = any(u.cellar_permissions) 
            where u.email = %(email)s 
            and %(type_id)s = any(%(types)s)
            and u.status = %(status)s
            group by u.id limit 1'''
        p = {
            "email":email,
            "type_id": type_id,
            "status": self.ACEPTADO,
            "types": [self.getUserTypeID(UserType.VISITA),
                      self.getUserTypeID(UserType.CLIENTE)]
        }
        try:
            cur.execute(q,p)
            usuario = cur.fetchone()
            if cur.rowcount > 0:
                return self.ShowSuccessMessage(json_util.dumps(usuario))
            else:
                return self.ShowError("user : " + email + " not found")
        except Exception, e:
            return self.ShowError("user : {} not found, {}".format(email, str(e)))

    def InitById(self, idd):

        # try:
        #   data = self.collection.find({"_id":ObjectId(idd)})
        #   if data.count() >= 1:
        #       self.name       = data[0]["name"]
        #       self.password   = data[0]["password"]
        #       self.email      = data[0]["email"]
        #       self.identifier = str(data[0]["_id"])
        #       self.permissions=  data[0]["permissions"]
        #       self.id         = data[0]["salesman_id"]

        #       return self.ShowSuccessMessage("user initialized")
        #   else:
        #       raise
        # except Exception, e:
        #   return self.ShowError("user : " + idd + " not found")

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)

        q = '''\
            select u.*, 
                STRING_AGG(distinct p.name, ',') as permissions_name, 
                STRING_AGG(distinct c.name, ',') as cellars_name 
            from "User" u 
            left join "Permission" p on p.id = any(u.permissions) 
            left join "Cellar" c on c.id = any(u.cellar_permissions) 
            where u.id = %(id)s 
            group by u.id limit 1'''
        p = {
            "id":idd
        }
        try:
            # print cur.mogrify(q, p)
            cur.execute(q,p)
            if cur.rowcount > 0:
                usuario = cur.fetchone()
                return usuario
            else:
                return self.ShowError("user : {} not found".format(idd))
        except Exception, e:
            return self.ShowError("user : {} not found, {}".format(idd, str(e)))

    def GetPermissions(self):
        return self._permissions.FindPermissions(self.id)

    def AssignPermission(self, permission):
        # TODO: validate if permission exist
        self._permissions.salesman_id   = self.id
        self._permissions.permission_id = permission
        return self._permissions.Save()

    def RemovePermission(self, permission):
        self._permissions.salesman_id = self.id
        self._permissions.permission_id = permission
        return self._permissions.RemovePermission()

    def Save(self):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        q = '''select id from "User_Types" where name = %(name)s'''
        p = {
            "name": self.user_type
        }
        try:
            # print cur.mogrify(q, p)
            cur.execute(q,p)
            tipo_usuario = cur.fetchone()["id"]
            self.connection.commit()
        except Exception, e:
            print "qqqq {}".format(str(e))
        finally:
            cur.close()
            self.connection.close()

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        q = '''select id from "Permission" where name = any(%(permissions)s)'''
        p = {
            "permissions":self.permissions
        }

        try:
            cur.execute(q,p)
            permisos = cur.fetchall()
        except Exception, e:
            print str(e)
        finally:
            cur.close()
            self.connection.close()

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        if self.user_type != UserType.VISITA:

            if self.user_type == UserType.EMPRESA:

                q = '''\
                select * from "User" 
                where rut = %(rut)s 
                and type_id = %(type_id)s limit 1'''
                p = {
                    "rut":self.rut,
                    "type_id": tipo_usuario
                }
            else:
                q = '''\
                    select * from "User" 
                    where email = %(email)s 
                    and type_id = %(type_id)s limit 1'''
                p = {
                    "email":self.email,
                    "type_id": tipo_usuario
                }

            try:
                cur.execute(q,p)
                usuario = cur.fetchone()

                if cur.rowcount > 0:

                    if self.user_type == UserType.EMPRESA:
                        return self.ShowError("Su cuenta empresa ya está registrada, por favor inicie sesión o contáctese con nosotros")

                    self.id = usuario['id']

                    m = hashlib.md5()

                    m.update(self.password)

                    password = m.hexdigest()

                    try:

                        q = '''\
                            update "User" 
                            set name = %(name)s, 
                                password = %(password)s, 
                                email = %(email)s, 
                                permissions = %(permissions)s, 
                                type_id = %(type_id)s,
                                rut = %(rut)s,
                                bussiness = %(bussiness)s 
                            where id = %(id)s'''
                        p = {
                            "name":self.name,
                            "email":self.email,
                            "permissions":permisos,
                            "password":password,
                            "id":self.id,
                            "type_id":tipo_usuario,
                            "rut": self.rut,
                            "bussiness": self.bussiness
                        }
                        cur.execute(q,p)
                        self.connection.commit()

                        return self.ShowSuccessMessage(str(self.id))
                    except Exception, e:
                        return self.ShowError(str(e))
                    finally:
                        self.connection.close()
                        cur.close()

                elif self.id != "":

                    m = hashlib.md5()

                    m.update(self.password)

                    password = m.hexdigest()

                    try:

                        q = '''\
                            update "User" 
                            set name = %(name)s, 
                                password = %(password)s, 
                                email = %(email)s,
                                permissions = %(permissions)s, 
                                type_id = %(type_id)s,
                                rut = %(rut)s,
                                bussiness = %(bussiness)s
                            where id = %(id)s'''
                        p = {
                            "name":self.name,
                            "email":self.email,
                            "permissions":permisos,
                            "password":password,
                            "type_id":tipo_usuario,
                            "id":self.id,
                            "rut": self.rut,
                            "bussiness": self.bussiness
                        }

                        cur.execute(q,p)
                        self.connection.commit()
                        return self.ShowSuccessMessage(str(self.id))
                    except Exception,e:
                        return self.ShowError(str(e))
                    finally:
                        self.connection.close()
                        cur.close()

                else:

                    m = hashlib.md5()

                    m.update(self.password)

                    password = m.hexdigest()

                    try:

                        q = '''\
                            insert into "User" (name,
                                                password,
                                                email,
                                                permissions,
                                                type_id,
                                                rut,
                                                bussiness,
                                                status) 
                            values (%(name)s,
                                    %(password)s,
                                    %(email)s,
                                    %(permissions)s,
                                    %(type_id)s,
                                    %(rut)s,
                                    %(bussiness)s,
                                    %(status)s) 
                            returning id'''
                        p = {
                            "name":self.name,
                            "email":self.email,
                            "permissions":permisos,
                            "password":password,
                            "type_id":tipo_usuario,
                            "rut": self.rut,
                            "bussiness": self.bussiness,
                            "status": self.status
                        }
                        cur.execute(q,p)
                        self.connection.commit()
                        self.id = cur.fetchone()["id"]
                        return self.ShowSuccessMessage(str(self.id))
                    except Exception,e:
                        return self.ShowError("failed to save user {}, error:{}".format(self.email,str(e)))
                    finally:
                        self.connection.close()
                        cur.close()
            except Exception, e:
                return self.ShowError(str(e))
            finally:
                self.connection.close()
                cur.close()
        else:

            try:

                m = hashlib.md5()

                m.update(self.password)

                password = m.hexdigest()

                q = '''\
                    insert into "User" (name, 
                                        password, 
                                        email, 
                                        permissions, 
                                        type_id,
                                        status) 
                    values (%(name)s,
                            %(password)s,
                            %(email)s,
                            %(permissions)s,
                            %(type_id)s,
                            %(status)s) 
                    returning id'''
                p = {
                    "name":self.name,
                    "email":self.email,
                    "permissions":permisos,
                    "password":password,
                    "type_id":tipo_usuario,
                    "status":User.ACEPTADO
                }
                cur.execute(q,p)
                self.connection.commit()
                self.id = cur.fetchone()["id"]

                return self.ShowSuccessMessage(str(self.id))

            except Exception,e:
                return self.ShowError("failed to save user {}, error:{}".format(self.email,str(e)))
            finally:
                self.connection.close()
                cur.close()   

    def GetList(self, page, items):

        page = int(page)
        items = int(items)
        offset = (page-1)*items
        cur = self.connection.cursor(cursor_factory=psycopg2.extras.DictCursor)
        try:
            q = '''\
                select u.*, STRING_AGG(distinct p.name, ',') as permissions_name, 
                STRING_AGG(distinct c.name, ',') as cellars_name 
                from "User" u 
                left join "Permission" p on p.id = any(u.permissions) 
                left join "Cellar" c on c.id = any(u.cellar_permissions) 
                group by u.id 
                limit %(limit)s offset %(offset)s'''
            p = {
                "limit":items,
                "offset":offset
            }
            cur.execute(q,p)

            lista = cur.fetchall()
            return lista
        except Exception,e:
            return {}

    def Exist(self, email='', _id=0):


        if email != "":

            cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

            q = '''\
                select count(*) as cnt from "User" 
                where email = %(email)s 
                and type_id = any(%(type_id)s)
                and status = %(status)s'''

            p = { 
                "email" : email,
                "type_id": [self.getUserTypeID(UserType.CLIENTE), 
                            self.getUserTypeID(UserType.VISITA)],
                "status": self.ACEPTADO
            }

            try:
                # print cur.mogrify(q, p)
                cur.execute( q, p )
                data = cur.fetchone()
                if data["cnt"] > 0:
                    return self.ShowSuccessMessage(True)
                else:
                    return self.ShowSuccessMessage(False)
            except Exception, e:
                print "exists, {}".format(str(e))
                return self.ShowError(str(e))
            finally:
                cur.close()
                self.connection.close()

        if _id != 0:

            cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

            q = '''select count(*) as cnt from "User" where id = %(id)s and (type_id = %(user_type)s or type_id = %(user_type_visita)s)'''
            p = { 
                "id": _id,
                "user_type": self.getUserTypeID(UserType.CLIENTE),
                "user_type_visita": self.getUserTypeID(UserType.VISITA)
            }

            try:
                cur.execute(q,p)
                data = cur.fetchone()
                if data["cnt"] > 0:
                    return self.ShowSuccessMessage(True)
                else:
                    return self.ShowSuccessMessage(False)
            except Exception,e:
                return self.ShowError(str(e))
            finally:
                cur.close()
                self.connection.close()

        

    def RandomPass(self):

        alphabet = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        pw_length = 8
        mypw = ""

        for i in range(pw_length):
            next_index = random.randrange(len(alphabet))
            mypw = mypw + alphabet[next_index]

        return mypw

    def PassRecovery( self, email ):
        try:
            exists = self.Exist( email )

            if "success" in exists:
                if exists["success"]:

                    password = ""
                    user_id = ""

                    p = ''' select name, password, id from "User" 
                    where email = %(email)s 
                    and (type_id = %(user_type)s or type_id = %(user_type_visita)s)'''
                    q = {
                        "email": email,
                        "user_type": self.getUserTypeID(UserType.CLIENTE),
                        "user_type_visita": self.getUserTypeID(UserType.VISITA)
                    }

                    cur = self.connection.cursor(  cursor_factory=psycopg2.extras.RealDictCursor )

                    cur.execute(p,q)
                    data = cur.fetchone()

                    password = data["password"]
                    user_id = "{}".format(data["id"])
                    name = data["name"]

                    new_password = self.RandomPass()

                    m = hashlib.md5()

                    m.update(new_password)

                    password = m.hexdigest()

                    self.ChangePassword(user_id,password)

                    Email( email, user_id, new_password, name )

                    return True

                else:
                    return False
            else:
                print exists["error"]
                raise Exception( "no se ha podido recuperar la contraseña, {}".format(exists["error"]) )
        except Exception, e:
            print "no se ha podido recuperar la contrasena : {}".format(str( e ))
            raise Exception( "no se ha podido recuperar la contraseña" )

    def ChangePassword(self, id, password):
        try:

            p = '''\
                update "User" 
                set password = %(password)s 
                where id = %(id)s and type_id = any(%(type_id)s)'''
            q = { 
                "id": id, 
                "password" : password,
                "type_id": [
                    self.getUserTypeID(UserType.CLIENTE), 
                    self.getUserTypeID(UserType.VISITA),
                    self.getUserTypeID(UserType.EMPRESA)
                ]
            }

            # c

            cur = self.connection.cursor( cursor_factory=psycopg2.extras.DictCursor )
            cur.execute( p,q )
            self.connection.commit()

        except Exception, e:
            print str( e )
            raise Exception( "no se ha podido cambiar la contraseña" )

    def GetUserId( self, email ):
        try:
            p = ''' select id from "User" where email = %(email)s '''
            q = {"email":email}

            cur = self.connection.cursor( cursor_factory=psycopg2.extras.DictCursor )
            cur.execute( p, q )

            data = cur.fetchone()

            return data[0]

        except Exception,e:
            print str( e )

    def enterpriseLogin(self, username, password):

        m = hashlib.md5()

        m.update(password)

        password = m.hexdigest()

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        q = '''\
            select u.*, 
                STRING_AGG(distinct p.name, ',') as permissions_name, 
                STRING_AGG(distinct c.name, ',') as cellars_name 
            from "User" u 
            left join "Permission" p on p.id = any(u.permissions) 
            left join "Cellar" c on c.id = any(u.cellar_permissions) 
            where lower(replace(replace(u.rut, '.', ''), '-', '')) = %(rut)s and 
                u.password = %(password)s and
                u.status = %(status)s and
                u.type_id = %(type_id)s
            group by u.id limit 1'''
        p = {
            "rut": username,
            "password": password,
            "status": self.ACEPTADO,
            "type_id": self.getUserTypeID(UserType.EMPRESA)
        }
        try:
            # print curs.mogrify( q, p )
            cur.execute(q,p)
            user = cur.fetchone()
            if cur.rowcount > 0:
                self.updateLastView(user["id"], datetime.now(pytz.timezone('Chile/Continental')).isoformat())
                return self.ShowSuccessMessage(json_util.dumps(user))
            else:
                return self.ShowError("usuario y contraseña no coinciden o no tiene permiso para acceder")
        except Exception,e:
            return self.ShowError("cannot login user: {}".format(str(e)))
