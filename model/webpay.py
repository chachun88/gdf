#!/usr/bin/python
# -*- coding: UTF-8 -*-

from basemodel import BaseModel
# from salesmanpermission import SalesmanPermission
# from bson.objectid import ObjectId
import psycopg2
import psycopg2.extras

class Webpay(BaseModel):


	@property
	def order_id(self):
	    return self._order_id
	@order_id.setter
	def order_id(self, value):
	    self._order_id = value
	
	@property
	def tbk_orden_compra(self):
	    return self._tbk_orden_compra
	@tbk_orden_compra.setter
	def tbk_orden_compra(self, value):
	    self._tbk_orden_compra = value

	@property
	def tbk_tipo_transaccion(self):
	    return self._tbk_tipo_transaccion
	@tbk_tipo_transaccion.setter
	def tbk_tipo_transaccion(self, value):
	    self._tbk_tipo_transaccion = value
	
	@property
	def tbk_monto(self):
	    return self._tbk_monto
	@tbk_monto.setter
	def tbk_monto(self, value):
	    self._tbk_monto = value
	
	@property
	def tbk_codigo_autorizacion(self):
	    return self._tbk_codigo_autorizacion
	@tbk_codigo_autorizacion.setter
	def tbk_codigo_autorizacion(self, value):
	    self._tbk_codigo_autorizacion = value
	
	@property
	def tbk_final_numero_tarjeta(self):
	    return self._tbk_final_numero_tarjeta
	@tbk_final_numero_tarjeta.setter
	def tbk_final_numero_tarjeta(self, value):
	    self._tbk_final_numero_tarjeta = value
	
	@property
	def tbk_fecha_contable(self):
	    return self._tbk_fecha_contable
	@tbk_fecha_contable.setter
	def tbk_fecha_contable(self, value):
	    self._tbk_fecha_contable = value

	@property
	def tbk_fecha_transaccion(self):
	    return self._tbk_fecha_transaccion
	@tbk_fecha_transaccion.setter
	def tbk_fecha_transaccion(self, value):
	    self._tbk_fecha_transaccion = value

	@property
	def tbk_hora_transaccion(self):
	    return self._tbk_hora_transaccion
	@tbk_hora_transaccion.setter
	def tbk_hora_transaccion(self, value):
	    self._tbk_hora_transaccion = value
	
	@property
	def tbk_id_transaccion(self):
	    return self._tbk_id_transaccion
	@tbk_id_transaccion.setter
	def tbk_id_transaccion(self, value):
	    self._tbk_id_transaccion = value

	@property
	def tbk_tipo_pago(self):
	    return self._tbk_tipo_pago
	@tbk_tipo_pago.setter
	def tbk_tipo_pago(self, value):
	    self._tbk_tipo_pago = value
	
	@property
	def tbk_numero_cuotas(self):
	    return self._tbk_numero_cuotas
	@tbk_numero_cuotas.setter
	def tbk_numero_cuotas(self, value):
	    self._tbk_numero_cuotas = value

	@property
	def tbk_id_sesion(self):
	    return self._tbk_id_sesion
	@tbk_id_sesion.setter
	def tbk_id_sesion(self, value):
	    self._tbk_id_sesion = value
	
	
	
	def __init__(self):
		BaseModel.__init__(self)
		self.table = 'Webpay'

	def Save(self):

		cur = self.connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

		parameters = {
			"order_id":self.order_id,
			"TBK_ORDEN_COMPRA":self.tbk_orden_compra,
			"TBK_MONTO":self.tbk_monto,
			"TBK_CODIGO_AUTORIZACION":self.tbk_codigo_autorizacion,
			"TBK_FINAL_NUMERO_TARJETA":self.tbk_final_numero_tarjeta,
			"TBK_FECHA_CONTABLE":self.tbk_fecha_contable,
			"TBK_FECHA_TRANSACCION":self.tbk_fecha_transaccion,
			"TBK_HORA_TRANSACCION":self.tbk_hora_transaccion,
			"TBK_ID_TRANSACCION":self.tbk_id_transaccion,
			"TBK_TIPO_PAGO":self.tbk_tipo_pago,
			"TBK_NUMERO_CUOTAS":self.tbk_numero_cuotas,
			"TBK_ID_SESION":self.tbk_id_sesion
		}

		query = ''' insert into "Webpay" (order_id,
										TBK_ORDEN_COMPRA,
										TBK_MONTO,
										TBK_CODIGO_AUTORIZACION,
										TBK_FINAL_NUMERO_TARJETA,
										TBK_FECHA_CONTABLE,
										TBK_FECHA_TRANSACCION,
										TBK_HORA_TRANSACCION,
										TBK_ID_TRANSACCION,
										TBK_TIPO_PAGO,
										TBK_NUMERO_CUOTAS,
										TBK_ID_SESION)
					values (%(order_id)s,
							%(TBK_ORDEN_COMPRA)s,
							%(TBK_MONTO)s,
							%(TBK_CODIGO_AUTORIZACION)s,
							%(TBK_FINAL_NUMERO_TARJETA)s,
							%(TBK_FECHA_CONTABLE)s,
							%(TBK_FECHA_TRANSACCION)s,
							%(TBK_HORA_TRANSACCION)s,
							%(TBK_ID_TRANSACCION)s,
							%(TBK_TIPO_PAGO)s,
							%(TBK_NUMERO_CUOTAS)s,
							%(TBK_ID_SESION)s)
					returning id'''

		try:
			cur.execute(query,parameters)
			self.connection.commit()
			self.id = cur.fetchone()["id"]
			return self.ShowSuccessMessage(self.id)
		except Exception,e:
			return self.ShowError(str(e))
		finally:
			self.connection.close()
			cur.close()