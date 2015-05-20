#!/usr/bin/python
# -*- coding: UTF-8 -*-

import string
import math
import unittest
import random

from others_handler import ExitoHandler
from lp.globals import enviroment, Enviroment


class TestSuccess(unittest.TestCase):

    def setUp(self):
        enviroment = Enviroment.ONTEST

    def test_mails(self):

        detalle_orden = ExitoHandler.generateMail(
            "detalle_orden.html",
            name="foo",
            size="bar",
            quantity="baz",
            color="aaaa",
            price="eee",
            subtotal="iiii")
        datos_facturacion = ExitoHandler.generateMail(
            "datos_facturacion.html",
            order_id="foo",
            name="bar",
            address="bar",
            town="bar",
            city="bar",
            country="bar",
            telephone="bar",
            email="bar")

        datos_despacho = ExitoHandler.generateMail(
            "datos_despacho.html",
            order_id="foo",
            name="foo",
            address="foo",
            town="foo",
            city="foo",
            country="foo",
            telephone="foo",
            email="foo")

        mail_cliente = ExitoHandler.generateMail(
            "mail_confirmacion_cliente.html",
            autoescape=None,
            name="foo",
            order_id="foo",
            datos_facturacion=datos_facturacion,
            datos_despacho=datos_despacho,
            detalle_orden=detalle_orden,
            order_total="foo",
            order_subtotal="foo",
            order_tax="foo",
            url_local="bar",
            costo_despacho="foo")

        mail_giani = ExitoHandler.generateMail(
            "mail_confirmacion_giani.html",
            autoescape=None,
            name="foo",
            order_id="foo",
            datos_facturacion=datos_facturacion,
            datos_despacho=datos_despacho,
            detalle_orden=detalle_orden,
            order_total="foo",
            order_subtotal="foo",
            order_tax="foo",
            url_local="bar",
            costo_despacho="foo")

        assert "{" not in detalle_orden
        assert "{" not in datos_facturacion
        assert "{" not in datos_despacho
        assert "{" not in mail_cliente
        assert "{" not in mail_giani

        assert "&lt;" not in mail_cliente  # client mail must not escape content
        assert "&lt;" not in mail_giani

    def test_random(self):
        def id_generator(size=6, chars=string.letters + string.digits + string.whitespace + "áéíóúñ`àèìòù'?!"):
            return ''.join(random.choice(chars) for _ in range(size))

        for x in xrange(0,100):
            try:

                foo = random.random() * 100
                bar = id_generator(size=30)

                # foo if random.random()*2 <= 1 else bar

                detalle_orden = ExitoHandler.generateMail(
                    "detalle_orden.html",
                    name=foo if random.random()*2 <= 1 else bar,
                    size=foo if random.random()*2 <= 1 else bar,
                    quantity=foo if random.random()*2 <= 1 else bar,
                    color=foo if random.random()*2 <= 1 else bar,
                    price=foo if random.random()*2 <= 1 else bar,
                    subtotal=foo if random.random()*2 <= 1 else bar)
                datos_facturacion = ExitoHandler.generateMail(
                    "datos_facturacion.html",
                    order_id=foo if random.random()*2 <= 1 else bar,
                    name=foo if random.random()*2 <= 1 else bar,
                    address=foo if random.random()*2 <= 1 else bar,
                    town=foo if random.random()*2 <= 1 else bar,
                    city=foo if random.random()*2 <= 1 else bar,
                    country=foo if random.random()*2 <= 1 else bar,
                    telephone=foo if random.random()*2 <= 1 else bar,
                    email=foo if random.random()*2 <= 1 else bar)

                datos_despacho = ExitoHandler.generateMail(
                    "datos_despacho.html",
                    order_id=foo if random.random()*2 <= 1 else bar,
                    name=foo if random.random()*2 <= 1 else bar,
                    address=foo if random.random()*2 <= 1 else bar,
                    town=foo if random.random()*2 <= 1 else bar,
                    city=foo if random.random()*2 <= 1 else bar,
                    country=foo if random.random()*2 <= 1 else bar,
                    telephone=foo if random.random()*2 <= 1 else bar,
                    email=foo if random.random()*2 <= 1 else bar)

                mail_cliente = ExitoHandler.generateMail(
                    "mail_confirmacion_cliente.html",
                    autoescape=None,
                    name=foo if random.random()*2 <= 1 else bar,
                    order_id=foo if random.random()*2 <= 1 else bar,
                    datos_facturacion=datos_facturacion,
                    datos_despacho=datos_despacho,
                    detalle_orden=detalle_orden,
                    order_total=foo if random.random()*2 <= 1 else bar,
                    order_subtotal=foo if random.random()*2 <= 1 else bar,
                    order_tax=foo if random.random()*2 <= 1 else bar,
                    url_local=foo if random.random()*2 <= 1 else bar,
                    costo_despacho=foo if random.random()*2 <= 1 else bar)

                mail_giani = ExitoHandler.generateMail(
                    "mail_confirmacion_giani.html",
                    autoescape=None,
                    name=foo if random.random()*2 <= 1 else bar,
                    order_id=foo if random.random()*2 <= 1 else bar,
                    datos_facturacion=datos_facturacion,
                    datos_despacho=datos_despacho,
                    detalle_orden=detalle_orden,
                    order_total=foo if random.random()*2 <= 1 else bar,
                    order_subtotal=foo if random.random()*2 <= 1 else bar,
                    order_tax=foo if random.random()*2 <= 1 else bar,
                    url_local=foo if random.random()*2 <= 1 else bar,
                    costo_despacho=foo if random.random()*2 <= 1 else bar)
            except:
                assert False

            assert "{" not in detalle_orden
            assert "{" not in datos_facturacion
            assert "{" not in datos_despacho
            assert "{" not in mail_cliente
            assert "{" not in mail_giani

            assert "&lt;" not in mail_cliente  # client mail must not escape content
            assert "&lt;" not in mail_giani
