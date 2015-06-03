#!/usr/bin/python
# -*- coding: UTF-8 -*-


from basehandler import BaseHandler

from globals import cellar_id, url_bodega, debugMode

# libreria prescindible
from bson import json_util
from datetime import datetime

from model.product import Product
from model.cart import Cart
from model.kardex import Kardex
from model.vote import Vote
from model.tag import Tag
from model.cellar import Cellar
from model.size import Size


class IndexHandler(BaseHandler):

    def get(self):
        cellar = Cellar()
        res_web = cellar.GetWebCellar()
        cellar_id = None

        if "success" in res_web:
            cellar_id = res_web["success"]

        product = Product()
        page = int(self.get_argument("page","1"))
        ajax = int(self.get_argument("ajax",0))
        lista = product.GetList(cellar_id, page, 16)

        items = 0
        tags = {}
        tallas = []

        response = product.GetItems(cellar_id)
        if "success" in response:
            items = response["success"]

        tag = Tag()
        tags_visibles = tag.ListVisibleTags()

        if "success" in tags_visibles:
            tags = tags_visibles["success"]

        tallas_res = product.getAllSizes()

        if "success" in tallas_res:
            tallas = tallas_res["success"]

        if ajax == 0:
            self.render("store/index.html",
                        data=lista,
                        items=items,
                        page=page,
                        tags=tags,
                        tags_arr=None,
                        tallas=tallas)
        else:
            self.render("store/ajax_productos.html",
                        data=lista,
                        items=items,
                        page=page,
                        tags=tags,
                        tags_arr=None,
                        tallas=tallas)

    def post(self):
        self.write(json_util.dumps(self.request.arguments))


class ProductHandler(BaseHandler):

    def get(self,category,name,color):

        category = category.replace("_","&")
        name = name.replace("_","&")
        color = color.replace("_","&")

        id_bodega = cellar_id
        cellar = Cellar()
        res_cellar = cellar.GetWebCellar()

        if "success" in res_cellar:
            id_bodega = res_cellar["success"]

        # sku = self.get_argument("sku","")
        prod = Product()

        response_obj = prod.GetProductCatNameColor(category,name,color)

        if "error" in response_obj:
            self.render("beauty_error.html",
                        message="Producto no encontrado, error:{}"
                        .format(response_obj["error"]))
        else:

            tallas_disponibles = []

            prod.size_id = sorted(prod.size_id, reverse=True)

            for s in prod.size_id:

                kardex = Kardex()
                response_obj = kardex.FindKardex(prod.sku,id_bodega,s)

                if "success" in response_obj:

                    # print kardex.balance_units

                    if kardex.balance_units > 0:

                        _size = Size()
                        _size.id = s
                        res_name = _size.initById()

                        if "success" in res_name:
                            tallas_disponibles.append({"id": _size.id, "name": _size.name})
                        elif debugMode:
                            print res_name["error"]
                elif debugMode:
                    print response_obj["error"]

            prod.size = tallas_disponibles[::-1]

            vote = Vote()

            res = vote.GetVotes(prod.id)
            votos = 0

            prod_name = prod.name

            # print "prod_name:{}".format(prod_name)

            combinaciones = prod.GetCombinations(id_bodega, prod_name)

            tag = Tag()
            res_tags = tag.GetTagsByProductId(prod.id)

            if "success" in res_tags:
                relacionados = prod.GetRandom(id_bodega, res_tags["success"])

            if "success" in res:
                votos = res["success"]

            self.render("store/detalle-producto.html",
                        data=prod,
                        combinations=combinaciones,
                        related=relacionados,
                        votos=votos)


class AddToCartHandler(BaseHandler):

    def get(self):

        product = Product()
        cart = Cart()
        cart.product_id = self.get_argument("product_id","")

        if cart.product_id != "":

            response_obj = product.InitById(cart.product_id)

            if "success" in response_obj:

                cart.quantity = int(self.get_argument("quantity",0))

                if product.promotion_price != 0:
                    subtotal = int(product.promotion_price) * cart.quantity
                    cart.price = product.promotion_price
                else:
                    subtotal = int(product.sell_price) * cart.quantity
                    cart.price = product.sell_price

                if self.current_user:
                    if self.current_user["type_id"] == 4:
                        subtotal = int(product.bulk_price) * cart.quantity
                        cart.price = product.bulk_price

                size_id = self.get_argument("size","")

                size = Size()
                size.id = size_id
                res_name = size.initById()

                if "error" in res_name:
                    self.write(res_name["error"])
                else:
                    cart.size = size.name

                cart.date = datetime.now()
                cart.subtotal = subtotal
                cart.user_id = self.get_argument("user_id",-1)

                if self.current_user:
                    cart.user_id = self.current_user["id"]

                response_obj = cart.Save()

                if "success" in response_obj:
                    self.write("ok")
                else:
                    self.write(response_obj["error"])
            else:
                self.write(response_obj["error"])
        else:
            self.write("Product ID is empty")


class GetCartByUserIdHandler(BaseHandler):

    def get(self):

        user_id = self.get_argument("user_id","")
        ajax = int(self.get_argument("ajax",1))

        if user_id != "":

            cart = Cart()
            cart.user_id = user_id
            lista = cart.GetCartByUserId()
            suma = 0
            for l in lista:
                suma += l["subtotal"]

            if ajax:
                self.render("store/carro_ajax.html",
                            data=lista,
                            suma=suma,
                            url_bodega=url_bodega)
            else:
                self.render("store/cart.html",data=lista,suma=suma)
        else:

            self.write("error")


class RemoveCartByIdHandler(BaseHandler):

    def get(self):

        cart = Cart()
        cart.id = self.get_argument("cart_id","")
        if cart.id == "":
            self.write("No existe el item a eliminar")
        else:
            response_obj = cart.Remove()
            if "success" in response_obj:
                self.write("ok")
            else:
                self.write(response_obj["error"])


class VoteProductHandler(BaseHandler):

    def get(self):

        user_id = self.get_argument("user_id","")
        product_id = self.get_argument("product_id","")

        vote = Vote()
        response = vote.VoteProduct(user_id,product_id)

        self.write(json_util.dumps(response))


class IfVotedHandler(BaseHandler):

    def get(self):

        user_id = self.get_argument("user_id","")
        product_id = self.get_argument("product_id","")

        vote = Vote()
        response = vote.IfVoted(user_id,product_id)

        self.write(json_util.dumps(response))


class GetVotesHandler(BaseHandler):

    def get(self):

        product_id = self.get_argument("product_id","")

        vote = Vote()
        response = vote.GetVotes(product_id)

        self.write(json_util.dumps(response))


class GetProductsByTagsHandler(BaseHandler):

    def get(self,tags=""):

        cellar_id = None

        cellar = Cellar()
        res_web = cellar.GetWebCellar()

        if "success" in res_web:
            cellar_id = res_web["success"]

        page = int(self.get_argument("page","1"))
        ajax = int(self.get_argument("ajax",0))

        tags = tags.replace("_"," ")

        tags_arr = tags.split(",")

        items = 0

        tallas = []

        tag = Tag()

        res = tag.GetItemsByTags(cellar_id, tags_arr)

        if "success" in res:
            items = int(res["success"])

        res = tag.GetProductsByTags(cellar_id, tags_arr,page,15)

        tags_visibles = tag.ListVisibleTags()

        if "success" in tags_visibles:
            tags = tags_visibles["success"]

        product = Product()

        tallas_res = product.getAllSizes()

        if "success" in tallas_res:
            tallas = tallas_res["success"]

        if "success" in res:
            if ajax == 0:
                self.render("store/index.html",
                            data=res["success"],
                            items=items,
                            page=page,
                            tags=tags,
                            tags_arr=tags_arr,
                            tallas=tallas)
            else:
                self.render("store/ajax_productos.html",
                            data=res["success"],
                            items=items,page=page)
        else:
            self.render("beauty_error.html",message=res["error"])


class UpdateCartQuantityHandler(BaseHandler):

    def post(self):

        cart_id = self.get_argument("cart_id","")
        quantity = self.get_argument("quantity","")

        cart = Cart()
        response = cart.UpdateCartQuantity(cart_id,quantity)

        self.write(json_util.dumps(response))


class FilterHandler(BaseHandler):
    """ retorna via ajax """

    def get(self):
        """ metodo get"""

        categories = self.get_arguments("categories")
        sizes = self.get_arguments("size")
        page = int(self.get_argument("page","1"))

        items = 0
        cellar_id = ""

        cellar = Cellar()
        res_cellar = cellar.GetWebCellar()

        if "success" in res_cellar:
            cellar_id = res_cellar["success"]

        product = Product()
        res = product.filter(categories, sizes, cellar_id, page)
        res_items = product.getFilterItems(categories, sizes, cellar_id)

        if "success" in res_items:
            items = res_items["success"]

        if "success" in res:
            self.write(self.render_string(
                "store/ajax_productos.html",
                data=res["success"],
                items=items,
                page=page,
                canonical_url=self.canonical_url,
                url_bodega=url_bodega,
                money_format=self.money_format))
        else:
            self.write(res["error"])
