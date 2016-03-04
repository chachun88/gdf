#!/usr/bin/python
# -*- coding: UTF-8 -*-
import sendgrid
from globals import *
import psycopg2
import psycopg2.extras
import datetime
import pytz
from bson import json_util
import xlrd


# os.environ['TZ'] = 'Chile'
# time.tzset()


class SendEmail():

    def main(self):

        sg = sendgrid.SendGridClient(sendgrid_user, sendgrid_pass)
        mensaje = sendgrid.Mail()
        mensaje.set_from("{nombre} <{mail}>".format(nombre='Test Yi',mail="yichun212@gmail.com"))
        mensaje.add_to(to_giani)
        mensaje.set_subject("{}".format(datetime.datetime.now(pytz.timezone('Chile/Continental').isoformat())))
        mensaje.set_html("holaaaaa")
        status, msg = sg.send(mensaje)
        print "{} {}".format(status, msg)


class SaveStates():

    def main(self):

        f = open('static/json/comunas_regiones.json', "r")
        json_string = f.read()
        json = json_util.loads(json_string)

        for region in json:

            connection = psycopg2.connect("host='localhost' dbname='cellar' user='postgres' password='12345'")
            cur = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

            try:
                query = '''
                        insert into "City" (id, name, region_id)
                        values (%(id)s, %(name)s, %(region_id)s)
                        '''
                parameters = {
                    "id": region["id"],
                    "name": region["name"],
                    "region_id": region["region_id"]
                }
                cur.execute(query, parameters)
                connection.commit()
            except Exception,e:
                print str(e)
            finally:
                cur.close()
                connection.close()


class SavePostOffices():

    def getCityId(self, name):

        connection = psycopg2.connect("host='localhost' dbname='giani' user='postgres' password='12345'")
        cur = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

        try:
            query = '''\
                    select id from "City"
                    where lower(name) = %(name)s
                    '''
            parameters = {
                "name": name.strip().lower()
            }
            print cur.mogrify(query, parameters)
            cur.execute(query, parameters)
            city_id = cur.fetchone()["id"]
            return city_id
        except Exception, e:
            # print str(e)
            return None
        finally:
            cur.close()
            connection.close()

    def main(self):

        f = open('l.txt', "r")
        sucursales = f.readlines()

        for sucursal in sucursales:

            connection = psycopg2.connect("host='localhost' dbname='giani' user='postgres' password='12345'")
            cur = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

            suc = sucursal.split("\t")
            name = suc[0]
            address = suc[1]
            city_name = suc[2]

            city_id = self.getCityId(city_name)

            if city_id is not None:
                try:
                    query = '''
                            insert into "Post_Office" (name, address, city_id)
                            values (%(name)s, %(address)s, %(city_id)s)
                            '''
                    parameters = {
                        "name": name,
                        "address": address,
                        "city_id": city_id
                    }
                    cur.execute(query, parameters)
                    connection.commit()
                except Exception,e:
                    print str(e)
                finally:
                    cur.close()
                    connection.close()


class UpdatePrice():

    def main(self):

        doc = xlrd.open_workbook("chilexpress_2016.xlsx")

        sheet = doc.sheet_by_index(0)

        nrows = sheet.nrows
        ncols = sheet.ncols
        # print ncols
        # self.write("{}".format(ncols))

        # fila
        for i in range(1, nrows):

            city_id = None
            price = 0
            ciudad = ""

            # columna
            for j in range(ncols):

                if j == 0:
                    value = sheet.cell_value(i,j)
                    ciudad = value

                    connection = psycopg2.connect("host='localhost' dbname='giani' user='yichun' password='chachun88'")
                    cur = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

                    try:
                        query = '''
                                select id from "City"
                                where lower(name) = lower(%(name)s)
                                '''
                        parameters = {
                            "name": value
                        }
                        cur.execute(query, parameters)
                        city_id = cur.fetchone()["id"]
                        connection.commit()
                    except Exception,e:
                        city_id = 0
                        print str(e)
                    finally:
                        cur.close()
                        connection.close()

                    if city_id == 0:

                        connection = psycopg2.connect("host='localhost' dbname='giani' user='yichun' password='chachun88'")
                        cur = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

                        try:
                            query = '''
                                    insert into "City" (name)
                                    values (lower(%(name)s))
                                    returning id
                                    '''
                            parameters = {
                                "name": value
                            }
                            cur.execute(query, parameters)
                            city_id = cur.fetchone()["id"]
                            connection.commit()
                        except Exception,e:
                            city_id = None
                            # print str(e)
                        finally:
                            cur.close()
                            connection.close()

                elif j == 1:
                    price = sheet.cell_value(i,j)

            if city_id is not None and price > 0:

                connection = psycopg2.connect("host='localhost' dbname='giani' user='postgres' password='12345'")
                cur = connection.cursor(cursor_factory=psycopg2.extras.RealDictCursor)

                try:
                    query = '''
                            update "Shipping"
                            set chilexpress_price = %(price)s,
                            price = %(price)s
                            where to_city_id = %(city_id)s
                            '''
                    parameters = {
                        "city_id": city_id,
                        "price": price
                    }
                    cur.execute(query, parameters)
                    connection.commit()
                except Exception,e:
                    print str(e)
                finally:
                    cur.close()
                    connection.close()



# send_email = SendEmail()
# send_email.main()
# savestate = SavePostOffices()
# savestate.main()

c = UpdatePrice()
c.main()