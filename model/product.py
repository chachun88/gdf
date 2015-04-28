#!/usr/bin/python
# -*- coding: UTF-8 -*-
import psycopg2
import psycopg2.extras

from basemodel import BaseModel


class Product(BaseModel):

    def __init__(self):
        BaseModel.__init__(self)
        self._name = ''  # nombre de producto
        self._sku = ''  # id de producto
        self._description = ''  # descripcion de producto
        self._brand = ''  # marca de producto
        self._manufacturer = ''  # proveedor
        self._size = []  # tallas
        self._color = []  # color
        self._material = ''  # material
        self._bullet_1 = ''  # viñeta 1
        self._bullet_2 = ''  # viñeta 2
        self._bullet_3 = ''  # viñeta 3
        self._currency = ''  # divisa
        self._image = ''  # imagen 1
        self._image_2 = ''  # imagen 2
        self._image_3 = ''  # imagen 3
        self._image_4 = ''  # imagen 3
        self._image_5 = ''  # imagen 3
        self._image_6 = ''  # imagen 3
        self._category = ''  # categoria
        self._upc = ''  # articulo
        self._price = ''  # precio compra
        self._sell_price = 0  # precio venta
        self._delivery = ""  # delivery
        self._which_size = ""  # cual es tu talla
        self._promotion_price = 0
        self._size_id = ""
        self._bulk_price = 0

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
    def image_4(self):
        return self._image_4

    @image_4.setter
    def image_4(self, value):
        self._image_4 = value

    @property
    def image_5(self):
        return self._image_5

    @image_5.setter
    def image_5(self, value):
        self._image_5 = value

    @property
    def image_6(self):
        return self._image_6

    @image_6.setter
    def image_6(self, value):
        self._image_6 = value

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

    @property
    def delivery(self):
        return self._delivery

    @delivery.setter
    def delivery(self, value):
        self._delivery = value

    @property
    def which_size(self):
        return self._which_size

    @which_size.setter
    def which_size(self, value):
        self._which_size = value

    @property
    def promotion_price(self):
        return self._promotion_price

    @promotion_price.setter
    def promotion_price(self, value):
        self._promotion_price = value

    @property
    def size_id(self):
        return self._size_id

    @size_id.setter
    def size_id(self, value):
        self._size_id = value

    @property
    def bulk_price(self):
        return self._bulk_price

    @bulk_price.setter
    def bulk_price(self, value):
        self._bulk_price = value
    

    def GetList(self, cellar_id, page=1, items=30):

        page = int(page)
        items = int(items)
        offset = (page - 1) * items
        cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        try:
            q = '''\
                select p.*,c.name as category from "Product" p 
                inner join "Category" c on c.id = p.category_id 
                inner join (select distinct on(product_sku) product_sku, 
                                                            balance_units, 
                                                            date 
                            from "Kardex" 
                            where cellar_id = %(cellar_id)s
                            order by product_sku, date desc) k on k.product_sku = p.sku
                where p.for_sale = 1 and k.balance_units > 0
                limit %(items)s offset %(offset)s'''
            p = {
                "items": items,
                "offset": offset,
                "cellar_id": cellar_id
            }
            cur.execute(q, p)
            lista = cur.fetchall()
            return lista
        except Exception, e:
            # print str(e)
            return {}
        finally:
            cur.close()
            self.connection.close()

    def InitBySku(self, sku):

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)

        q = '''select string_agg(s.name,',') as size, array_agg(s.id) as size_id, p.*, c.name as category from "Product" p 
                inner join "Category" c on c.id = p.category_id 
                inner join "Product_Size" ps on ps.product_sku = p.sku
                inner join "Size" s on s.id = ps.size_id
                where p.sku = %(sku)s group by p.id, c.name limit 1'''
        p = {
            "sku": sku
        }
        try:
            cur.execute(q, p)
            producto = cur.fetchone()

            if cur.rowcount > 0:
                self.id = producto['id']
                self.name = producto['name']
                self.price = producto['price']
                self.sell_price = producto['sell_price']
                self.image = producto['image']
                self.image_2 = producto['image_2']
                self.image_3 = producto['image_3']
                self.bullet_1 = producto['bullet_1']
                self.bullet_2 = producto['bullet_2']
                self.bullet_3 = producto['bullet_3']
                self.sku = producto['sku']
                self.description = producto['description']
                self.size = producto['size']
                self.color = producto['color']
                self.material = producto['material']
                self.manufacturer = producto['manufacturer']
                self.upc = producto['upc']
                self.category = producto['category']
                self.currency = producto['currency']
                self.delivery = producto["delivery"]
                self.which_size = producto["which_size"]
                self.promotion_price = producto["promotion_price"]
                self.bulk_price = producto['bulk_price']

                return self.ShowSuccessMessage("{}".format(self.id))
            else:
                return self.ShowError("product not found")
        except Exception, e:
            return self.ShowError("product cannot be initialized sku:{}".format(str(e)))
        finally:
            cur.close()
            self.connection.close()

    def InitById(self, identifier):

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)

        q = '''select string_agg(s.name,',') as size, array_agg(s.id) as size_id, p.*, c.name as category from "Product" p 
                inner join "Category" c on c.id = p.category_id 
                inner join "Product_Size" ps on ps.product_sku = p.sku
                inner join "Size" s on s.id = ps.size_id
                where p.id = %(id)s group by p.id, c.name limit 1'''
        p = {
            "id": identifier
        }
        try:

            cur.execute(q, p)
            producto = cur.fetchone()

            if cur.rowcount > 0:
                # return json.dumps(producto)
                self.id = producto['id']
                self.name = producto['name']
                self.price = producto['price']
                self.sell_price = producto['sell_price']
                self.image = producto['image']
                self.image_2 = producto['image_2']
                self.image_3 = producto['image_3']
                self.bullet_1 = producto['bullet_1']
                self.bullet_2 = producto['bullet_2']
                self.bullet_3 = producto['bullet_3']
                self.sku = producto['sku']
                self.description = producto['description']
                self.size = producto['size']
                self.color = producto['color']
                self.material = producto['material']
                self.manufacturer = producto['manufacturer']
                self.upc = producto['upc']
                self.category = producto['category']
                self.currency = producto['currency']
                self.delivery = producto["delivery"]
                self.which_size = producto["which_size"]
                self.promotion_price = producto["promotion_price"]
                self.bulk_price = producto['bulk_price']

                return self.ShowSuccessMessage("{}".format(self.id))
            else:
                return self.ShowError("product not found")
        except Exception, e:
            return self.ShowError("product cannot be initialized by id, error: {}".format(str(e)))
        finally:
            cur.close()
            self.connection.close()

    def GetCombinations(self, id_bodega, name):

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)
        q = '''select p.*,c.name as category from "Product" p 
            inner join "Category" c on c.id = p.category_id 
            inner join (select distinct on(product_sku) product_sku, 
                                                            balance_units, 
                                                            date 
                            from "Kardex" 
                            where cellar_id = %(cellar_id)s
                            order by product_sku, date desc) k on k.product_sku = p.sku
            where p.name like %(name)s and p.for_sale = 1 and k.balance_units > 0 limit 4'''
        p = {
            "name": "%" + name + "%",
            "cellar_id": id_bodega
        }
        try:
            cur.execute(q, p)
            combinations = cur.fetchall()
            return combinations
        except Exception, e:
            # print "cannot get combinations:{}".format(str(e))
            return {}
        finally:
            cur.close()
            self.connection.close()

    def GetRandom(self, cellar_id):

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)
        q = '''\
            SELECT p.*, c.name as category FROM "Product" p 
            inner join "Category" c on c.id = p.category_id 
            inner join (select distinct on(product_sku) product_sku, 
                                                            balance_units, 
                                                            date 
                        from "Kardex" 
                        where cellar_id = %(cellar_id)s
                        order by product_sku, date desc) k on k.product_sku = p.sku
            where p.for_sale = 1 OFFSET random()*(select count(*) from "Product") - 4 LIMIT 4'''
        p = {
            "cellar_id": cellar_id
        }
        try:
            cur.execute(q, p)
            randomized = cur.fetchall()
            return randomized
        except Exception, e:
            # print str(e)
            return {}
        finally:
            cur.close()
            self.connection.close()

    def GetItems(self, cellar_id):

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)
        q = '''\
            select count(1) as total_items from "Product" p 
            inner join "Category" c on c.id = p.category_id 
            inner join (select distinct on(product_sku) product_sku, 
                                                        balance_units, 
                                                        date 
                        from "Kardex" 
                        where cellar_id = %(cellar_id)s
                        order by product_sku, date desc) k on k.product_sku = p.sku
            where p.for_sale = 1 and k.balance_units > 0'''
        p = {
            "cellar_id": cellar_id
        }
        try:
            cur.execute(q, p)
            total_items = cur.fetchone()["total_items"]
            return self.ShowSuccessMessage(total_items)
        except Exception, e:
            return self.ShowError(str(e))

    # get product detail
    def GetProductCatNameColor(self, cat, name, color):

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)

        q = '''select string_agg(s.name,',') as size, array_agg(s.id) as size_id, p.*,c.name as category from "Product" p 
        inner join "Category" c on c.id = p.category_id 
        inner join "Product_Size" ps on ps.product_sku = p.sku
        inner join "Size" s on s.id = ps.size_id
        where to_tsvector('spanish', p.name) @@ to_tsquery('spanish',%(name)s) 
        and to_tsvector('spanish', c.name) @@ to_tsquery('spanish',%(cat)s) 
        and to_tsvector('spanish', p.color) @@ to_tsquery('spanish', %(color)s) 
        and p.for_sale = 1 group by p.id, c.name limit 1'''
        p = {
            "name": name,
            "cat": cat,
            "color": color
        }
        try:
            # print cur.mogrify(q,p)
            cur.execute(q, p)
            producto = cur.fetchone()

            if cur.rowcount > 0:
                self.id = producto['id']
                self.name = producto['name']
                self.price = producto['price']
                self.sell_price = producto['sell_price']
                self.image = producto['image']
                self.image_2 = producto['image_2']
                self.image_3 = producto['image_3']
                self.image_4 = producto['image_4']
                self.image_5 = producto['image_5']
                self.image_6 = producto['image_6']
                self.bullet_1 = producto['bullet_1']
                self.bullet_2 = producto['bullet_2']
                self.bullet_3 = producto['bullet_3']
                self.sku = producto['sku']
                self.description = producto['description']
                self.size = producto['size']
                self.size_id = producto['size_id']
                self.color = producto['color']
                self.material = producto['material']
                self.manufacturer = producto['manufacturer']
                self.upc = producto['upc']
                self.category = producto['category']
                self.currency = producto['currency']
                self.delivery = producto["delivery"]
                self.which_size = producto["which_size"]
                self.promotion_price = producto["promotion_price"]
                self.bulk_price = producto['bulk_price']

                return self.ShowSuccessMessage("{}".format(self.id))
            else:
                return self.ShowError("product not found")
        except Exception, e:
            return self.ShowError("product cannot be initialized:{}".format(str(e)))
        finally:
            cur.close()
            self.connection.close()

    def getAllSizes(self):
        """
        get products all existing sizes
        """
        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)
        q = '''select * from "Size"'''
        try:
            cur.execute(q)
            sizes = cur.fetchall()
            return self.ShowSuccessMessage(sizes)
        except Exception, e:
            return self.ShowError(str(e))

    def filter(self, categories, sizes, cellar_id, page=1, limit=16):
        """
        find products that match the selected categories and sizes
        """
        page = int(page)
        limit = int(limit)
        offset = (page - 1) * limit

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)

        if len(categories) > 0 and len(sizes) > 0:
            q = '''select distinct on(product_sku) p.*,c.name as category from "Product" p 
                    inner join "Category" c on c.id = p.category_id
                    inner join "Tag_Product" tp on tp.product_id = p.id
                    inner join (select distinct on(product_sku) product_sku, 
                            size_id, 
                            balance_units 
                            from "Kardex" 
                            where size_id = any(%(sizes)s::int[]) and cellar_id = %(cellar_id)s
                            order by product_sku, 
                            size_id, 
                            date desc) k on k.product_sku = p.sku
                    where p.for_sale = 1
                    and k.balance_units > 0 
                   and tp.tag_id = any(%(categories)s::int[]) 
                   offset %(offset)s limit %(limit)s'''
            p = {"categories": categories,
                 "sizes": sizes,
                 "limit": limit,
                 "offset": offset,
                 "cellar_id": cellar_id}

        elif len(sizes) > 0:
            q = '''select distinct on(product_sku) p.*,c.name as category from "Product" p 
                    inner join "Category" c on c.id = p.category_id
                    inner join "Tag_Product" tp on tp.product_id = p.id
                    inner join (select distinct on(product_sku) product_sku, 
                            size_id, 
                            balance_units 
                            from "Kardex" 
                            where size_id = any(%(sizes)s::int[]) and cellar_id = %(cellar_id)s
                            order by product_sku,
                            date desc) k on k.product_sku = p.sku
                    where p.for_sale = 1
                    and k.balance_units > 0 
                   offset %(offset)s limit %(limit)s'''
            p = {"sizes": sizes,
                 "limit": limit,
                 "offset": offset,
                 "cellar_id": cellar_id}

        else:
            q = '''select p.*,c.name as category from "Product" p 
                   inner join "Category" c on c.id = p.category_id
                   inner join "Tag_Product" tp on tp.product_id = p.id
                   inner join (select distinct on(product_sku) product_sku, 
                            size_id, 
                            balance_units 
                            from "Kardex" 
                            where cellar_id = %(cellar_id)s
                            order by product_sku, 
                            date desc) k on k.product_sku = p.sku
                   where p.for_sale = 1 and tp.tag_id = any(%(categories)s::int[]) and k.balance_units > 0
                   offset %(offset)s limit %(limit)s'''
            p = {"categories": categories,
                 "limit": limit,
                 "offset": offset,
                 "cellar_id": cellar_id}

        try:
            # print cur.mogrify(q,p)
            cur.execute(q, p)
            products = cur.fetchall()
            return self.ShowSuccessMessage(products)
        except Exception, e:
            return self.ShowError(str(e))

    def getFilterItems(self, categories, sizes, cellar_id):
        """
        find products that match the selected categories and sizes
        """

        cur = self.connection.cursor(
            cursor_factory=psycopg2.extras.RealDictCursor)

        if len(categories) > 0 and len(sizes) > 0:
            q = '''select count(1) as items from "Product" p 
                   inner join "Category" c on c.id = p.category_id
                   inner join "Tag_Product" tp on tp.product_id = p.id
                   inner join (select distinct on(product_sku) product_sku, 
                            size_id, 
                            balance_units 
                            from "Kardex" 
                            where size_id = any(%(sizes)s::int[]) and cellar_id = %(cellar_id)s
                            order by product_sku, 
                            size_id, 
                            date desc) k on k.product_sku = p.sku
                   where p.for_sale = 1 and tp.tag_id = any(%(categories)s::int[]) and k.balance_units > 0'''
            p = {"categories": categories, "sizes": sizes}

        elif len(sizes) > 0:
            q = '''select count(1) as items from "Product" p 
                   inner join "Category" c on c.id = p.category_id
                   inner join "Tag_Product" tp on tp.product_id = p.id
                   inner join (select distinct on(product_sku) product_sku, 
                            size_id, 
                            balance_units 
                            from "Kardex" 
                            where size_id = any(%(sizes)s::int[]) and cellar_id = %(cellar_id)s
                            order by product_sku, 
                            size_id, 
                            date desc) k on k.product_sku = p.sku
                   where p.for_sale = 1 and k.balance_units > 0'''
            p = {"sizes": sizes}

        else:
            q = '''select count(1) as items from "Product" p 
                   inner join "Category" c on c.id = p.category_id
                   inner join "Tag_Product" tp on tp.product_id = p.id
                   inner join (select distinct on(product_sku) product_sku, 
                            size_id, 
                            balance_units 
                            from "Kardex" 
                            where cellar_id = %(cellar_id)s
                            order by product_sku, 
                            size_id, 
                            date desc) k on k.product_sku = p.sku
                   where p.for_sale = 1 and tp.tag_id = any(%(categories)s::int[]) and k.balance_units > 0'''
            p = {"categories": categories}

        try:
            cur.execute(q, p)
            items = cur.fetchone()["items"]
            return self.ShowSuccessMessage(items)
        except Exception, e:
            return self.ShowError(str(e))
