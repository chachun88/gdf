#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basemodel import BaseModel
import psycopg2
import psycopg2.extras


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

    def GetProductsByTags(self, cellar_id, _tags, page=1, items=30):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        page = int(page)
        items = int(items)
        offset = (page-1)*items

        query = '''\
                select tp.product_id from "Tag_Product" tp 
                left join "Tag" t on t.id = tp.tag_id 
                left join "Product" p on p.id = tp.product_id 
                inner join (select distinct on(product_sku) product_sku, 
                                                            balance_units, 
                                                            date 
                            from "Kardex" 
                            where cellar_id = %(cellar_id)s
                            order by product_sku, date desc) k on k.product_sku = p.sku
                where t.name = any(%(tags)s) and p.for_sale = 1 and k.balance_units > 0'''
        parameters = {
            "tags":_tags,
            "cellar_id": cellar_id
        }

        productos = []
        id_productos = []

        try:
            cur.execute(query,parameters)
            id_productos = cur.fetchall()

            for p in id_productos:
                productos.append(p['product_id'])

            q = '''select p.*,c.name as category from "Product" p 
            left join "Category" c on c.id = p.category_id 
            where p.id = any(%(productos)s) limit %(items)s offset %(offset)s'''
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
            return self.ShowError("Error al listar product_id por tags, {}".format(str(e)))
        finally:
            cur.close()
            self.connection.close()

    def GetItemsByTags(self, cellar_id, _tags):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        query = '''\
                select tp.product_id from "Tag_Product" tp 
                left join "Tag" t on t.id = tp.tag_id 
                left join "Product" p on p.id = tp.product_id 
                inner join (select distinct on(product_sku) product_sku, 
                                                            balance_units, 
                                                            date 
                            from "Kardex" 
                            where cellar_id = %(cellar_id)s
                            order by product_sku, date desc) k on k.product_sku = p.sku
                where t.name = any(%(tags)s) and p.for_sale = 1 and k.balance_units > 0'''
        parameters = {
            "tags":_tags,
            "cellar_id": cellar_id
        }

        try:
            cur.execute(query,parameters)
            id_productos = cur.fetchall()

            productos = []

            for p in id_productos:
                productos.append(p['product_id'])

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
            return self.ShowError("Error al listar product_id por tags, {}".format(str(e)))

        finally:
            cur.close()
            self.connection.close()

    def ListVisibleTags(self, tags=[]):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        query = '''select * from "Tag" where visible = %(visible)s'''

        parameters = {
            "visible":1
        }

        if len(tags) > 0:
            query += ''' and name = any(%(tags)s)'''
            parameters["tags"] = tags

        try:
            cur.execute(query,parameters)
            tags = cur.fetchall()
            return self.ShowSuccessMessage(tags)

        except Exception,e:
            return self.ShowError("Error al lista de product_id por tags, {}".format(str(e)))

        finally:
            cur.close()
            self.connection.close()

    def GetTagsByProductId(self,_id):

        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        query = '''select * from "Tag" t left join "Tag_Product" tp on tp.tag_id = t.id where tp.product_id = %(id)s'''
        parameters = {
            "id":_id
        }

        try:
            cur.execute(query,parameters)
            tags = cur.fetchall()
            return self.ShowSuccessMessage(tags)
        except Exception,e:
            return self.ShowError("Error al buscar tags por product_id: {}".format(str(e)))
        finally:
            self.connection.close()
            cur.close()
