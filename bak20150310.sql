--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Access_Token; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Access_Token" (
    id integer NOT NULL,
    "time" timestamp without time zone DEFAULT now(),
    appid integer
);


ALTER TABLE public."Access_Token" OWNER TO yichun;

--
-- Name: Access_Token_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Access_Token_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Access_Token_id_seq" OWNER TO yichun;

--
-- Name: Access_Token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Access_Token_id_seq" OWNED BY "Access_Token".id;


--
-- Name: Brand; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Brand" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Brand" OWNER TO yichun;

--
-- Name: Brand_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Brand_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Brand_id_seq" OWNER TO yichun;

--
-- Name: Brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Brand_id_seq" OWNED BY "Brand".id;


--
-- Name: Category; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Category" (
    id integer NOT NULL,
    name text NOT NULL,
    parent_id integer
);


ALTER TABLE public."Category" OWNER TO yichun;

--
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Category_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Category_id_seq" OWNER TO yichun;

--
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Category_id_seq" OWNED BY "Category".id;


--
-- Name: Cellar; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Cellar" (
    id integer NOT NULL,
    name text,
    description text,
    city_id integer,
    for_sale integer DEFAULT 0 NOT NULL,
    reservation integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."Cellar" OWNER TO yichun;

--
-- Name: Cellar_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Cellar_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Cellar_id_seq" OWNER TO yichun;

--
-- Name: Cellar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Cellar_id_seq" OWNED BY "Cellar".id;


--
-- Name: City; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "City" (
    id integer NOT NULL,
    name text
);


ALTER TABLE public."City" OWNER TO yichun;

--
-- Name: City_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "City_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."City_id_seq" OWNER TO yichun;

--
-- Name: City_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "City_id_seq" OWNED BY "City".id;


--
-- Name: Contact; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Contact" (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    address text NOT NULL,
    telephone text NOT NULL,
    type_id integer,
    zip_code text DEFAULT ''::text,
    additional_info text,
    lastname text,
    user_id integer,
    town text DEFAULT ''::text,
    country text DEFAULT ''::text,
    rut text DEFAULT ''::text NOT NULL,
    city_id integer
);


ALTER TABLE public."Contact" OWNER TO yichun;

--
-- Name: Contact_Types; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Contact_Types" (
    id integer NOT NULL,
    name text
);


ALTER TABLE public."Contact_Types" OWNER TO yichun;

--
-- Name: Contact_Types_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Contact_Types_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Contact_Types_id_seq" OWNER TO yichun;

--
-- Name: Contact_Types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Contact_Types_id_seq" OWNED BY "Contact_Types".id;


--
-- Name: Contact_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Contact_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Contact_id_seq" OWNER TO yichun;

--
-- Name: Contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Contact_id_seq" OWNED BY "Contact".id;


--
-- Name: Kardex; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Kardex" (
    id integer NOT NULL,
    product_sku text NOT NULL,
    units integer NOT NULL,
    price double precision NOT NULL,
    sell_price double precision NOT NULL,
    cellar_id integer NOT NULL,
    total double precision NOT NULL,
    balance_units integer NOT NULL,
    balance_price double precision NOT NULL,
    balance_total double precision DEFAULT 0,
    date timestamp without time zone NOT NULL,
    "user" text,
    operation_type text,
    color text,
    size text
);


ALTER TABLE public."Kardex" OWNER TO yichun;

--
-- Name: Kardex_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Kardex_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kardex_id_seq" OWNER TO yichun;

--
-- Name: Kardex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Kardex_id_seq" OWNED BY "Kardex".id;


--
-- Name: Order; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Order" (
    id integer NOT NULL,
    date timestamp without time zone NOT NULL,
    type integer NOT NULL,
    subtotal double precision NOT NULL,
    shipping integer NOT NULL,
    tax double precision NOT NULL,
    total double precision NOT NULL,
    items_quantity integer NOT NULL,
    products_quantity integer NOT NULL,
    user_id integer NOT NULL,
    billing_id integer NOT NULL,
    shipping_id integer,
    payment_type integer DEFAULT 1 NOT NULL,
    source text DEFAULT 'web'::text,
    voucher text DEFAULT ''::text,
    state integer DEFAULT 1,
    tracking_code text,
    provider_id integer
);


ALTER TABLE public."Order" OWNER TO yichun;

--
-- Name: Order_Detail; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Order_Detail" (
    id integer NOT NULL,
    quantity integer NOT NULL,
    subtotal double precision NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    size text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."Order_Detail" OWNER TO yichun;

--
-- Name: Order_Detail_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Order_Detail_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Order_Detail_id_seq" OWNER TO yichun;

--
-- Name: Order_Detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Order_Detail_id_seq" OWNED BY "Order_Detail".id;


--
-- Name: Order_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Order_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Order_id_seq" OWNER TO yichun;

--
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Order_id_seq" OWNED BY "Order".id;


--
-- Name: Payment_Types; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Payment_Types" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Payment_Types" OWNER TO yichun;

--
-- Name: Payment_Types_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Payment_Types_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Payment_Types_id_seq" OWNER TO yichun;

--
-- Name: Payment_Types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Payment_Types_id_seq" OWNED BY "Payment_Types".id;


--
-- Name: Payment_Types_name_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Payment_Types_name_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Payment_Types_name_seq" OWNER TO yichun;

--
-- Name: Payment_Types_name_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Payment_Types_name_seq" OWNED BY "Payment_Types".name;


--
-- Name: Permission; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Permission" (
    id integer NOT NULL,
    name text
);


ALTER TABLE public."Permission" OWNER TO yichun;

--
-- Name: Permission_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Permission_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Permission_id_seq" OWNER TO yichun;

--
-- Name: Permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Permission_id_seq" OWNED BY "Permission".id;


--
-- Name: Product; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Product" (
    id integer NOT NULL,
    sku text NOT NULL,
    description text,
    brand text NOT NULL,
    size text[] NOT NULL,
    material text NOT NULL,
    bullet_1 text,
    bullet_2 text,
    currency character varying(10),
    images text[],
    image text,
    image_2 text,
    image_3 text,
    price integer DEFAULT 0 NOT NULL,
    category_id integer NOT NULL,
    bullet_3 text,
    manufacturer text,
    name text NOT NULL,
    color text,
    upc text,
    sell_price integer DEFAULT 0,
    which_size text DEFAULT ''::text NOT NULL,
    delivery text DEFAULT ''::text NOT NULL,
    for_sale integer DEFAULT 0 NOT NULL,
    image_4 text DEFAULT ''::text,
    image_5 text DEFAULT ''::text,
    image_6 text DEFAULT ''::text,
    promotion_price integer DEFAULT 0
);


ALTER TABLE public."Product" OWNER TO yichun;

--
-- Name: Product_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Product_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Product_id_seq" OWNER TO yichun;

--
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Product_id_seq" OWNED BY "Product".id;


--
-- Name: Shipping; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Shipping" (
    id integer NOT NULL,
    from_city_id integer NOT NULL,
    to_city_id integer NOT NULL,
    correos_price integer,
    chilexpress_price integer,
    price integer NOT NULL,
    edited boolean DEFAULT false,
    charge_type integer DEFAULT 1 NOT NULL
);


ALTER TABLE public."Shipping" OWNER TO yichun;

--
-- Name: Shipping_Provider; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Shipping_Provider" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Shipping_Provider" OWNER TO yichun;

--
-- Name: Shipping_Provider_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Shipping_Provider_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Shipping_Provider_id_seq" OWNER TO yichun;

--
-- Name: Shipping_Provider_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Shipping_Provider_id_seq" OWNED BY "Shipping_Provider".id;


--
-- Name: Shipping_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Shipping_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Shipping_id_seq" OWNER TO yichun;

--
-- Name: Shipping_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Shipping_id_seq" OWNED BY "Shipping".id;


--
-- Name: State; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "State" (
    id integer NOT NULL,
    name text
);


ALTER TABLE public."State" OWNER TO yichun;

--
-- Name: State_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "State_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."State_id_seq" OWNER TO yichun;

--
-- Name: State_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "State_id_seq" OWNED BY "State".id;


--
-- Name: Tag; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Tag" (
    id integer NOT NULL,
    name text NOT NULL,
    visible integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."Tag" OWNER TO yichun;

--
-- Name: Tag_Product; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Tag_Product" (
    id integer NOT NULL,
    product_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public."Tag_Product" OWNER TO yichun;

--
-- Name: Tag_Product_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Tag_Product_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Tag_Product_id_seq" OWNER TO yichun;

--
-- Name: Tag_Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Tag_Product_id_seq" OWNED BY "Tag_Product".id;


--
-- Name: Tag_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Tag_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Tag_id_seq" OWNER TO yichun;

--
-- Name: Tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Tag_id_seq" OWNED BY "Tag".id;


--
-- Name: Tag_name_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Tag_name_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Tag_name_seq" OWNER TO yichun;

--
-- Name: Tag_name_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Tag_name_seq" OWNED BY "Tag".name;


--
-- Name: Temp_Cart; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Temp_Cart" (
    id integer NOT NULL,
    product_id integer,
    date timestamp without time zone,
    quantity integer,
    subtotal integer,
    user_id integer,
    size text,
    shipping_id integer,
    billing_id integer,
    payment_type integer,
    shipping_type integer DEFAULT 1,
    bought integer DEFAULT 0
);


ALTER TABLE public."Temp_Cart" OWNER TO yichun;

--
-- Name: Temp_Cart_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Temp_Cart_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Temp_Cart_id_seq" OWNER TO yichun;

--
-- Name: Temp_Cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Temp_Cart_id_seq" OWNED BY "Temp_Cart".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "User" (
    id integer NOT NULL,
    permissions integer[] DEFAULT ARRAY[]::integer[] NOT NULL,
    type_id integer NOT NULL,
    name text,
    email text NOT NULL,
    password text DEFAULT ''::text NOT NULL,
    cellar_permissions integer[] DEFAULT ARRAY[]::integer[],
    lastname text DEFAULT ''::text NOT NULL,
    rut text DEFAULT ''::text,
    bussiness text DEFAULT ''::text,
    approval_date timestamp without time zone,
    registration_date timestamp without time zone DEFAULT now() NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    first_view timestamp without time zone DEFAULT now() NOT NULL,
    last_view timestamp without time zone DEFAULT now() NOT NULL,
    deleted integer DEFAULT 0
);


ALTER TABLE public."User" OWNER TO yichun;

--
-- Name: User_Types; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "User_Types" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."User_Types" OWNER TO yichun;

--
-- Name: User_Types_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "User_Types_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_Types_id_seq" OWNER TO yichun;

--
-- Name: User_Types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "User_Types_id_seq" OWNED BY "User_Types".id;


--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "User_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_id_seq" OWNER TO yichun;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "User_id_seq" OWNED BY "User".id;


--
-- Name: Voto; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Voto" (
    id integer NOT NULL,
    user_id integer,
    product_id integer
);


ALTER TABLE public."Voto" OWNER TO yichun;

--
-- Name: Votos_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Votos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Votos_id_seq" OWNER TO yichun;

--
-- Name: Votos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Votos_id_seq" OWNED BY "Voto".id;


--
-- Name: Webpay; Type: TABLE; Schema: public; Owner: yichun; Tablespace: 
--

CREATE TABLE "Webpay" (
    id integer NOT NULL,
    "TBK_MONTO" integer,
    "TBK_CODIGO_AUTORIZACION" integer,
    "TBK_FINAL_NUMERO_TARJETA" integer,
    "TBK_FECHA_CONTABLE" integer,
    "TBK_FECHA_TRANSACCION" integer,
    "TBK_HORA_TRANSACCION" integer,
    "TBK_ID_TRANSACCION" integer,
    "TBK_TIPO_PAGO" text,
    "TBK_NUMERO_CUOTAS" integer,
    "TBK_ID_SESION" text NOT NULL,
    "TBK_ORDEN_COMPRA" integer NOT NULL,
    "ORDER_ID" integer NOT NULL
);


ALTER TABLE public."Webpay" OWNER TO yichun;

--
-- Name: Webpay_id_seq; Type: SEQUENCE; Schema: public; Owner: yichun
--

CREATE SEQUENCE "Webpay_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Webpay_id_seq" OWNER TO yichun;

--
-- Name: Webpay_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yichun
--

ALTER SEQUENCE "Webpay_id_seq" OWNED BY "Webpay".id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Access_Token" ALTER COLUMN id SET DEFAULT nextval('"Access_Token_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Brand" ALTER COLUMN id SET DEFAULT nextval('"Brand_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Category" ALTER COLUMN id SET DEFAULT nextval('"Category_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Cellar" ALTER COLUMN id SET DEFAULT nextval('"Cellar_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "City" ALTER COLUMN id SET DEFAULT nextval('"City_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Contact" ALTER COLUMN id SET DEFAULT nextval('"Contact_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Contact_Types" ALTER COLUMN id SET DEFAULT nextval('"Contact_Types_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Kardex" ALTER COLUMN id SET DEFAULT nextval('"Kardex_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Order" ALTER COLUMN id SET DEFAULT nextval('"Order_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Order_Detail" ALTER COLUMN id SET DEFAULT nextval('"Order_Detail_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Payment_Types" ALTER COLUMN id SET DEFAULT nextval('"Payment_Types_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Permission" ALTER COLUMN id SET DEFAULT nextval('"Permission_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Product" ALTER COLUMN id SET DEFAULT nextval('"Product_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Shipping" ALTER COLUMN id SET DEFAULT nextval('"Shipping_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Shipping_Provider" ALTER COLUMN id SET DEFAULT nextval('"Shipping_Provider_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "State" ALTER COLUMN id SET DEFAULT nextval('"State_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Tag" ALTER COLUMN id SET DEFAULT nextval('"Tag_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Tag_Product" ALTER COLUMN id SET DEFAULT nextval('"Tag_Product_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Temp_Cart" ALTER COLUMN id SET DEFAULT nextval('"Temp_Cart_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "User" ALTER COLUMN id SET DEFAULT nextval('"User_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "User_Types" ALTER COLUMN id SET DEFAULT nextval('"User_Types_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Voto" ALTER COLUMN id SET DEFAULT nextval('"Votos_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Webpay" ALTER COLUMN id SET DEFAULT nextval('"Webpay_id_seq"'::regclass);


--
-- Data for Name: Access_Token; Type: TABLE DATA; Schema: public; Owner: yichun
--



--
-- Name: Access_Token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Access_Token_id_seq"', 16580, true);


--
-- Data for Name: Brand; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Brand" (id, name) VALUES (1, 'Giani Da Firenze');
INSERT INTO "Brand" (id, name) VALUES (2, '1');


--
-- Name: Brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Brand_id_seq"', 2, true);


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Category" (id, name, parent_id) VALUES (4, 'Bota', NULL);
INSERT INTO "Category" (id, name, parent_id) VALUES (5, 'categoria', NULL);
INSERT INTO "Category" (id, name, parent_id) VALUES (6, 'producto 1', NULL);
INSERT INTO "Category" (id, name, parent_id) VALUES (7, 'zapatos', NULL);
INSERT INTO "Category" (id, name, parent_id) VALUES (1, 'Botin', NULL);


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Category_id_seq"', 7, true);


--
-- Data for Name: Cellar; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Cellar" (id, name, description, city_id, for_sale, reservation) VALUES (5, 'Bodega Central', 'asadadas', 3, 1, 0);
INSERT INTO "Cellar" (id, name, description, city_id, for_sale, reservation) VALUES (12, 'bodega reserva', 'aqui quedan los productos reservados desde la web', 3, 0, 1);


--
-- Name: Cellar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Cellar_id_seq"', 12, true);


--
-- Data for Name: City; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "City" (id, name) VALUES (1, 'Arica');
INSERT INTO "City" (id, name) VALUES (2, 'Iquique');
INSERT INTO "City" (id, name) VALUES (3, 'Santiago');
INSERT INTO "City" (id, name) VALUES (4, 'Valdivia');
INSERT INTO "City" (id, name) VALUES (5, 'Antofagasta');
INSERT INTO "City" (id, name) VALUES (6, 'Talca');
INSERT INTO "City" (id, name) VALUES (9, 'Concepción');
INSERT INTO "City" (id, name) VALUES (10, 'Temuco');
INSERT INTO "City" (id, name) VALUES (11, 'Punta Arenas');
INSERT INTO "City" (id, name) VALUES (12, 'La Serena');
INSERT INTO "City" (id, name) VALUES (13, 'Rancagua');
INSERT INTO "City" (id, name) VALUES (14, 'Coquimbo');
INSERT INTO "City" (id, name) VALUES (15, 'Copiapó');
INSERT INTO "City" (id, name) VALUES (16, 'Valparaíso');
INSERT INTO "City" (id, name) VALUES (19, 'Tarapacá');
INSERT INTO "City" (id, name) VALUES (20, 'Chillán');
INSERT INTO "City" (id, name) VALUES (21, 'Curicó');
INSERT INTO "City" (id, name) VALUES (22, '');
INSERT INTO "City" (id, name) VALUES (23, 'Arica DHSS');
INSERT INTO "City" (id, name) VALUES (24, 'Arica DHS');
INSERT INTO "City" (id, name) VALUES (25, 'Antofagasta Día Hábil Siguiente');
INSERT INTO "City" (id, name) VALUES (26, 'Antofagasta Día Hábil Sub Siguiente');
INSERT INTO "City" (id, name) VALUES (27, 'Arica Día Hábil Siguente');
INSERT INTO "City" (id, name) VALUES (28, 'Arica Día Hábil Sub Siguiente');
INSERT INTO "City" (id, name) VALUES (29, 'Copiapo');
INSERT INTO "City" (id, name) VALUES (30, 'Ovalle');
INSERT INTO "City" (id, name) VALUES (31, 'Valparaiso');
INSERT INTO "City" (id, name) VALUES (32, 'San Antonio');
INSERT INTO "City" (id, name) VALUES (33, 'Viña del Mar');
INSERT INTO "City" (id, name) VALUES (34, 'San Fernando');
INSERT INTO "City" (id, name) VALUES (35, 'Los Angeles');
INSERT INTO "City" (id, name) VALUES (36, 'Osorno');
INSERT INTO "City" (id, name) VALUES (37, 'Puerto Montt');
INSERT INTO "City" (id, name) VALUES (38, 'Coyhaique');


--
-- Name: City_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"City_id_seq"', 38, true);


--
-- Data for Name: Contact; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (28, 'Ricardo', 'ricardo@loadingplay.com', 'santa rosa 326', '97855603', 3, '8330341', '', 'Silva', 8, '', '', '', NULL);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (23, 'Ricardo', 'ricardo@loadingplay.com', 'santa rosa 326', '97855603', 3, '8330341', '', 'Silva', 8, '', '', '', NULL);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (25, 'Ricardo', 'ricardo@loadingplay.com', 'santa rosa 326', '97855603', 3, '8330341', '', 'Silva', 8, '', '', '', NULL);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (26, 'Ricardo', 'ricardo@loadingplay.com', 'santa rosa 326', '97855603', 3, '8330341', '', 'Silva', 8, '', '', '', NULL);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (27, 'Ricardo', 'ricardo@loadingplay.com', 'santa rosa 326', '97855603', 3, '8330341', '', 'Silva', 8, '', '', '', NULL);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (21, 'Ricardo', 'ricardo@loadingplay.com', 'santa rosa 326', '97855603', 3, '8330341', '', 'Silva', 8, '', '', '', NULL);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (58, 'Yi Chun', 'yichun212@gmail.com', 'alonso de córdova 5870', '97855603', 3, '984152515', '', 'Lin', 15, 'santiago', '', '14.645.855-6', 5);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (38, 'Ricardo', 'ricardo@loadingplay.com', 'santa rosa 2', '912345678', 3, '7804385', '', 'Silva', 16, 'santiago', '', '167618979', 5);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (50, 'Yi Chun', 'yi.neko@gmail.com', 'santa rosa 326 dpto 1703', '97855603', 3, '8330341', '', 'Lin', 403, 'santiago', '', '14.645.855-6', NULL);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (65, 'CERTIFICACION', 'certificacion2@transbank.cl', 'HUERFANOS 770', '99999999', 3, '99999999', '', 'WEBPAY', 592, 'SANTIAGO', '', '1-9', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (32, 'jose', 'jarenasmuller@gmail.com', 'av. americo vespucio', '8251951', 3, '8251951', '', 'Arenas Müller', 22, 'la florida', '', '16323861-6', NULL);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (49, 'soporte tbk', 'soporte9@tbk.cl', 'portugal', '1234567', 3, '6247344', '', 'tbk', 450, 'santiago', '', '111111111', NULL);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (60, 'Soporte', 'soporte11@transbank.cl', 'Laguna', '800441144', 3, '6247344', '', 'WP', 462, 'santiago', '', '18.455.334-1', 9);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (61, 'soporte tbk', 'soporte11@transbank.cl', 'Laguna', '800441144', 3, '6247344', '', 'WP', 462, 'santiago', '', '18.455.334-1', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (59, 'soporte tbk', 'AA@AA.CL', 'prueba', '800441144', 3, '6247344', '', 'X', 462, 'santiago', '', '3-5', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (55, 'Pruebas', 'aa@aa.com', 'calle pruebas', '999999778', 3, '111', '', 'TBK', 507, 'santiago', '', '999999999', 9);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (70, 'jose', 'jose@loadingplay.com', 'avenida americo vespucio', '2825473', 3, '8251951', 'uieuriuer', 'arenas', 22, 'Santiago', '', '163238616', 11);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (52, 'jose', 'jarenasmuller@gmail.com', 'avenida americo vespucio', '11111111', 3, '8251951', '', 'arenas', 22, 'Santiago', '', '11111111-1', 29);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (63, 'transbank', 'Soporte11@Transbank.cl', 'Portugal 1189', '800441144', 3, '6421215', '', 'WP', 573, 'cxcxccc', '', '1-9', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (62, 'SOPORTE', 'soporte11@transbank.cl', 'PRUEBAS 1234', '800441144', 3, '6421212', '', 'WP', 573, 'HUECHURABA', '', '11.111.111-1', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (57, 'TRANSBANK', 'soporte11@transbank.cl', 'prueba', '800441144', 3, '6247344', '', 'Pruebas', 462, 'santiago', '', '15708358-9', 9);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (56, 'TRANSBANK', 'AA@AA.CL', 'prueba', '800441144', 3, '6247344', '', 'X', 462, 'santiago', '', '3-5', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (64, 'Soporte WP', 'AA@AA.CL', 'prueba', '800441144', 3, 'sdsds', '', 'WP', 462, 'santiago', '', '208663996', 9);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (29, 'Ricardo', 'ricardo@loadingplay.com', 'santa rosa 326', '93538018', 3, '7804385', '', 'Silva', 39, 'Santiago', '', '167618979', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (79, 'Catalina', 'cataaap.-@hotmail.com', 'yelcho 5839', '+56954080274', 3, '9180535', '', 'Padilla', 1384, 'estacion central', '', '19526679-4', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (31, 'julian', 'julian@larrea.cl', 'martin de zamora 4381', '348734', 3, '7770008', '', 'larrea', 27, 'las condes', '', '13882457-8', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (69, 'Yi Chun', 'yichun212@gmail.com', 'santa rosa 326 dpto 1703', '84152515', 3, '7550000', '', 'Lin', 733, 'santiago', '', '146458556', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (89, 'Elizabeth', 'elygutleon@gmail.com', 'Enriqueta  petit 067', '73080241', 3, '8720404', '', 'Gutierrez', 2152, 'Quilicura', '', '163869395', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (72, 'Marioly', 'marioly.sav@gmail.com', 'Borinquen 2 Edificio Barlovento #63 Condominio Brisas del Sur', '90303480', 3, '2581342', 'Tambien está autorizada para recibirlo Claudia Aguilera Abarzúa.', 'Salazar Vivar', 850, 'Viña del Mar', '', '17910197-1', 33);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (71, 'Julian', 'julian@loadingplay.com', 'Martin de zamora 4381', '97458921', 3, '7770008', '', 'larrea desmadryl', 797, 'las condes', '', '13882457-8', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (80, 'Mariola', 'marywaves_@hotmail.com', 'Santa Isabel nº 353.Dpto.505', '+56952418707', 3, '8320000', '', 'Martinez', 1416, 'Santiago', '', '24547442-3', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (73, 'Angélica', 'angiieeh@live.cl', 'Avda. España 130', '71608105', 3, '6212375', 'Automóvil Club de Chile Escuela de Conductores', 'PEREZ', 949, 'Punta Arenas', '', '18.903.031-2', 11);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (81, 'MARIANELA', 'marianela.kine@gmail.com', 'SALTO DEL LAJA 701 "LA PRADERA"', '052367225', 3, '1530000', '', 'BRAVO BOGDANIC', 1609, 'COPIAPO', '', '109636797', 29);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (74, 'francisca', 'fca_ortiz@hotmail.com', 'balmaceda 560 c', '75333105', 3, '4450924', '', 'ortiz', 1026, 'los angeles', '', '169998485', 35);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (75, 'marcela', 'marcelaesc@gmail.com', 'los aromos 305', '97448380', 3, '00000', 'Comuna de LOlol, sexta región, provincia Colchagua', 'escalona orellana', 1100, 'Lolol, sexta región', '', '11199832-9', 13);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (76, 'TANIA MELIZA', 'tania.melizald@gmail.com', 'ramon carnicer 374', '54769464', 3, '5290000', '', 'lopez delgado', 1172, 'osorno', '', '17561074k', 36);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (77, 'Catherina', 'cathi.pc@gmail.com', 'Los Carrera 2695', '99174285', 3, '1533702', '', 'Pino', 1248, 'Copiapó', '', '16557957-7', 29);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (82, 'Karin Andrea', 'kanksunamun_14@hotmail.com', 'San Martin #1402', '58371533', 3, '5090000', '', 'Hettich Cárcamo', 1704, 'Valdivia', '', '17.532.582-4', 4);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (83, 'Florencia', 'floalfaro@live.cl', 'Monseñor Escriva de Balaguer 9447 depto 907', '87313050', 3, '7640799', '', 'Alfaro', 1790, 'Vitacura', '', '188023215', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (84, 'fanny', 'fannymondaca@hotmail.com', '4 norte 170, edificio viña del mar, departamento L 6', '87917718', 3, '2520214', '', 'Mondaca', 1846, 'Viña del Mar', '', '17645958-1', 33);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (85, 'francisca', 'kikaescobar@gmail.com', 'coronel avendaño 1750', '98251603', 3, '7630000', '', 'escobar', 1848, 'vitacura', '', '', 3);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (90, 'Jimena', 'Jimenagonzaleg@gmail.com', 'Luis Lagos Ortiz 01359', '96438150', 3, '6210652', '', 'Gonzalez', 2181, 'Punta Arenas', '', '131155409', 11);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (78, 'ivette', 'ivette.arroyop@gmail.com', 'rio aconcagua  #20', '57613206', 3, '4290300', '', 'arroyo', 1328, 'talcahuano', '', '183887874', 9);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (86, 'kika', 'kikaescobar@gmail.com', 'coronel avendaño', '98251603', 3, '7630000', '', 'escobar', 1848, 'vitacura', '', '153785538', 13);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (87, 'Julian', 'julian@larrea.cl', 'Martin de zamora 4381', '+56997458921', 3, '7770008', '', 'Larrea desmadryl', 1494, 'las condes', '', '138824578', 30);
INSERT INTO "Contact" (id, name, email, address, telephone, type_id, zip_code, additional_info, lastname, user_id, town, country, rut, city_id) VALUES (88, 'carolina', 'carolaraggi@gmail.com', 'manuel rodriguez 699', '76091304', 3, '4430512', 'esquina vicuña mackena con manuel rodriguez', 'raggi', 2089, 'los angeles', '', '13860154-4', 35);


--
-- Data for Name: Contact_Types; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Contact_Types" (id, name) VALUES (1, 'Despacho');
INSERT INTO "Contact_Types" (id, name) VALUES (2, 'Facturacion');
INSERT INTO "Contact_Types" (id, name) VALUES (3, 'Default');


--
-- Name: Contact_Types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Contact_Types_id_seq"', 3, true);


--
-- Name: Contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Contact_id_seq"', 90, true);


--
-- Data for Name: Kardex; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2243, 'GDF-OI14-Queltehue-C35', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-02-23 20:20:26.365959', 'yi.neko@gmail.com', 'buy', 'azul café', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2244, 'GDF-OI14-Queltehue-C35', 4, 33558, 0, 5, 134232, 4, 33558, 134232, '2015-02-23 20:20:26.475061', 'yi.neko@gmail.com', 'buy', 'azul café', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2245, 'GDF-OI14-Queltehue-C35', 12, 33558, 0, 5, 402696, 12, 33558, 402696, '2015-02-23 20:20:26.587882', 'yi.neko@gmail.com', 'buy', 'azul café', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2246, 'GDF-OI14-Queltehue-C35', 4, 33558, 0, 5, 134232, 4, 33558, 134232, '2015-02-23 20:20:26.707374', 'yi.neko@gmail.com', 'buy', 'azul café', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2247, 'GDF-OI14-Queltehue-C35', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:26.814564', 'yi.neko@gmail.com', 'buy', 'azul café', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2248, 'GDF-OI14-Queltehue-C19', 3, 33558, 0, 5, 100674, 3, 33558, 100674, '2015-02-23 20:20:27.238735', 'yi.neko@gmail.com', 'buy', 'café moro', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2249, 'GDF-OI14-Queltehue-C38', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:27.663896', 'yi.neko@gmail.com', 'buy', 'café ocre', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2250, 'GDF-OI14-Queltehue-C38', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-02-23 20:20:27.791913', 'yi.neko@gmail.com', 'buy', 'café ocre', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2251, 'GDF-OI14-Queltehue-C38', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-02-23 20:20:27.905581', 'yi.neko@gmail.com', 'buy', 'café ocre', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2252, 'GDF-OI14-Queltehue-C38', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:28.015485', 'yi.neko@gmail.com', 'buy', 'café ocre', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2253, 'GDF-OI14-Queltehue-C16', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-02-23 20:20:28.43084', 'yi.neko@gmail.com', 'buy', 'beige taupe', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2254, 'GDF-OI14-Queltehue-C39', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-02-23 20:20:28.87391', 'yi.neko@gmail.com', 'buy', 'negro camel', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2255, 'GDF-OI14-Queltehue-C39', 4, 33558, 0, 5, 134232, 4, 33558, 134232, '2015-02-23 20:20:28.992034', 'yi.neko@gmail.com', 'buy', 'negro camel', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2256, 'GDF-OI14-Queltehue-C39', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:29.091741', 'yi.neko@gmail.com', 'buy', 'negro camel', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2257, 'GDF-OI14-Queltehue-C30', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:29.519601', 'yi.neko@gmail.com', 'buy', 'camel azul', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2258, 'GDF-OI14-Queltehue-C30', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-02-23 20:20:29.623309', 'yi.neko@gmail.com', 'buy', 'camel azul', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2259, 'GDF-OI14-Queltehue-C30', 3, 33558, 0, 5, 100674, 3, 33558, 100674, '2015-02-23 20:20:29.72326', 'yi.neko@gmail.com', 'buy', 'camel azul', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2260, 'GDF-OI14-Queltehue-C30', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-02-23 20:20:29.840076', 'yi.neko@gmail.com', 'buy', 'camel azul', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2261, 'GDF-OI14-Queltehue-C33', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:30.338535', 'yi.neko@gmail.com', 'buy', 'café beige', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2262, 'GDF-OI14-Queltehue-C26', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-02-23 20:20:30.774183', 'yi.neko@gmail.com', 'buy', 'camel café', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2263, 'GDF-OI14-Queltehue-C26', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:30.883659', 'yi.neko@gmail.com', 'buy', 'camel café', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2264, 'GDF-OI14-Gavilan-C13', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:31.356624', 'yi.neko@gmail.com', 'buy', 'café beige', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2265, 'GDF-OI14-Gavilan-C13', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-02-23 20:20:31.46412', 'yi.neko@gmail.com', 'buy', 'café beige', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2266, 'GDF-OI14-Gavilan-C13', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:31.569025', 'yi.neko@gmail.com', 'buy', 'café beige', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2267, 'GDF-OI14-Gavilan-C11', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:32.231137', 'yi.neko@gmail.com', 'buy', 'café beige', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2268, 'GDF-OI14-Gavilan-C11', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:32.356569', 'yi.neko@gmail.com', 'buy', 'café beige', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2269, 'GDF-OI14-Gavilan-C10', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-02-23 20:20:32.789321', 'yi.neko@gmail.com', 'buy', 'café gris', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2270, 'GDF-OI14-Gavilan-C10', 3, 33558, 0, 5, 100674, 3, 33558, 100674, '2015-02-23 20:20:32.901529', 'yi.neko@gmail.com', 'buy', 'café gris', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2271, 'GDF-OI14-Gavilan-C10', 0, 33558, 0, 5, 0, 0, 0, 0, '2015-02-23 20:20:33.018713', 'yi.neko@gmail.com', 'buy', 'café gris', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2272, 'GDF-OI14-Gavilan-C10', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:33.138295', 'yi.neko@gmail.com', 'buy', 'café gris', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2273, 'GDF-OI14-Gavilan-C12', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:33.587274', 'yi.neko@gmail.com', 'buy', 'verde beige', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2274, 'GDF-OI14-Gavilan-C12', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:33.689495', 'yi.neko@gmail.com', 'buy', 'verde beige', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2275, 'GDF-OI14-Gavilan-C12', 4, 33558, 0, 5, 134232, 4, 33558, 134232, '2015-02-23 20:20:33.789337', 'yi.neko@gmail.com', 'buy', 'verde beige', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2276, 'GDF-OI14-Gavilan-C12', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:33.889794', 'yi.neko@gmail.com', 'buy', 'verde beige', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2277, 'GDF-OI14-Gavilan-C12', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-02-23 20:20:34.001936', 'yi.neko@gmail.com', 'buy', 'verde beige', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2278, 'GDF-OI14-Gavilan-C12', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:34.110822', 'yi.neko@gmail.com', 'buy', 'verde beige', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2279, 'GDF-OI14-Gavilan-C6', 4, 33558, 0, 5, 134232, 4, 33558, 134232, '2015-02-23 20:20:34.585204', 'yi.neko@gmail.com', 'buy', 'café', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2280, 'GDF-OI14-Gavilan-C2', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:35.047388', 'yi.neko@gmail.com', 'buy', 'negro', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2281, 'GDF-OI14-Gavilan-C5', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-23 20:20:35.521759', 'yi.neko@gmail.com', 'buy', 'verde gris', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2282, 'GDF-PV14-Lile-C8', 1, 34510, 0, 5, 34510, 1, 34510, 34510, '2015-02-23 20:20:35.990547', 'yi.neko@gmail.com', 'buy', 'azul', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2283, 'GDF-PV14-Lile-C8', 2, 34510, 0, 5, 69020, 2, 34510, 69020, '2015-02-23 20:20:36.108943', 'yi.neko@gmail.com', 'buy', 'azul', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2284, 'GDF-PV14-Lile-C8', 3, 34510, 0, 5, 103530, 3, 34510, 103530, '2015-02-23 20:20:36.209291', 'yi.neko@gmail.com', 'buy', 'azul', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2285, 'GDF-PV14-Lile-C9', 2, 34510, 0, 5, 69020, 2, 34510, 69020, '2015-02-23 20:20:36.693218', 'yi.neko@gmail.com', 'buy', 'azul', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2286, 'GDF-PV14-Lile-C9', 7, 34510, 0, 5, 241570, 7, 34510, 241570, '2015-02-23 20:20:36.794245', 'yi.neko@gmail.com', 'buy', 'azul', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2287, 'GDF-PV14-Lile-C9', 2, 34510, 0, 5, 69020, 2, 34510, 69020, '2015-02-23 20:20:36.899954', 'yi.neko@gmail.com', 'buy', 'azul', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2288, 'GDF-PV14-Lile-C9', 2, 34510, 0, 5, 69020, 2, 34510, 69020, '2015-02-23 20:20:37.014689', 'yi.neko@gmail.com', 'buy', 'azul', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2289, 'GDF-PV14-Lile-C1', 2, 34510, 0, 5, 69020, 2, 34510, 69020, '2015-02-23 20:20:37.867384', 'yi.neko@gmail.com', 'buy', 'camel', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2290, 'GDF-PV14-Lile-C10', 1, 34510, 0, 5, 34510, 1, 34510, 34510, '2015-02-23 20:20:38.344491', 'yi.neko@gmail.com', 'buy', 'camel', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2291, 'GDF-PV14-Lile-C10', 1, 34510, 0, 5, 34510, 1, 34510, 34510, '2015-02-23 20:20:38.448617', 'yi.neko@gmail.com', 'buy', 'camel', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2292, 'GDF-PV14-Lile-C10', 2, 34510, 0, 5, 69020, 2, 34510, 69020, '2015-02-23 20:20:38.573193', 'yi.neko@gmail.com', 'buy', 'camel', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2293, 'GDF-PV14-Lile-C10', 2, 34510, 0, 5, 69020, 2, 34510, 69020, '2015-02-23 20:20:38.68132', 'yi.neko@gmail.com', 'buy', 'camel', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2294, 'GDF-PV14-Kereu-C11', 2, 34391, 0, 5, 68782, 2, 34391, 68782, '2015-02-23 20:20:39.523426', 'yi.neko@gmail.com', 'buy', 'café', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2295, 'GDF-PV14-Kereu-C11', 2, 34391, 0, 5, 68782, 2, 34391, 68782, '2015-02-23 20:20:39.648646', 'yi.neko@gmail.com', 'buy', 'café', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2296, 'GDF-PV14-Kereu-C12', 1, 34391, 0, 5, 34391, 1, 34391, 34391, '2015-02-23 20:20:40.138158', 'yi.neko@gmail.com', 'buy', 'beige', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2297, 'GDF-PV14-Kereu-C12', 2, 34391, 0, 5, 68782, 2, 34391, 68782, '2015-02-23 20:20:40.236719', 'yi.neko@gmail.com', 'buy', 'beige', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2298, 'GDF-PV14-Kereu-C5', 1, 34391, 0, 5, 34391, 1, 34391, 34391, '2015-02-23 20:20:40.735439', 'yi.neko@gmail.com', 'buy', 'café verde', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2299, 'GDF-PV14-Kereu-C5', 2, 34391, 0, 5, 68782, 2, 34391, 68782, '2015-02-23 20:20:40.838058', 'yi.neko@gmail.com', 'buy', 'café verde', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2574, 'GDF-PV14-Kereu-C11', 1, 34391, 59990, 12, 34391, 1, 34391, 34391, '2015-03-10 21:59:18.654331', 'Sistema - Despacho', 'sell', 'café', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2580, 'GDF-OI14-Queltehue-C35', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-03-11 18:11:35.603737', 'javiera@gianidafirenze.cl', 'sell', 'azul café', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2302, 'GDF-PV14-Kereu-C3', 1, 34391, 0, 5, 34391, 1, 34391, 34391, '2015-02-23 20:20:41.944238', 'yi.neko@gmail.com', 'buy', 'café negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2303, 'GDF-PV14-Lile-C13', 6, 34510, 0, 5, 207060, 6, 34510, 207060, '2015-02-23 20:20:42.443434', 'yi.neko@gmail.com', 'buy', 'Beige', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2304, 'GDF-PV14-Lile-C13', 1, 34510, 0, 5, 34510, 1, 34510, 34510, '2015-02-23 20:20:42.548475', 'yi.neko@gmail.com', 'buy', 'Beige', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2305, 'GDF-OI14-Queltehue-C31', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-02-23 20:20:43.066956', 'yi.neko@gmail.com', 'buy', 'camel rojo', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2306, 'GDF-PV14-Sirisi-C8', 2, 32011, 0, 5, 64022, 2, 32011, 64022, '2015-02-23 20:20:43.569206', 'yi.neko@gmail.com', 'buy', 'croco rojo', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2307, 'GDF-PV14-Sirisi-C8', 2, 32011, 0, 5, 64022, 2, 32011, 64022, '2015-02-23 20:20:43.674072', 'yi.neko@gmail.com', 'buy', 'croco rojo', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2308, 'GDF-PV14-Sirisi-C8', 9, 32011, 0, 5, 288099, 9, 32011, 288099, '2015-02-23 20:20:43.772246', 'yi.neko@gmail.com', 'buy', 'croco rojo', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2309, 'GDF-PV14-Sirisi-C8', 6, 32011, 0, 5, 192066, 6, 32011, 192066, '2015-02-23 20:20:43.874996', 'yi.neko@gmail.com', 'buy', 'croco rojo', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2310, 'GDF-PV14-Sirisi-C8', 2, 32011, 0, 5, 64022, 2, 32011, 64022, '2015-02-23 20:20:44.009395', 'yi.neko@gmail.com', 'buy', 'croco rojo', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2311, 'GDF-PV14-Sirisi-C8', 1, 32011, 0, 5, 32011, 1, 32011, 32011, '2015-02-23 20:20:44.126845', 'yi.neko@gmail.com', 'buy', 'croco rojo', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2312, 'GDF-PV14-Sirisi-C9', 2, 32011, 0, 5, 64022, 2, 32011, 64022, '2015-02-23 20:20:44.623615', 'yi.neko@gmail.com', 'buy', 'croco beige', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2313, 'GDF-PV14-Sirisi-C9', 4, 32011, 0, 5, 128044, 4, 32011, 128044, '2015-02-23 20:20:44.723045', 'yi.neko@gmail.com', 'buy', 'croco beige', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2314, 'GDF-PV14-Sirisi-C9', 9, 32011, 0, 5, 288099, 9, 32011, 288099, '2015-02-23 20:20:44.834041', 'yi.neko@gmail.com', 'buy', 'croco beige', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2315, 'GDF-PV14-Sirisi-C9', 6, 32011, 0, 5, 192066, 6, 32011, 192066, '2015-02-23 20:20:44.934959', 'yi.neko@gmail.com', 'buy', 'croco beige', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2316, 'GDF-PV14-Sirisi-C9', 3, 32011, 0, 5, 96033, 3, 32011, 96033, '2015-02-23 20:20:45.063165', 'yi.neko@gmail.com', 'buy', 'croco beige', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2317, 'GDF-PV14-Sirisi-C9', 1, 32011, 0, 5, 32011, 1, 32011, 32011, '2015-02-23 20:20:45.183635', 'yi.neko@gmail.com', 'buy', 'croco beige', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2318, 'GDF-PV14-Sirisi-C5', 1, 32011, 0, 5, 32011, 1, 32011, 32011, '2015-02-23 20:20:45.677526', 'yi.neko@gmail.com', 'buy', 'beige', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2319, 'GDF-PV14-Sirisi-C5', 1, 32011, 0, 5, 32011, 1, 32011, 32011, '2015-02-23 20:20:45.775398', 'yi.neko@gmail.com', 'buy', 'beige', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2320, 'GDF-PV14-Sirisi-C7', 2, 32011, 0, 5, 64022, 2, 32011, 64022, '2015-02-23 20:20:46.328842', 'yi.neko@gmail.com', 'buy', 'croco negro gris', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2321, 'GDF-PV14-Sirisi-C7', 1, 32011, 0, 5, 32011, 1, 32011, 32011, '2015-02-23 20:20:46.431068', 'yi.neko@gmail.com', 'buy', 'croco negro gris', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2322, 'GDF-PV14-Sirisi-C7', 9, 32011, 0, 5, 288099, 9, 32011, 288099, '2015-02-23 20:20:46.53457', 'yi.neko@gmail.com', 'buy', 'croco negro gris', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2323, 'GDF-PV14-Sirisi-C7', 6, 32011, 0, 5, 192066, 6, 32011, 192066, '2015-02-23 20:20:46.642208', 'yi.neko@gmail.com', 'buy', 'croco negro gris', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2324, 'GDF-PV14-Sirisi-C7', 4, 32011, 0, 5, 128044, 4, 32011, 128044, '2015-02-23 20:20:46.746456', 'yi.neko@gmail.com', 'buy', 'croco negro gris', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2325, 'GDF-PV14-Sirisi-C7', 1, 32011, 0, 5, 32011, 1, 32011, 32011, '2015-02-23 20:20:46.852046', 'yi.neko@gmail.com', 'buy', 'croco negro gris', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2326, 'GDF-PV14-Sirisi-C3', 1, 32011, 0, 5, 32011, 1, 32011, 32011, '2015-02-23 20:20:47.413797', 'yi.neko@gmail.com', 'buy', 'verde', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2327, 'GDF-PV14-Sirisi-C3', 2, 32011, 0, 5, 64022, 2, 32011, 64022, '2015-02-23 20:20:47.519283', 'yi.neko@gmail.com', 'buy', 'verde', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2328, 'GDF-PV14-Sirisi-C3', 3, 32011, 0, 5, 96033, 3, 32011, 96033, '2015-02-23 20:20:47.623228', 'yi.neko@gmail.com', 'buy', 'verde', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2329, 'GDF-PV14-Sirisi-C3', 1, 32011, 0, 5, 32011, 1, 32011, 32011, '2015-02-23 20:20:47.724713', 'yi.neko@gmail.com', 'buy', 'verde', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2330, 'GDF-PV14-Sirisi-C3', 1, 32011, 0, 5, 32011, 1, 32011, 32011, '2015-02-23 20:20:47.830813', 'yi.neko@gmail.com', 'buy', 'verde', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2331, 'GDF-PV14-Sirisi-C1', 3, 32011, 0, 5, 96033, 3, 32011, 96033, '2015-02-23 20:20:48.39653', 'yi.neko@gmail.com', 'buy', 'musgo', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2332, 'GDF-PV14-Sirisi-C1', 1, 32011, 0, 5, 32011, 1, 32011, 32011, '2015-02-23 20:20:48.498093', 'yi.neko@gmail.com', 'buy', 'musgo', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2333, 'GDF-PV14-Sirisi-C2', 3, 32011, 0, 5, 96033, 3, 32011, 96033, '2015-02-23 20:20:49.011954', 'yi.neko@gmail.com', 'buy', 'rosa viejo', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2334, 'GDF-PV14-Sirisi-C2', 3, 32011, 0, 5, 96033, 3, 32011, 96033, '2015-02-23 20:20:49.115756', 'yi.neko@gmail.com', 'buy', 'rosa viejo', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2335, 'GDF-PV14-Sirisi-C2', 1, 32011, 0, 5, 32011, 1, 32011, 32011, '2015-02-23 20:20:49.232153', 'yi.neko@gmail.com', 'buy', 'rosa viejo', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2336, 'GDF-PV14-Sirisi-C4', 1, 32011, 0, 5, 32011, 1, 32011, 32011, '2015-02-23 20:20:49.794869', 'yi.neko@gmail.com', 'buy', 'mostaza', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2337, 'GDF-PV14-Sirisi-C4', 4, 32011, 0, 5, 128044, 4, 32011, 128044, '2015-02-23 20:20:49.902005', 'yi.neko@gmail.com', 'buy', 'mostaza', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2338, 'GDF-PV14-Sirisi-C4', 3, 32011, 0, 5, 96033, 3, 32011, 96033, '2015-02-23 20:20:50.005214', 'yi.neko@gmail.com', 'buy', 'mostaza', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2339, 'GDF-PV14-Sirisi-C4', 2, 32011, 0, 5, 64022, 2, 32011, 64022, '2015-02-23 20:20:50.111343', 'yi.neko@gmail.com', 'buy', 'mostaza', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2340, 'GDF-OI14-Queltehue-C38', 1, 33558, 69900, 5, 33558, 0, 0, 0, '2015-02-24 04:03:21.113692', 'julian@loadingplay.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2341, 'GDF-OI14-Queltehue-C38', 1, 33558, 0, 12, 33558, 1, 33558, 33558, '2015-02-24 04:03:21.113692', 'julian@loadingplay.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2342, 'GDF-PV14-Sirisi-C8', 1, 32011, 67900, 5, 32011, 1, 32011, 32011, '2015-02-24 13:24:25.013724', 'yichun212@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2343, 'GDF-PV14-Sirisi-C8', 1, 32011, 0, 12, 32011, 1, 32011, 32011, '2015-02-24 13:24:25.013724', 'yichun212@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2344, 'GDF-OI14-Gavilan-C13', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-24 21:15:31.246299', 'javiera@gianidafirenze.cl', 'sell', 'café beige', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2345, 'GDF-OI14-Gavilan-C13', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-02-24 21:16:08.110385', 'javiera@gianidafirenze.cl', 'sell', 'café beige', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2346, 'GDF-OI14-Gavilan-C12', 1, 33558, 0, 5, 33558, 3, 33558, 100674, '2015-02-24 21:33:51.662255', 'javiera@gianidafirenze.cl', 'sell', 'verde beige', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2347, 'GDF-OI14-Gavilan-C12', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-02-24 21:34:28.471751', 'javiera@gianidafirenze.cl', 'sell', 'verde beige', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2348, 'GDF-OI14-Gavilan-C12', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-24 21:36:06.946125', 'javiera@gianidafirenze.cl', 'sell', 'verde beige', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2349, 'GDF-OI14-Gavilan-C12', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-02-24 21:39:15.917065', 'javiera@gianidafirenze.cl', 'sell', 'verde beige', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2350, 'GDF-PV14-Kereu-C5', 1, 34391, 0, 5, 34391, 1, 34391, 34391, '2015-02-24 23:25:05.385109', 'javiera@gianidafirenze.cl', 'sell', 'café verde', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2351, 'GDF-PV14-Kereu-C5', 1, 34391, 0, 5, 34391, 0, 0, 0, '2015-02-25 15:39:36.099641', 'javiera@gianidafirenze.cl', 'sell', 'café verde', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2352, 'GDF-PV14-Kereu-C3', 1, 34391, 0, 5, 34391, 0, 0, 0, '2015-02-25 15:41:59.594068', 'javiera@gianidafirenze.cl', 'sell', 'café negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2353, 'GDF-OI14-Gavilan-C12', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-02-25 20:06:55.990535', 'javiera@gianidafirenze.cl', 'sell', 'verde beige', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2354, 'GDF-PV14-Sirisi-C8', 1, 32011, 58990, 5, 32011, 0, 0, 0, '2015-02-25 22:01:07.609082', 'julian@larrea.cl', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2355, 'GDF-PV14-Sirisi-C8', 1, 32011, 0, 12, 32011, 2, 32011, 64022, '2015-02-25 22:01:07.609082', 'julian@larrea.cl', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2356, 'GDF-OI14-Queltehue-C30', 1, 33558, 59990, 5, 33558, 0, 0, 0, '2015-02-25 22:01:07.692518', 'julian@larrea.cl', 'mov_out', '', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2357, 'GDF-OI14-Queltehue-C30', 1, 33558, 0, 12, 33558, 1, 33558, 33558, '2015-02-25 22:01:07.692518', 'julian@larrea.cl', 'mov_in', '', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2358, 'GDF-OI14-Queltehue-C30', 1, 0, 59990, 5, 0, -1, 0, 0, '2015-02-25 22:01:07.77364', 'julian@larrea.cl', 'mov_out', '', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2359, 'GDF-OI14-Queltehue-C30', 1, 0, 0, 12, 0, 2, 16779, 33558, '2015-02-25 22:01:07.77364', 'julian@larrea.cl', 'mov_in', '', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2360, 'GDF-PV14-Sirisi-C8', 1, 32011, 0, 12, 32011, 1, 32011, 32011, '2015-02-25 22:02:46.139577', 'Sistema', 'mov_out', 'croco rojo', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2361, 'GDF-PV14-Sirisi-C8', 1, 32011, 0, 5, 32011, 1, 32011, 32011, '2015-02-25 22:02:46.139577', 'Sistema', 'mov_in', 'croco rojo', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2362, 'GDF-OI14-Queltehue-C30', 1, 16779, 0, 12, 16779, 1, 16779, 16779, '2015-02-25 22:02:46.170174', 'Sistema', 'mov_out', 'camel azul', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2363, 'GDF-OI14-Queltehue-C30', 1, 16779, 0, 5, 16779, 1, 16779, 16779, '2015-02-25 22:02:46.170174', 'Sistema', 'mov_in', 'camel azul', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2364, 'GDF-OI14-Queltehue-C30', 1, 16779, 0, 12, 16779, 0, 0, 0, '2015-02-25 22:02:46.201664', 'Sistema', 'mov_out', 'camel azul', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2365, 'GDF-OI14-Queltehue-C30', 1, 16779, 0, 5, 16779, 0, 0, 0, '2015-02-25 22:02:46.201664', 'Sistema', 'mov_in', 'camel azul', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2366, 'GDF-OI14-Gavilan-C10', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-25 22:04:56.566347', 'masg@gianidafirenze.cl', 'buy', 'café gris', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2367, 'GDF-OI14-Gavilan-C10', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-02-25 22:07:49.506206', 'masg@gianidafirenze.cl', 'sell', 'café gris', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2368, 'GDF-OI14-Gavilan-C11', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-02-26 12:35:03.4582', 'javiera@gianidafirenze.cl', 'sell', 'café beige', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2369, 'GDF-OI14-Queltehue-C39', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-02-26 17:00:35.471104', 'javiera@gianidafirenze.cl', 'sell', 'negro camel', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2370, 'GDF-OI14-Gavilan-C10', 1, 33558, 0, 5, 33558, 2, 33558, 67116, '2015-02-26 17:00:59.473316', 'javiera@gianidafirenze.cl', 'sell', 'café gris', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2371, 'GDF-OI14-Gavilan-C11', 1, 34950, 0, 5, 34950, 1, 34950, 34950, '2015-02-26 17:19:15.736576', 'javiera@gianidafirenze.cl', 'buy', 'café beige', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2372, 'GDF-OI14-Queltehue-C38', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-26 17:20:22.68744', 'javiera@gianidafirenze.cl', 'buy', 'café ocre', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2373, 'GDF-PV14-Kereu-C5', 1, 34391, 0, 5, 34391, 1, 34391, 34391, '2015-02-26 17:23:35.314904', 'javiera@gianidafirenze.cl', 'buy', 'café verde', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2374, 'GDF-PV14-Lile-C10', 3, 34510, 0, 5, 103530, 5, 34510, 172550, '2015-02-26 17:24:26.391457', 'javiera@gianidafirenze.cl', 'buy', 'camel', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2375, 'GDF-OI14-Gavilan-C13', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-02-26 17:42:33.371048', 'masg@gianidafirenze.cl', 'mov_out', 'café beige', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2376, 'GDF-OI14-Gavilan-C13', 1, 33558, 0, 12, 33558, 1, 33558, 33558, '2015-02-26 17:42:33.473033', 'masg@gianidafirenze.cl', 'mov_in', 'café beige', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2377, 'GDF-OI14-Queltehue-C16', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-26 17:42:57.549956', 'masg@gianidafirenze.cl', 'mov_out', 'beige taupe', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2378, 'GDF-OI14-Queltehue-C16', 1, 33558, 0, 12, 33558, 1, 33558, 33558, '2015-02-26 17:42:57.654573', 'masg@gianidafirenze.cl', 'mov_in', 'beige taupe', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2379, 'GDF-OI14-Queltehue-C38', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-02-26 17:43:20.579257', 'masg@gianidafirenze.cl', 'mov_out', 'café ocre', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2380, 'GDF-OI14-Queltehue-C38', 1, 33558, 0, 12, 33558, 1, 33558, 33558, '2015-02-26 17:43:20.692761', 'masg@gianidafirenze.cl', 'mov_in', 'café ocre', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2381, 'GDF-OI14-Gavilan-C13', 1, 33558, 59990, 12, 33558, 0, 0, 0, '2015-02-28 00:24:01.291633', 'Sistema', 'sell', 'café beige', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2382, 'GDF-OI14-Queltehue-C16', 1, 33558, 59990, 12, 33558, 0, 0, 0, '2015-02-28 00:24:01.331805', 'Sistema', 'sell', 'beige taupe', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2383, 'GDF-OI14-Queltehue-C38', 1, 33558, 59990, 12, 33558, 0, 0, 0, '2015-02-28 00:24:01.370528', 'Sistema', 'sell', 'café ocre', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2384, 'GDF-PV14-Lile-C8', 1, 34510, 0, 5, 34510, 1, 34510, 34510, '2015-03-02 15:08:12.639362', 'javiera@gianidafirenze.cl', 'sell', 'azul', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2385, 'GDF-PV14-Sirisi-C2', 1, 32011, 0, 5, 32011, 2, 32011, 64022, '2015-03-02 15:08:54.525295', 'javiera@gianidafirenze.cl', 'sell', 'rosa viejo', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2386, 'GDF-OI14-Queltehue-C39', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-03-03 00:05:49.716526', 'javiera@gianidafirenze.cl', 'sell', 'negro camel', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2387, 'GDF-OI14-Gavilan-C10', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-03-03 12:15:12.378909', 'javiera@gianidafirenze.cl', 'sell', 'café gris', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2388, 'GDF-OI14-Gavilan-C2', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-03-03 12:55:56.796763', 'javiera@gianidafirenze.cl', 'sell', 'negro', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2389, 'GDF-OI14-Gavilan-C10', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-03-04 22:00:24.925192', 'javiera@gianidafirenze.cl', 'sell', 'café gris', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2575, 'GDF-PV14-Kereu-C11', 1, 34391, 59990, 12, 34391, 0, 0, 0, '2015-03-10 21:59:25.292168', 'Sistema - Despacho', 'sell', 'café', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2390, 'GDF-OI14-Gavilan-C5', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-03-04 22:01:23.131622', 'javiera@gianidafirenze.cl', 'sell', 'verde gris', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2576, 'GDF-OI14-Gavilan-C12', 3, 33558, 0, 5, 100674, 0, 0, 0, '2015-03-11 18:05:42.653868', 'javiera@gianidafirenze.cl', 'sell', 'verde beige', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2581, 'GDF-OI14-Queltehue-C35', 1, 33558, 0, 5, 33558, 11, 33558, 369138, '2015-03-11 18:11:45.540025', 'javiera@gianidafirenze.cl', 'sell', 'azul café', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2585, 'GDF-PV14-Lile-C10', 1, 34510, 0, 5, 34510, 0, 0, 0, '2015-03-12 17:31:02.038962', 'javiera@gianidafirenze.cl', 'sell', 'camel', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2588, 'GDF-PV14-Lile-C10', 1, 34510, 0, 5, 34510, 0, 0, 0, '2015-03-12 17:32:06.622639', 'javiera@gianidafirenze.cl', 'sell', 'camel', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2591, 'GDF-OI14-Queltehue-C33', 1, 33558, 59990, 5, 33558, 0, 0, 0, '2015-03-15 18:54:16.939914', 'fannymondaca@hotmail.com', 'mov_out', '', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2592, 'GDF-OI14-Queltehue-C33', 1, 33558, 0, 12, 33558, 1, 33558, 33558, '2015-03-15 18:54:16.939914', 'fannymondaca@hotmail.com', 'mov_in', '', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2595, 'GDF-OI14-Gavilan-C10', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-03-16 22:36:10.499028', 'javiera@gianidafirenze.cl', 'sell', 'café gris', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2598, 'GDF-PV14-Lile-C1', 1, 34510, 0, 5, 34510, 0, 0, 0, '2015-03-19 16:02:36.569567', 'javiera@gianidafirenze.cl', 'sell', 'camel', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2577, 'GDF-OI14-Gavilan-C12', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-03-11 18:06:12.41643', 'javiera@gianidafirenze.cl', 'sell', 'verde beige', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2582, 'GDF-PV14-Lile-C8', 1, 34510, 0, 5, 34510, 1, 34510, 34510, '2015-03-11 18:12:53.130628', 'javiera@gianidafirenze.cl', 'sell', 'azul', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2586, 'GDF-PV14-Lile-C10', 1, 34510, 0, 5, 34510, 1, 34510, 34510, '2015-03-12 17:31:28.712215', 'javiera@gianidafirenze.cl', 'sell', 'camel', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2589, 'GDF-PV14-Lile-C8', 1, 34510, 0, 5, 34510, 0, 0, 0, '2015-03-12 18:09:39.629171', 'javiera@gianidafirenze.cl', 'sell', 'azul', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2593, 'GDF-PV14-Lile-C10', 1, 34510, 0, 5, 34510, 1, 34510, 34510, '2015-03-16 15:29:16.280504', 'javiera@gianidafirenze.cl', 'sell', 'camel', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2596, 'GDF-PV14-Lile-C1', 1, 34510, 0, 5, 34510, 1, 34510, 34510, '2015-03-18 12:57:48.868114', 'javiera@gianidafirenze.cl', 'sell', 'camel', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2457, 'GDF-OI14-Gavilan-C13', 1, 0, 59990, 5, 0, -1, 0, 0, '2015-03-05 21:04:37.614175', 'julian@larrea.cl', 'mov_out', '', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2458, 'GDF-OI14-Gavilan-C13', 1, 0, 0, 12, 0, 1, 0, 0, '2015-03-05 21:04:37.614175', 'julian@larrea.cl', 'mov_in', '', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2459, 'GDF-OI14-Queltehue-C30', 1, 33558, 59990, 5, 33558, 1, 33558, 33558, '2015-03-05 21:04:37.697347', 'julian@larrea.cl', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2460, 'GDF-OI14-Queltehue-C30', 1, 33558, 0, 12, 33558, 1, 33558, 33558, '2015-03-05 21:04:37.697347', 'julian@larrea.cl', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2461, 'GDF-OI14-Gavilan-C13', 1, 33558, 59990, 5, 33558, 0, 0, 0, '2015-03-05 21:14:45.021312', 'julian@larrea.cl', 'mov_out', '', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2462, 'GDF-OI14-Gavilan-C13', 1, 33558, 0, 12, 33558, 1, 33558, 33558, '2015-03-05 21:14:45.021312', 'julian@larrea.cl', 'mov_in', '', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2463, 'GDF-OI14-Queltehue-C16', 1, 33558, 59990, 5, 33558, 0, 0, 0, '2015-03-05 21:15:31.659981', 'julian@larrea.cl', 'mov_out', '', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2464, 'GDF-OI14-Queltehue-C16', 1, 33558, 0, 12, 33558, 1, 33558, 33558, '2015-03-05 21:15:31.659981', 'julian@larrea.cl', 'mov_in', '', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2466, 'GDF-OI14-Gavilan-C13', 1, 0, 59990, 12, 0, 0, 0, 0, '2015-03-05 21:44:28.879523', 'Sistema', 'sell', 'café beige', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2467, 'GDF-OI14-Queltehue-C30', 1, 33558, 59990, 12, 33558, 0, 0, 0, '2015-03-05 21:44:28.932067', 'Sistema', 'sell', 'camel azul', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2468, 'GDF-OI14-Gavilan-C11', 1, 34950, 59990, 5, 34950, 0, 0, 0, '2015-03-05 21:51:51.713073', 'julian@larrea.cl', 'mov_out', '', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2469, 'GDF-OI14-Gavilan-C11', 1, 34950, 0, 12, 34950, 1, 34950, 34950, '2015-03-05 21:51:51.713073', 'julian@larrea.cl', 'mov_in', '', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2470, 'GDF-PV14-Sirisi-C8', 1, 32011, 58990, 5, 32011, 0, 0, 0, '2015-03-05 21:54:17.54008', 'julian@larrea.cl', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2471, 'GDF-PV14-Sirisi-C8', 1, 32011, 0, 12, 32011, 2, 32011, 64022, '2015-03-05 21:54:17.54008', 'julian@larrea.cl', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2472, 'GDF-PV14-Kereu-C11', 1, 34391, 59990, 5, 34391, 1, 34391, 34391, '2015-03-08 19:20:27.321453', 'marywaves_@hotmail.com', 'mov_out', '', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2473, 'GDF-PV14-Kereu-C11', 1, 34391, 0, 12, 34391, 1, 34391, 34391, '2015-03-08 19:20:27.321453', 'marywaves_@hotmail.com', 'mov_in', '', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2474, 'GDF-PV14-Kereu-C11', 1, 34391, 59990, 5, 34391, 0, 0, 0, '2015-03-08 19:20:28.314687', 'marywaves_@hotmail.com', 'mov_out', '', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2475, 'GDF-PV14-Kereu-C11', 1, 34391, 0, 12, 34391, 2, 34391, 68782, '2015-03-08 19:20:28.314687', 'marywaves_@hotmail.com', 'mov_in', '', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2578, 'GDF-OI14-Gavilan-C6', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-03-11 18:09:25.956961', 'javiera@gianidafirenze.cl', 'sell', 'café', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2583, 'GDF-OI14-Queltehue-C30', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-03-11 18:13:39.757323', 'javiera@gianidafirenze.cl', 'sell', 'camel azul', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2559, 'GDF-PV14-Kereu-C5', 1, 34391, 0, 5, 34391, 0, 0, 0, '2015-03-09 22:42:38.823094', 'javiera@gianidafirenze.cl', 'sell', 'café verde', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2560, 'GDF-PV14-Lile-C8', 1, 34510, 0, 5, 34510, 0, 0, 0, '2015-03-10 13:15:03.183969', 'javiera@gianidafirenze.cl', 'sell', 'azul', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2561, 'GDF-OI14-Gavilan-C10', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-03-10 13:16:14.643333', 'javiera@gianidafirenze.cl', 'sell', 'café gris', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2562, 'GDF-OI14-Queltehue-C16', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-03-10 14:43:41.136685', 'javiera@gianidafirenze.cl', 'buy', 'beige taupe', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2563, 'GDF-OI14-Queltehue-C26', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-03-10 16:50:09.556836', 'javiera@gianidafirenze.cl', 'sell', 'camel café', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2564, 'GDF-OI14-Queltehue-C26', 2, 33558, 0, 5, 67116, 0, 0, 0, '2015-03-10 16:50:23.782281', 'javiera@gianidafirenze.cl', 'sell', 'camel café', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2565, 'GDF-PV14-Lile-C9', 1, 34510, 0, 5, 34510, 1, 34510, 34510, '2015-03-10 16:53:06.213919', 'javiera@gianidafirenze.cl', 'sell', 'azul', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2566, 'GDF-PV14-Lile-C8', 1, 34510, 0, 5, 34510, 2, 34510, 69020, '2015-03-10 16:53:41.213162', 'javiera@gianidafirenze.cl', 'sell', 'azul', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2567, 'GDF-OI14-Queltehue-C39', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-03-10 16:54:36.460628', 'javiera@gianidafirenze.cl', 'sell', 'negro camel', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2568, 'GDF-OI14-Queltehue-C39', 2, 33558, 0, 5, 67116, 2, 33558, 67116, '2015-03-10 16:55:05.619074', 'javiera@gianidafirenze.cl', 'sell', 'negro camel', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2569, 'GDF-OI14-Queltehue-C38', 2, 33558, 0, 5, 67116, 0, 0, 0, '2015-03-10 16:55:54.683171', 'javiera@gianidafirenze.cl', 'sell', 'café ocre', '39.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2570, 'GDF-OI14-Queltehue-C38', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-03-10 16:56:25.221417', 'javiera@gianidafirenze.cl', 'sell', 'café ocre', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2571, 'GDF-OI14-Queltehue-C38', 1, 33558, 0, 5, 33558, 0, 0, 0, '2015-03-10 16:56:39.316668', 'javiera@gianidafirenze.cl', 'sell', 'café ocre', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2572, 'GDF-OI14-Queltehue-C30', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-03-10 17:05:12.728244', 'javiera@gianidafirenze.cl', 'sell', 'camel azul', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2573, 'GDF-OI14-Queltehue-C30', 1, 33558, 0, 5, 33558, 2, 33558, 67116, '2015-03-10 17:05:43.484182', 'javiera@gianidafirenze.cl', 'sell', 'camel azul', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2396, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 3, 34391, 103173, '2015-03-05 17:54:56.039392', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2398, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 4, 34391, 137564, '2015-03-05 17:55:08.574735', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2400, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 5, 34391, 171955, '2015-03-05 17:55:22.833779', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2402, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 6, 34391, 206346, '2015-03-05 17:56:18.494006', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2404, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 7, 34391, 240737, '2015-03-05 17:56:30.278807', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2406, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 8, 34391, 275128, '2015-03-05 17:56:43.583117', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2408, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 9, 34391, 309519, '2015-03-05 17:57:02.110915', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2550, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 4, 34391, 137564, '2015-03-09 21:50:08.701325', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2552, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 3, 34391, 103173, '2015-03-09 21:50:08.809307', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2554, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 2, 34391, 68782, '2015-03-09 21:50:08.918', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2556, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 1, 34391, 34391, '2015-03-09 21:50:09.02839', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2558, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 12, 34391, 0, 34391, 0, '2015-03-09 21:51:00', 'Sistema', 'sell', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2526, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 16, 34391, 550256, '2015-03-09 21:49:40.978469', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2528, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 15, 34391, 515865, '2015-03-09 21:49:41.087748', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2536, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 11, 34391, 378301, '2015-03-09 21:49:41.524048', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2538, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 10, 34391, 343910, '2015-03-09 21:49:41.639468', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2540, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 9, 34391, 309519, '2015-03-09 21:50:08.151453', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2301, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, 1, 34391, 34391, '2015-02-23 20:20:41.438291', 'yi.neko@gmail.com', 'buy', 'negro', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2410, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 10, 34391, 343910, '2015-03-05 17:57:25.593677', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2392, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 1, 34391, 34391, '2015-03-05 17:54:24.735291', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2412, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 11, 34391, 378301, '2015-03-05 17:58:06.509199', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2414, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 12, 34391, 412692, '2015-03-05 17:58:26.924091', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2391, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, 0, 34391, 0, '2015-03-05 17:54:24.735291', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2401, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -5, 34391, -171955, '2015-03-05 17:56:18.494006', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2403, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -6, 34391, -206346, '2015-03-05 17:56:30.278807', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2405, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -7, 34391, -240737, '2015-03-05 17:56:43.583117', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2407, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -8, 34391, -275128, '2015-03-05 17:57:02.110915', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2409, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -9, 34391, -309519, '2015-03-05 17:57:25.593677', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2411, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -10, 34391, -343910, '2015-03-05 17:58:06.509199', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2413, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -11, 34391, -378301, '2015-03-05 17:58:26.924091', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2417, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -13, 34391, -447083, '2015-03-05 17:58:41.203601', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2419, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -14, 34391, -481474, '2015-03-05 17:59:42.635035', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2421, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -15, 34391, -515865, '2015-03-05 17:59:55.601492', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2423, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -16, 34391, -550256, '2015-03-05 18:00:54.870022', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2395, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -2, 34391, -68782, '2015-03-05 17:54:56.039392', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2397, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -3, 34391, -103173, '2015-03-05 17:55:08.574735', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2399, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -4, 34391, -137564, '2015-03-05 17:55:22.833779', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2416, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 13, 34391, 447083, '2015-03-05 17:58:31.976187', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2418, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 14, 34391, 481474, '2015-03-05 17:58:41.203601', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2420, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 15, 34391, 515865, '2015-03-05 17:59:42.635035', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2422, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 16, 34391, 550256, '2015-03-05 17:59:55.601492', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2424, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 17, 34391, 584647, '2015-03-05 18:00:54.870022', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2394, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 2, 34391, 68782, '2015-03-05 17:54:35.631081', 'cathi.pc@gmail.com', 'mov_in', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2533, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -12, 34391, -412692, '2015-03-09 21:49:41.305109', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2535, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -11, 34391, -378301, '2015-03-09 21:49:41.41808', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2537, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -10, 34391, -343910, '2015-03-09 21:49:41.524048', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2539, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -9, 34391, -309519, '2015-03-09 21:49:41.639468', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2541, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -8, 34391, -275128, '2015-03-09 21:50:08.151453', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2543, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -7, 34391, -240737, '2015-03-09 21:50:08.262459', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2545, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -6, 34391, -206346, '2015-03-09 21:50:08.370019', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2547, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -5, 34391, -171955, '2015-03-09 21:50:08.478542', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2549, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -4, 34391, -137564, '2015-03-09 21:50:08.588152', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2551, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -3, 34391, -103173, '2015-03-09 21:50:08.701325', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2553, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -2, 34391, -68782, '2015-03-09 21:50:08.809307', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2555, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -1, 34391, -34391, '2015-03-09 21:50:08.918', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2557, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, 0, 34391, 0, '2015-03-09 21:50:09.02839', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2527, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -15, 34391, -515865, '2015-03-09 21:49:40.978469', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2529, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -14, 34391, -481474, '2015-03-09 21:49:41.087748', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2531, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, -13, 34391, -447083, '2015-03-09 21:49:41.19562', 'Sistema', 'mov_in', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2530, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 14, 34391, 481474, '2015-03-09 21:49:41.19562', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2532, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 13, 34391, 447083, '2015-03-09 21:49:41.305109', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2534, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 12, 34391, 412692, '2015-03-09 21:49:41.41808', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2542, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 8, 34391, 275128, '2015-03-09 21:50:08.262459', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2544, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 7, 34391, 240737, '2015-03-09 21:50:08.370019', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2546, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 6, 34391, 206346, '2015-03-09 21:50:08.478542', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2548, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 12, 34391, 5, 34391, 171955, '2015-03-09 21:50:08.588152', 'Sistema', 'mov_out', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2393, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -1, 34391, -34391, '2015-03-05 17:54:35.631081', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2415, 'GDF-PV14-Kereu-C1', 1, 34391, 59990, 5, 34391, -12, 34391, -412692, '2015-03-05 17:58:31.976187', 'cathi.pc@gmail.com', 'mov_out', '', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2300, 'GDF-PV14-Kereu-C1', 1, 34391, 0, 5, 34391, 1, 34391, 34391, '2015-02-23 20:20:41.33612', 'yi.neko@gmail.com', 'buy', 'negro', '36.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2579, 'GDF-OI14-Queltehue-C35', 1, 33558, 0, 5, 33558, 1, 33558, 33558, '2015-03-11 18:11:24.838037', 'javiera@gianidafirenze.cl', 'sell', 'azul café', '35.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2584, 'GDF-OI14-Gavilan-C6', 2, 33558, 0, 5, 67116, 0, 0, 0, '2015-03-12 17:30:23.509185', 'javiera@gianidafirenze.cl', 'sell', 'café', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2587, 'GDF-PV14-Lile-C10', 3, 34510, 0, 5, 103530, 2, 34510, 69020, '2015-03-12 17:31:48.133068', 'javiera@gianidafirenze.cl', 'sell', 'camel', '37.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2590, 'GDF-PV14-Sirisi-C2', 1, 32011, 0, 5, 32011, 2, 32011, 64022, '2015-03-12 18:10:12.203146', 'javiera@gianidafirenze.cl', 'sell', 'rosa viejo', '38.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2594, 'GDF-PV14-Lile-C10', 1, 34510, 0, 5, 34510, 0, 0, 0, '2015-03-16 15:56:38.40157', 'javiera@gianidafirenze.cl', 'sell', 'camel', '40.0');
INSERT INTO "Kardex" (id, product_sku, units, price, sell_price, cellar_id, total, balance_units, balance_price, balance_total, date, "user", operation_type, color, size) VALUES (2597, 'GDF-OI14-Queltehue-C33', 1, 33558, 59990, 12, 33558, 0, 0, 0, '2015-03-19 13:25:45.834512', 'Sistema - Despacho', 'sell', 'café beige', '35.0');


--
-- Name: Kardex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Kardex_id_seq"', 2598, true);


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (281, '2015-02-20 23:35:55.290998', 1, 69900, 0, 0, 69900, 1, 1, 733, 69, 69, 1, 'web', '', 4, 'codigodespacho', 2);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (262, '2015-02-04 23:22:48.531058', 1, 69900, 2450, 0, 69900, 1, 1, 733, 69, 69, 1, 'web', '', 2, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (263, '2015-02-05 00:01:23.462434', 1, 489300, 26040, 0, 489300, 7, 5, 27, 31, 31, 1, 'web', '', 2, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (265, '2015-02-05 01:14:42.658658', 1, 69900, 0, 0, 69900, 1, 1, 27, 31, 31, 1, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (266, '2015-02-06 14:01:04.939812', 1, 209701, 0, 0, 209701, 4, 3, 27, 31, 31, 1, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (267, '2015-02-06 18:53:26.587566', 1, 139800, 14260, 0, 139800, 2, 1, 22, 70, 70, 1, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (268, '2015-02-06 18:55:37.414273', 1, 139800, 14260, 0, 139800, 2, 1, 22, 70, 70, 1, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (270, '2015-02-09 17:26:56.040902', 1, 69900, 0, 0, 69900, 1, 1, 733, 69, 69, 1, 'web', '', 4, 'RE123Correo', 2);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (264, '2015-02-05 00:31:50.251498', 1, 1, 0, 0, 1, 1, 1, 27, 31, 31, 2, 'web', '', 4, 'Orden264Chilexpress', 1);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (271, '2015-02-17 20:08:42.30893', 1, 279601, 0, 0, 279601, 5, 4, 27, 31, 31, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (273, '2015-02-17 20:18:19.428209', 1, 349501, 0, 0, 349501, 6, 5, 27, 31, 31, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (260, '2015-01-31 00:56:15.151287', 1, 139800, 7780, 0, 139800, 2, 2, 27, 31, 31, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (261, '2015-02-04 18:49:09.001374', 1, 1, 0, 0, 1, 1, 1, 733, 69, 69, 2, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (275, '2015-02-19 21:00:47.11141', 1, 69900, 0, 0, 69900, 1, 1, 27, 31, 31, 1, 'web', '', 3, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (274, '2015-02-19 20:49:28.721892', 1, 1, 0, 0, 1, 1, 1, 27, 31, 31, 2, 'web', '', 4, '1234', 1);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (276, '2015-02-19 21:01:17.279996', 1, 69900, 0, 0, 69900, 1, 1, 27, 31, 31, 1, 'web', '', 2, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (278, '2015-02-19 21:52:57.235429', 1, 1, 0, 0, 1, 1, 1, 27, 31, 31, 2, 'web', '', 3, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (280, '2015-02-19 22:32:16.243885', 1, 1, 0, 0, 1, 1, 1, 27, 31, 31, 2, 'web', '', 4, '1234', 1);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (283, '2015-02-24 04:03:21.080005', 1, 69900, 0, 0, 69900, 1, 1, 797, 71, 71, 1, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (286, '2015-02-24 13:18:00.48343', 1, 69900, 0, 0, 69900, 1, 1, 733, 69, 69, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (288, '2015-02-24 13:23:36.543033', 1, 1, 0, 0, 1, 1, 1, 733, 69, 69, 2, 'web', '', 2, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (290, '2015-02-24 14:28:46.813952', 1, 69900, 0, 0, 69900, 1, 1, 27, 31, 31, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (292, '2015-02-24 19:27:15.834605', 1, 119980, 7440, 0, 119980, 2, 2, 850, 72, 72, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (294, '2015-02-24 20:16:51.560717', 1, 119980, 7440, 0, 119980, 2, 2, 850, 72, 72, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (295, '2015-02-24 20:24:32.530296', 1, 179970, 11160, 0, 179970, 3, 3, 850, 72, 72, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (305, '2015-03-05 17:54:24.701859', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (298, '2015-02-25 16:04:56.443644', 1, 129890, 0, 0, 129890, 2, 2, 797, 71, 71, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (300, '2015-02-25 21:57:18.017541', 1, 198790, 0, 0, 198790, 3, 3, 27, 31, 31, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (301, '2015-02-25 22:01:07.575745', 1, 198790, 0, 0, 198790, 3, 3, 27, 31, 31, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (321, '2015-03-05 18:00:54.83385', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 4, '2194820246', 1);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (296, '2015-02-24 20:33:52.969733', 1, 179970, 11160, 0, 179970, 3, 3, 850, 72, 72, 2, 'web', '', 4, '2194820036', 1);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (303, '2015-03-03 19:29:35.906388', 1, 59990, 3900, 0, 59990, 1, 1, 1172, 76, 76, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (306, '2015-03-05 17:54:35.595428', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (307, '2015-03-05 17:54:56.008205', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (308, '2015-03-05 17:55:08.541537', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (309, '2015-03-05 17:55:22.798183', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (310, '2015-03-05 17:56:18.460428', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (311, '2015-03-05 17:56:30.246655', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (312, '2015-03-05 17:56:43.546428', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (323, '2015-03-05 21:14:44.98507', 1, 59990, 0, 0, 59990, 1, 1, 27, 31, 31, 1, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (324, '2015-03-05 21:15:31.627499', 1, 59990, 0, 0, 59990, 1, 1, 27, 31, 31, 1, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (322, '2015-03-05 21:04:37.581482', 1, 119980, 0, 0, 119980, 2, 2, 27, 31, 31, 1, 'web', '', 4, '1111', 1);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (325, '2015-03-05 21:51:51.680739', 1, 59990, 0, 0, 59990, 1, 1, 27, 31, 31, 1, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (326, '2015-03-05 21:54:17.505004', 1, 58990, 0, 0, 58990, 1, 1, 27, 31, 31, 1, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (329, '2015-03-07 14:23:43.835679', 1, 59990, 0, 0, 59990, 1, 1, 1384, 79, 79, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (333, '2015-03-07 23:20:28.170896', 1, 59990, 0, 0, 59990, 1, 1, 1416, 80, 80, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (335, '2015-03-07 23:25:17.031892', 1, 59990, 0, 0, 59990, 1, 1, 1416, 80, 80, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (313, '2015-03-05 17:57:02.079886', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (314, '2015-03-05 17:57:25.561947', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (315, '2015-03-05 17:58:06.474896', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (316, '2015-03-05 17:58:26.891913', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (317, '2015-03-05 17:58:31.942765', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (318, '2015-03-05 17:58:41.172807', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (331, '2015-03-07 17:44:03.409649', 1, 59990, 0, 0, 59990, 1, 1, 1384, 79, 79, 2, 'web', '', 3, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (337, '2015-03-08 19:19:28.831651', 1, 59990, 0, 0, 59990, 1, 1, 1416, 80, 80, 2, 'web', '', 4, '2194820235', 1);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (319, '2015-03-05 17:59:42.6031', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (320, '2015-03-05 17:59:55.569606', 1, 59990, 3890, 0, 59990, 1, 1, 1248, 77, 77, 1, 'web', '', 5, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (338, '2015-03-12 21:46:03.631849', 1, 59990, 3900, 0, 59990, 1, 1, 1704, 82, 82, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (339, '2015-03-14 19:02:52.115954', 1, 59990, 2450, 0, 59990, 1, 1, 1790, 83, 83, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (340, '2015-03-15 18:12:26.834028', 1, 59990, 3720, 0, 59990, 1, 1, 1846, 84, 84, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (341, '2015-03-15 18:41:12.474298', 1, 59990, 3780, 0, 59990, 1, 1, 1848, 86, 86, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (342, '2015-03-15 18:41:59.289379', 1, 59990, 3720, 0, 59990, 1, 1, 1846, 84, 84, 2, 'web', '', 1, NULL, NULL);
INSERT INTO "Order" (id, date, type, subtotal, shipping, tax, total, items_quantity, products_quantity, user_id, billing_id, shipping_id, payment_type, source, voucher, state, tracking_code, provider_id) VALUES (343, '2015-03-15 18:51:07.304545', 1, 59990, 3720, 0, 59990, 1, 1, 1846, 84, 84, 2, 'web', '', 4, '2194820110', 1);


--
-- Data for Name: Order_Detail; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (291, 1, 69900, 260, 114, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (292, 1, 69900, 260, 122, '39.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (293, 1, 1, 261, 117, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (294, 1, 69900, 262, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (295, 2, 139800, 263, 117, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (296, 1, 69900, 263, 117, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (297, 1, 69900, 263, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (298, 1, 69900, 263, 114, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (299, 2, 139800, 263, 114, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (300, 1, 1, 264, 117, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (301, 1, 69900, 265, 115, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (302, 1, 69900, 266, 114, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (303, 2, 139800, 266, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (304, 1, 1, 266, 117, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (305, 2, 139800, 267, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (306, 2, 139800, 268, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (307, 1, 69900, 270, 133, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (308, 2, 139800, 271, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (309, 1, 69900, 271, 114, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (310, 1, 69900, 271, 114, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (311, 1, 1, 271, 117, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (312, 2, 139800, 273, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (313, 1, 69900, 273, 114, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (314, 1, 69900, 273, 114, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (315, 1, 1, 273, 117, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (316, 1, 69900, 273, 122, '39.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (317, 1, 1, 274, 117, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (318, 1, 69900, 275, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (319, 1, 69900, 276, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (320, 1, 1, 278, 117, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (321, 1, 1, 280, 117, '38.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (322, 1, 69900, 281, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (323, 1, 69900, 283, 115, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (324, 1, 69900, 286, 118, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (325, 1, 1, 288, 141, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (326, 1, 69900, 290, 118, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (327, 1, 59990, 292, 121, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (328, 1, 59990, 292, 115, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (329, 1, 59990, 294, 121, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (330, 1, 59990, 294, 115, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (331, 1, 59990, 295, 121, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (332, 1, 59990, 295, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (333, 1, 59990, 295, 115, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (334, 1, 59990, 296, 121, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (335, 1, 59990, 296, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (336, 1, 59990, 296, 115, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (337, 1, 69900, 298, 118, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (338, 1, 59990, 298, 128, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (339, 1, 58990, 300, 141, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (340, 1, 69900, 300, 118, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (341, 1, 69900, 300, 118, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (342, 1, 58990, 301, 141, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (343, 1, 69900, 301, 118, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (344, 1, 69900, 301, 118, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (345, 1, 59990, 303, 117, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (346, 1, 59990, 305, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (347, 1, 59990, 306, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (348, 1, 59990, 307, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (349, 1, 59990, 308, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (350, 1, 59990, 309, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (351, 1, 59990, 310, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (352, 1, 59990, 311, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (353, 1, 59990, 312, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (354, 1, 59990, 313, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (355, 1, 59990, 314, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (356, 1, 59990, 315, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (357, 1, 59990, 316, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (358, 1, 59990, 317, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (359, 1, 59990, 318, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (360, 1, 59990, 319, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (361, 1, 59990, 320, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (362, 1, 59990, 321, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (363, 1, 59990, 322, 121, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (364, 1, 59990, 322, 118, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (365, 1, 59990, 323, 121, '40.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (366, 1, 59990, 324, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (367, 1, 59990, 325, 122, '39.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (368, 1, 58990, 326, 141, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (369, 1, 59990, 329, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (370, 1, 59990, 331, 137, '36.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (371, 1, 59990, 333, 134, '38.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (372, 1, 59990, 335, 134, '38.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (373, 1, 59990, 337, 134, '38.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (374, 1, 59990, 338, 118, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (375, 1, 59990, 339, 134, '40.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (376, 1, 59990, 340, 116, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (377, 1, 59990, 341, 118, '37.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (378, 1, 59990, 342, 119, '35.0');
INSERT INTO "Order_Detail" (id, quantity, subtotal, order_id, product_id, size) VALUES (379, 1, 59990, 343, 119, '35.0');


--
-- Name: Order_Detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Order_Detail_id_seq"', 379, true);


--
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Order_id_seq"', 343, true);


--
-- Data for Name: Payment_Types; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Payment_Types" (id, name) VALUES (1, 'Transferencia');
INSERT INTO "Payment_Types" (id, name) VALUES (2, 'Webpay');


--
-- Name: Payment_Types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Payment_Types_id_seq"', 2, true);


--
-- Name: Payment_Types_name_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Payment_Types_name_seq"', 1, false);


--
-- Data for Name: Permission; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Permission" (id, name) VALUES (1, 'acceso a api');
INSERT INTO "Permission" (id, name) VALUES (2, 'cargar productos nuevos');
INSERT INTO "Permission" (id, name) VALUES (3, 'vender');
INSERT INTO "Permission" (id, name) VALUES (4, 'modificar bodegas');
INSERT INTO "Permission" (id, name) VALUES (5, 'administrar usuarios');
INSERT INTO "Permission" (id, name) VALUES (6, 'ver informes');


--
-- Name: Permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Permission_id_seq"', 6, true);


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (127, 'GDF-OI14-Gavilan-C5', '<ul><li>Color: verde gris&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{37.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Gavilan-C5.png', '1_GDF-OI14-Gavilan-C5.png', '2_GDF-OI14-Gavilan-C5.png', 33558, 1, '', 'Calzur Ltda.', 'Gavilan C5', 'verde gris', '.', 69900, '', '', 0, '3_GDF-OI14-Gavilan-C5.png', '4_GDF-OI14-Gavilan-C5.png', '5_GDF-OI14-Gavilan-C5.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (117, 'GDF-OI14-Queltehue-C39', '<ul><li>Color: negro camel&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{37.0,38.0,39.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Queltehue-C39.png', '1_GDF-OI14-Queltehue-C39.png', '2_GDF-OI14-Queltehue-C39.png', 33558, 1, '', 'Calzur Ltda.', 'Queltehue C39', 'negro camel', '.', 69900, '', '', 1, '3_GDF-OI14-Queltehue-C39.png', '4_GDF-OI14-Queltehue-C39.png', '5_GDF-OI14-Queltehue-C39.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (141, 'GDF-PV14-Sirisi-C8', '<ul><li>Color:  croco rojo&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{36.0,37.0,38.0,40.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Sirisi-C8.png', '1_GDF-PV14-Sirisi-C8.png', '2_GDF-PV14-Sirisi-C8.png', 32011, 1, '', 'Calzur Ltda.', 'Sirisi C8', 'croco rojo', '.', 67900, '', '', 1, '3_GDF-PV14-Sirisi-C8.png', '4_GDF-PV14-Sirisi-C8.png', '5_GDF-PV14-Sirisi-C8.png', 58990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (122, 'GDF-OI14-Gavilan-C11', '<ul><li>Color: Café Beige&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{39.0,40.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Gavilan-C11.png', '1_GDF-OI14-Gavilan-C11.png', '2_GDF-OI14-Gavilan-C11.png', 33558, 1, '', 'Calzur Ltda.', 'Gavilan C11', 'café beige', '.', 69900, '', '', 1, '3_GDF-OI14-Gavilan-C11.png', '4_GDF-OI14-Gavilan-C11.png', '5_GDF-OI14-Gavilan-C11.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (120, 'GDF-OI14-Queltehue-C26', '<ul><li>Color: camel café&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0,37.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Queltehue-C26.png', '1_GDF-OI14-Queltehue-C26.png', '2_GDF-OI14-Queltehue-C26.png', 33558, 1, '', 'Calzur Ltda.', 'Queltehue C26', 'camel café', '.', 69900, '', '', 0, '3_GDF-OI14-Queltehue-C26.png', '4_GDF-OI14-Queltehue-C26.png', '5_GDF-OI14-Queltehue-C26.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (116, 'GDF-OI14-Queltehue-C16', '<ul><li>Color: beige taupe&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Queltehue-C16.png', '1_GDF-OI14-Queltehue-C16.png', '2_GDF-OI14-Queltehue-C16.png', 33558, 1, '', 'Calzur Ltda.', 'Queltehue C16', 'beige taupe', '.', 69900, '', '', 1, '3_GDF-OI14-Queltehue-C16.png', '4_GDF-OI14-Queltehue-C16.png', '5_GDF-OI14-Queltehue-C16.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (118, 'GDF-OI14-Queltehue-C30', '<ul><li>Color: camel azul&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0,36.0,37.0,38.0,39.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Queltehue-C30.png', '1_GDF-OI14-Queltehue-C30.png', '2_GDF-OI14-Queltehue-C30.png', 33558, 1, '', 'Calzur Ltda.', 'Queltehue C30', 'camel azul', '.', 69900, '', '', 1, '3_GDF-OI14-Queltehue-C30.png', '4_GDF-OI14-Queltehue-C30.png', '5_GDF-OI14-Queltehue-C30.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (121, 'GDF-OI14-Gavilan-C13', '<ul><li>Color: Café Beige</li><li>Capellada (material exterior): Cuero</li><li>Forro (material interior): Cuero</li><li>Plantilla: Cuero</li><li>Planta: (suela) Goma</li><li>Taco: Goma</li><li>Altura del Taco: 4,5 cm</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0,36.0,37.0,38.0,39.0,40.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Gavilan-C13.png', '1_GDF-OI14-Gavilan-C13.png', '2_GDF-OI14-Gavilan-C13.png', 33558, 1, '', 'Calzur Ltda.', 'Gavilan C13', 'café beige', '.', 69900, '', '', 0, '3_GDF-OI14-Gavilan-C13.png', '4_GDF-OI14-Gavilan-C13.png', '5_GDF-OI14-Gavilan-C13.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (119, 'GDF-OI14-Queltehue-C33', '<ul><li>Color: café beige&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0,40.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Queltehue-C33.png', '1_GDF-OI14-Queltehue-C33.png', '2_GDF-OI14-Queltehue-C33.png', 33558, 1, '', 'Calzur Ltda.', 'Queltehue C33', 'café beige', '.', 69900, '', '', 1, '3_GDF-OI14-Queltehue-C33.png', '4_GDF-OI14-Queltehue-C33.png', '5_GDF-OI14-Queltehue-C33.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (135, 'GDF-PV14-Kereu-C12', '<ul><li>Color: beige&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 6 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{36.0,37.0,40.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Kereu-C12.png', '1_GDF-PV14-Kereu-C12.png', '2_GDF-PV14-Kereu-C12.png', 34391, 1, '', 'Calzur Ltda.', 'Kereu C12', 'beige', '.', 69900, '', '', 1, '3_GDF-PV14-Kereu-C12.png', '4_GDF-PV14-Kereu-C12.png', '5_GDF-PV14-Kereu-C12.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (115, 'GDF-OI14-Queltehue-C38', '<ul><li>Color: café ocre&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{36.0,37.0,38.0,39.0,40.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Queltehue-C38.png', '1_GDF-OI14-Queltehue-C38.png', '2_GDF-OI14-Queltehue-C38.png', 33558, 1, '', 'Calzur Ltda.', 'Queltehue C38', 'café ocre', '.', 69900, '', '', 1, '3_GDF-OI14-Queltehue-C38.png', '4_GDF-OI14-Queltehue-C38.png', '5_GDF-OI14-Queltehue-C38.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (125, 'GDF-OI14-Gavilan-C6', '<ul><li>Color: café&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{37.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Gavilan-C6.png', '1_GDF-OI14-Gavilan-C6.png', '2_GDF-OI14-Gavilan-C6.png', 33558, 1, '', 'Calzur Ltda.', 'Gavilan C6', 'café', '.', 69900, '', '', 1, '3_GDF-OI14-Gavilan-C6.png', '4_GDF-OI14-Gavilan-C6.png', '5_GDF-OI14-Gavilan-C6.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (130, 'GDF-PV14-Lile-C2', '<ul><li>Color: rojo&nbsp;</li><li>Capellada (material exterior): Reno&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Madera&nbsp;</li><li>Taco: Madera&nbsp;</li><li>Altura del Taco: 7 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{37.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Lile-C2.png', '1_GDF-PV14-Lile-C2.png', '2_GDF-PV14-Lile-C2.png', 34510, 1, '', 'Calzur Ltda.', 'Lile C2', 'rojo', '.', 69900, '', '', 0, '3_GDF-PV14-Lile-C2.png', '4_GDF-PV14-Lile-C2.png', '5_GDF-PV14-Lile-C2.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (140, 'GDF-OI14-Queltehue-C31', '<ul><li>Color: Camel Rojo&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0,37.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Queltehue-C31.png', '1_GDF-OI14-Queltehue-C31.png', '2_GDF-OI14-Queltehue-C31.png', 33558, 1, '', 'Calzur Ltda.', 'Queltehue C31', 'camel rojo', '.', 69900, '', '', 1, '3_GDF-OI14-Queltehue-C31.png', '4_GDF-OI14-Queltehue-C31.png', '5_GDF-OI14-Queltehue-C31.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (137, 'GDF-PV14-Kereu-C1', '<ul><li>Color: negro&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Madera&nbsp;</li><li>Taco: Madera&nbsp;</li><li>Altura del Taco: 7 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{36.0,40.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Kereu-C1.png', '1_GDF-PV14-Kereu-C1.png', '2_GDF-PV14-Kereu-C1.png', 34391, 1, '', 'Calzur Ltda.', 'Kereu C1', 'negro', '.', 69900, '', '', 1, '3_GDF-PV14-Kereu-C1.png', '4_GDF-PV14-Kereu-C1.png', '5_GDF-PV14-Kereu-C1.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (131, 'GDF-PV14-Lile-C1', '<ul><li>Color: Camel&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 6 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{36.0,37.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Lile-C1.png', '1_GDF-PV14-Lile-C1.png', '2_GDF-PV14-Lile-C1.png', 34510, 1, '', 'Calzur Ltda.', 'Lile C1', 'camel', '.', 69900, '', '', 1, '3_GDF-PV14-Lile-C1.png', '4_GDF-PV14-Lile-C1.png', '5_GDF-PV14-Lile-C1.png', 0);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (132, 'GDF-PV14-Lile-C10', '<ul><li>Color: camel&nbsp;</li><li>Capellada (material exterior): Reno&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 6 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0,36.0,37.0,39.0,40.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Lile-C10.png', '1_GDF-PV14-Lile-C10.png', '2_GDF-PV14-Lile-C10.png', 34510, 1, '', 'Calzur Ltda.', 'Lile C10', 'camel', '.', 69900, '', '', 1, '3_GDF-PV14-Lile-C10.png', '4_GDF-PV14-Lile-C10.png', '5_GDF-PV14-Lile-C10.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (113, 'GDF-OI14-Queltehue-C35', 'Color: azul café Capellada (material exterior): Cuero Forro (material interior): Cuero Plantilla: Cuero Planta (suela): Goma Taco: Goma Altura del Taco: 4,5 cm Estilo: Botín', 'Giani Da Firenze', '{35.0,36.0,37.0,38.0,39.0,40.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Queltehue-C35.png', '1_GDF-OI14-Queltehue-C35.png', '2_GDF-OI14-Queltehue-C35.png', 33558, 1, '', 'Calzur Ltda.', 'Queltehue C35', 'azul café', '-', 69900, '', '', 1, '3_GDF-OI14-Queltehue-C35.png', '4_GDF-OI14-Queltehue-C35.png', '5_GDF-OI14-Queltehue-C35.png', 0);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (145, 'GDF-PV14-Sirisi-C3', '<ul><li>Color: verde&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{36.0,40.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Sirisi-C3.png', '1_GDF-PV14-Sirisi-C3.png', '2_GDF-PV14-Sirisi-C3.png', 32011, 1, '', 'Calzur Ltda.', 'Sirisi C3', 'verde', '.', 67900, '', '', 1, '3_GDF-PV14-Sirisi-C3.png', '4_GDF-PV14-Sirisi-C3.png', '5_GDF-PV14-Sirisi-C3.png', 58990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (148, 'GDF-PV14-Sirisi-C4', '<ul><li>Color: mostaza&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{36.0,37.0,38.0,39.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Sirisi-C4.png', '1_GDF-PV14-Sirisi-C4.png', '2_GDF-PV14-Sirisi-C4.png', 32011, 1, '', 'Calzur Ltda.', 'Sirisi C4', 'mostaza', '.', 67900, '', '', 1, '3_GDF-PV14-Sirisi-C4.png', '4_GDF-PV14-Sirisi-C4.png', '5_GDF-PV14-Sirisi-C4.png', 58990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (144, 'GDF-PV14-Sirisi-C7', '<ul><li>Color: croco negro gris&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{37.0,38.0,39.0,40.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Sirisi-C7.png', '1_GDF-PV14-Sirisi-C7.png', '2_GDF-PV14-Sirisi-C7.png', 32011, 1, '', 'Calzur Ltda.', 'Sirisi C7', 'croco negro gris', '.', 67900, '', '', 1, '3_GDF-PV14-Sirisi-C7.png', '4_GDF-PV14-Sirisi-C7.png', '5_GDF-PV14-Sirisi-C7.png', 58990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (142, 'GDF-PV14-Sirisi-C9', '<ul><li>Color: croco beige&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0,36.0,37.0,38.0,39.0,40.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Sirisi-C9.png', '1_GDF-PV14-Sirisi-C9.png', '2_GDF-PV14-Sirisi-C9.png', 32011, 1, '', 'Calzur Ltda.', 'Sirisi C9', 'croco beige', '.', 67900, '', '', 1, '3_GDF-PV14-Sirisi-C9.png', '4_GDF-PV14-Sirisi-C9.png', '5_GDF-PV14-Sirisi-C9.png', 58990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (133, 'GDF-PV14-Kereu-C6', '<ul><li>Color: azul&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 6 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{36.0,37.0,40.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Kereu-C6.png', '1_GDF-PV14-Kereu-C6.png', '2_GDF-PV14-Kereu-C6.png', 34391, 1, '', 'Calzur Ltda.', 'Kereu C6', 'azul', '.', 69900, '', '', 0, '3_GDF-PV14-Kereu-C6.png', '4_GDF-PV14-Kereu-C6.png', '5_GDF-PV14-Kereu-C6.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (123, 'GDF-OI14-Gavilan-C10', '<ul><li>Color: café gris&nbsp;<br></li><li>Capellada (material exterior): Cuero&nbsp;<br></li><li>Forro (material interior): Cuero&nbsp;<br></li><li>Plantilla: Cuero&nbsp;<br></li><li>Planta (suela): Goma&nbsp;<br></li><li>Taco: Goma&nbsp;<br></li><li>Altura del Taco: 4,5 cm&nbsp;<br></li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{37.0,38.0,39.0,40.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Gavilan-C10.png', '1_GDF-OI14-Gavilan-C10.png', '2_GDF-OI14-Gavilan-C10.png', 33558, 1, '', 'Calzur Ltda.', 'Gavilan C10', 'café gris', '.', 69900, '', '', 1, '3_GDF-OI14-Gavilan-C10.png', '4_GDF-OI14-Gavilan-C10.png', '5_GDF-OI14-Gavilan-C10.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (126, 'GDF-OI14-Gavilan-C2', '<ul><li>Color: negro&nbsp;</li><li>&nbsp;Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0,40.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Gavilan-C2.png', '1_GDF-OI14-Gavilan-C2.png', '2_GDF-OI14-Gavilan-C2.png', 33558, 1, '', 'Calzur Ltda.', 'Gavilan C2', 'negro', '.', 69900, '', '', 1, '3_GDF-OI14-Gavilan-C2.png', '4_GDF-OI14-Gavilan-C2.png', '5_GDF-OI14-Gavilan-C2.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (134, 'GDF-PV14-Kereu-C11', '<ul><li>Color: café&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 6 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{38.0,40.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Kereu-C11.png', '1_GDF-PV14-Kereu-C11.png', '2_GDF-PV14-Kereu-C11.png', 34391, 1, '', 'Calzur Ltda.', 'Kereu C11', 'café', '.', 69900, '', '', 1, '3_GDF-PV14-Kereu-C11.png', '4_GDF-PV14-Kereu-C11.png', '5_GDF-PV14-Kereu-C11.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (138, 'GDF-PV14-Kereu-C3', '<ul><li>Color: café negro&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 6 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0,36.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Kereu-C3.png', '1_GDF-PV14-Kereu-C3.png', '2_GDF-PV14-Kereu-C3.png', 34391, 1, '', 'Calzur Ltda.', 'Kereu C3', 'café negro', '.', 69900, '', '', 1, '3_GDF-PV14-Kereu-C3.png', '4_GDF-PV14-Kereu-C3.png', '5_GDF-PV14-Kereu-C3.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (136, 'GDF-PV14-Kereu-C5', '<ul><li>Color: café verde&nbsp;</li><li>Capellada (material exterior): Reno&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 6 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0,37.0,38.0,39.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Kereu-C5.png', '1_GDF-PV14-Kereu-C5.png', '2_GDF-PV14-Kereu-C5.png', 34391, 1, '', 'Calzur Ltda.', 'Kereu C5', 'café verde', '.', 69900, '', '', 1, '3_GDF-PV14-Kereu-C5.png', '4_GDF-PV14-Kereu-C5.png', '5_GDF-PV14-Kereu-C5.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (128, 'GDF-PV14-Lile-C8', '<ul><li>Color: azul&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 6 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{36.0,37.0,38.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Lile-C8.png', '1_GDF-PV14-Lile-C8.png', '2_GDF-PV14-Lile-C8.png', 34510, 1, '', 'Calzur Ltda.', 'Lile C8', 'azul', '.', 69900, '', '', 1, '3_GDF-PV14-Lile-C8.png', '4_GDF-PV14-Lile-C8.png', '5_GDF-PV14-Lile-C8.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (129, 'GDF-PV14-Lile-C9', '<ul><li>Color: azul&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 6 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{36.0,37.0,38.0,39.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Lile-C9.png', '1_GDF-PV14-Lile-C9.png', '2_GDF-PV14-Lile-C9.png', 34510, 1, '', 'Calzur Ltda.', 'Lile C9', 'azul', '.', 69900, '', '', 1, '3_GDF-PV14-Lile-C9.png', '4_GDF-PV14-Lile-C9.png', '5_GDF-PV14-Lile-C9.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (146, 'GDF-PV14-Sirisi-C1', '<ul><li>Color: musgo&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Madera&nbsp;</li><li>Taco: Madera&nbsp;</li><li>Altura del Taco: 7 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{37.0,38.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Sirisi-C1.png', '1_GDF-PV14-Sirisi-C1.png', '2_GDF-PV14-Sirisi-C1.png', 32011, 1, '', 'Calzur Ltda.', 'Sirisi C1', 'musgo', '.', 67900, '', '', 1, '3_GDF-PV14-Sirisi-C1.png', '4_GDF-PV14-Sirisi-C1.png', '5_GDF-PV14-Sirisi-C1.png', 58990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (147, 'GDF-PV14-Sirisi-C2', '<ul><li>Color: Rosa viejo&nbsp;</li><li>Capellada (material exterior): Reno&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Madera&nbsp;</li><li>Taco: Madera&nbsp;</li><li>Altura del Taco: 7 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{37.0,38.0,39.0,40.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Sirisi-C2.png', '1_GDF-PV14-Sirisi-C2.png', '2_GDF-PV14-Sirisi-C2.png', 32011, 1, '', 'Calzur Ltda.', 'Sirisi C2', 'rosa viejo', '.', 67900, '', '', 1, '3_GDF-PV14-Sirisi-C2.png', '4_GDF-PV14-Sirisi-C2.png', '5_GDF-PV14-Sirisi-C2.png', 58990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (143, 'GDF-PV14-Sirisi-C5', '<ul><li>Color: beige&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Madera&nbsp;</li><li>Taco: Madera&nbsp;</li><li>Altura del Taco: 7 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{37.0,38.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Sirisi-C5.png', '1_GDF-PV14-Sirisi-C5.png', '2_GDF-PV14-Sirisi-C5.png', 32011, 1, '', 'Calzur Ltda.', 'Sirisi C5', 'beige', '.', 67900, '', '', 1, '3_GDF-PV14-Sirisi-C5.png', '4_GDF-PV14-Sirisi-C5.png', '5_GDF-PV14-Sirisi-C5.png', 58990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (139, 'GDF-PV14-Lile-C13', '<ul><li>Color: beige&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 6 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0,36.0,37.0,38.0,40.0}', '', '', '', NULL, NULL, '0_GDF-PV14-Lile-C13.png', '1_GDF-PV14-Lile-C13.png', '2_GDF-PV14-Lile-C13.png', 34510, 1, '', 'Calzur Ltda.', 'Lile C13', 'Beige', '.', 69900, '', '', 1, '3_GDF-PV14-Lile-C13.png', '4_GDF-PV14-Lile-C13.png', '5_GDF-PV14-Lile-C13.png', 59900);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (124, 'GDF-OI14-Gavilan-C12', '<ul><li>Color: verde beige&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0,36.0,37.0,38.0,39.0,40.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Gavilan-C12.png', '1_GDF-OI14-Gavilan-C12.png', '2_GDF-OI14-Gavilan-C12.png', 33558, 1, '', 'Calzur Ltda.', 'Gavilan C12', 'verde beige', '.', 69900, '', '', 1, '3_GDF-OI14-Gavilan-C12.png', '4_GDF-OI14-Gavilan-C12.png', '5_GDF-OI14-Gavilan-C12.png', 59990);
INSERT INTO "Product" (id, sku, description, brand, size, material, bullet_1, bullet_2, currency, images, image, image_2, image_3, price, category_id, bullet_3, manufacturer, name, color, upc, sell_price, which_size, delivery, for_sale, image_4, image_5, image_6, promotion_price) VALUES (114, 'GDF-OI14-Queltehue-C19', '<ul><li>Color: café moro&nbsp;</li><li>Capellada (material exterior): Cuero&nbsp;</li><li>Forro (material interior): Cuero&nbsp;</li><li>Plantilla: Cuero&nbsp;</li><li>Planta (suela): Goma&nbsp;</li><li>Taco: Goma&nbsp;</li><li>Altura del Taco: 4,5 cm&nbsp;</li><li>Estilo: Botín<br></li></ul>', 'Giani Da Firenze', '{35.0,37.0,39.0}', '', '', '', NULL, NULL, '0_GDF-OI14-Queltehue-C19.png', '1_GDF-OI14-Queltehue-C19.png', '2_GDF-OI14-Queltehue-C19.png', 33558, 1, '', 'Calzur Ltda.', 'Queltehue C19', 'café moro', '.', 69900, '', '', 1, '3_GDF-OI14-Queltehue-C19.png', '4_GDF-OI14-Queltehue-C19.png', '5_GDF-OI14-Queltehue-C19.png', 59990);


--
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Product_id_seq"', 148, true);


--
-- Data for Name: Shipping; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (11, 3, 25, 0, 6690, 6690, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (12, 3, 26, 0, 4010, 4010, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (9, 3, 28, 0, 4480, 4480, true, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (10, 3, 27, 0, 7420, 7420, true, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (13, 3, 29, 0, 3890, 3890, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (14, 3, 12, 0, 3890, 3890, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (15, 3, 14, 0, 3890, 3890, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (16, 3, 30, 0, 3890, 3890, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (17, 3, 31, 0, 3720, 3720, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (18, 3, 33, 0, 3720, 3720, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (19, 3, 32, 0, 3720, 3720, true, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (21, 3, 13, 0, 3780, 3780, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (22, 3, 34, 0, 3780, 3780, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (23, 3, 21, 0, 3780, 3780, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (24, 3, 6, 0, 3780, 3780, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (25, 3, 20, 0, 3780, 3780, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (26, 3, 9, 0, 3780, 3780, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (27, 3, 35, 0, 3780, 3780, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (28, 3, 10, 0, 3900, 3900, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (29, 3, 4, 0, 3900, 3900, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (30, 3, 36, 0, 3900, 3900, true, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (32, 3, 37, 0, 4250, 4250, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (33, 3, 38, 0, 7130, 7130, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (34, 3, 11, 0, 7130, 7130, false, 1);
INSERT INTO "Shipping" (id, from_city_id, to_city_id, correos_price, chilexpress_price, price, edited, charge_type) VALUES (20, 3, 3, 0, 2450, 2450, true, 1);


--
-- Data for Name: Shipping_Provider; Type: TABLE DATA; Schema: public; Owner: yichun
--



--
-- Name: Shipping_Provider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Shipping_Provider_id_seq"', 1, false);


--
-- Name: Shipping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Shipping_id_seq"', 34, true);


--
-- Data for Name: State; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "State" (id, name) VALUES (2, 'Pagada');
INSERT INTO "State" (id, name) VALUES (3, 'Despachada');
INSERT INTO "State" (id, name) VALUES (4, 'Recibida');
INSERT INTO "State" (id, name) VALUES (5, 'Completada');
INSERT INTO "State" (id, name) VALUES (1, 'Pendiente');


--
-- Name: State_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"State_id_seq"', 5, true);


--
-- Data for Name: Tag; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Tag" (id, name, visible) VALUES (2, 'botines', 1);
INSERT INTO "Tag" (id, name, visible) VALUES (8, 'Autoctono', 0);
INSERT INTO "Tag" (id, name, visible) VALUES (14, 'Categoria nueva', 0);
INSERT INTO "Tag" (id, name, visible) VALUES (1, 'lo nuevo', 1);
INSERT INTO "Tag" (id, name, visible) VALUES (56, 'Gavilan', 1);
INSERT INTO "Tag" (id, name, visible) VALUES (58, 'Kereu', 1);
INSERT INTO "Tag" (id, name, visible) VALUES (60, 'Sirisi', 1);
INSERT INTO "Tag" (id, name, visible) VALUES (59, 'Lile', 1);
INSERT INTO "Tag" (id, name, visible) VALUES (57, 'Queltehue', 1);
INSERT INTO "Tag" (id, name, visible) VALUES (7, 'zapatos', 0);
INSERT INTO "Tag" (id, name, visible) VALUES (61, 'campaña', 1);


--
-- Data for Name: Tag_Product; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (540, 15, 8);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (541, 9, 8);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (542, 6, 8);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (543, 7, 8);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (544, 28, 8);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (545, 29, 8);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (546, 19, 8);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (547, 17, 8);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (548, 18, 8);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (434, 15, 7);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (549, 12, 8);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (436, 7, 7);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (437, 29, 7);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (438, 19, 7);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (439, 8, 7);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (440, 13, 7);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (550, 16, 8);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (551, 30, 8);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (882, 113, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (799, 133, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (800, 133, 58);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (558, 34, 7);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (559, 35, 7);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (561, 38, 7);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (807, 130, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (808, 130, 59);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (809, 128, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (810, 128, 59);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (811, 129, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (812, 129, 59);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (815, 146, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (889, 139, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (890, 139, 59);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (891, 139, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (892, 131, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (893, 131, 59);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (894, 131, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (816, 146, 60);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (817, 147, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (818, 147, 60);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (819, 145, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (820, 145, 60);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (821, 143, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (822, 143, 60);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (823, 148, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (824, 148, 1);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (825, 148, 60);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (826, 144, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (827, 144, 60);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (828, 141, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (493, 33, 7);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (829, 141, 60);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (830, 142, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (498, 6, 7);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (831, 142, 60);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (517, 11, 7);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (859, 126, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (860, 125, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (862, 114, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (863, 118, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (864, 140, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (750, 124, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (751, 124, 56);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (752, 121, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (753, 121, 56);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (754, 126, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (755, 126, 56);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (756, 127, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (757, 127, 56);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (758, 125, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (759, 125, 1);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (760, 125, 56);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (764, 114, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (765, 114, 1);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (766, 114, 57);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (866, 117, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (867, 137, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (770, 120, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (771, 120, 57);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (772, 119, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (773, 119, 57);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (868, 134, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (869, 135, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (870, 138, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (777, 118, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (778, 118, 1);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (779, 118, 57);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (780, 140, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (781, 140, 1);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (782, 140, 57);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (783, 117, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (784, 117, 1);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (785, 117, 57);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (786, 137, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (787, 137, 1);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (788, 137, 58);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (789, 134, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (790, 134, 1);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (791, 134, 58);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (792, 135, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (793, 135, 58);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (794, 138, 2);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (795, 138, 1);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (796, 138, 58);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (872, 133, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (876, 130, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (877, 128, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (878, 129, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (879, 146, 61);
INSERT INTO "Tag_Product" (id, product_id, tag_id) VALUES (880, 142, 61);


--
-- Name: Tag_Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Tag_Product_id_seq"', 894, true);


--
-- Name: Tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Tag_id_seq"', 61, true);


--
-- Name: Tag_name_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Tag_name_seq"', 1, false);


--
-- Data for Name: Temp_Cart; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (423, 113, '2015-02-02 21:15:02.805997', 1, 69900, 696, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (448, 117, '2015-02-05 21:48:01.272925', 1, 1, 16, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (452, 116, '2015-02-06 15:50:15.419248', 2, 139800, 22, '35.0', 52, 52, 2, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (400, 117, '2015-01-30 22:09:31.10427', 1, 69900, 656, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (432, 117, '2015-02-04 18:44:57.990051', 1, 1, 695, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (444, 116, '2015-02-05 03:23:09.096344', 1, 69900, 752, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (445, 117, '2015-02-05 03:23:36.498089', 2, 2, 752, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (411, 114, '2015-01-31 01:34:58.532858', 1, 69900, 671, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (446, 122, '2015-02-05 03:24:06.322866', 1, 69900, 752, '39.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (471, 115, '2015-02-21 04:30:28.599145', 1, 69900, 16, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (472, 116, '2015-02-21 04:50:19.794448', 1, 69900, 746, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (527, 127, '2015-03-02 18:42:18.7627', 1, 59990, 1105, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (474, 113, '2015-02-21 04:51:54.804337', 1, 69900, 745, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (412, 116, '2015-01-31 01:37:23.932123', 2, 139800, 671, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (406, 117, '2015-01-31 00:35:53.423264', 6, 419400, 671, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (415, 118, '2015-01-31 13:48:42.004064', 1, 69900, 682, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (417, 116, '2015-02-02 20:23:34.586908', 1, 69900, 688, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (421, 116, '2015-02-02 21:07:59.12567', 1, 69900, 694, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (422, 116, '2015-02-02 21:14:45.467483', 1, 69900, 696, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (528, 125, '2015-03-02 18:42:51.680786', 2, 119980, 1105, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (529, 146, '2015-03-02 19:37:43.645606', 1, 58990, 1108, '38.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (530, 126, '2015-03-02 22:57:28.171007', 1, 59990, 1120, '40.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (618, 116, '2015-03-23 00:31:22.267276', 1, 59990, 2181, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (488, 118, '2015-02-24 13:20:33.466448', 1, 69900, 807, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (490, 118, '2015-02-24 13:31:04.435993', 1, 69900, 809, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (491, 118, '2015-02-24 13:32:48.670273', 1, 69900, 810, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (492, 118, '2015-02-24 13:51:19.10549', 1, 69900, 733, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (479, 114, '2015-02-21 05:58:09.828345', 2, 139800, 39, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (493, 118, '2015-02-24 14:04:41.995336', 1, 69900, 818, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (480, 114, '2015-02-23 00:25:06.563541', 1, 69900, 793, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (481, 114, '2015-02-23 12:46:51.915302', 1, 69900, 794, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (482, 114, '2015-02-23 16:50:27.239208', 1, 69900, 795, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (483, 115, '2015-02-24 03:48:27.39426', 1, 69900, 796, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (494, 116, '2015-02-24 14:18:43.84715', 1, 69900, 819, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (495, 116, '2015-02-24 14:23:01.917148', 1, 69900, 820, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (496, 116, '2015-02-24 14:26:45.983459', 1, 69900, 821, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (536, 121, '2015-03-03 19:26:05.509885', 1, 59990, 1142, '40.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (548, 141, '2015-03-05 15:52:38.649888', 1, 58990, 1283, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (510, 125, '2015-02-26 03:03:25.165579', 1, 59990, 929, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (501, 121, '2015-02-24 18:49:37.184147', 1, 59990, 850, '35.0', 72, 72, 2, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (504, 116, '2015-02-24 20:22:35.954392', 1, 59990, 850, '35.0', 72, 72, 2, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (503, 115, '2015-02-24 20:14:26.444786', 1, 59990, 850, '37.0', 72, 72, 2, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (505, 117, '2015-02-24 20:36:50.425797', 1, 59990, 860, '38.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (506, 117, '2015-02-25 13:59:15.030908', 1, 59990, 854, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (533, 117, '2015-03-03 19:25:26.725603', 1, 59990, 1172, '37.0', 76, 76, 2, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (537, 121, '2015-03-03 20:13:09.425079', 1, 59990, 1179, '40.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (513, 127, '2015-02-26 20:06:59.102714', 1, 59990, 949, '37.0', 73, 73, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (514, 125, '2015-02-26 20:07:20.366719', 1, 59990, 949, '37.0', 73, 73, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (517, 134, '2015-02-27 23:15:28.324188', 1, 59990, 1000, '38.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (538, 124, '2015-03-03 20:15:03.577637', 1, 59990, 1179, '40.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (485, 118, '2015-02-24 04:23:54.490284', 1, 69900, 797, '35.0', 71, 71, 2, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (507, 128, '2015-02-25 15:56:11.114843', 1, 59990, 797, '36.0', 71, 71, 2, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (518, 123, '2015-02-28 02:58:48.46655', 1, 59990, 993, '38.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (539, 114, '2015-03-04 01:44:04.833032', 1, 59990, 1172, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (519, 127, '2015-03-01 00:34:26.495117', 1, 59990, 1026, '37.0', 74, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (520, 128, '2015-03-01 02:05:30.640514', 1, 59990, 1032, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (521, 122, '2015-03-01 03:06:49.098548', 1, 59990, 1033, '39.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (522, 137, '2015-03-01 18:57:45.390512', 1, 59990, 1042, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (540, 117, '2015-03-04 19:25:23.187413', 1, 59990, 1245, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (523, 137, '2015-03-01 20:43:51.407788', 3, 179970, 1054, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (572, 143, '2015-03-08 15:19:58.051128', 1, 58990, 1445, '38.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (549, 137, '2015-03-05 17:44:59.235746', 1, 59990, 1248, '36.0', 77, 77, 1, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (524, 117, '2015-03-02 18:30:52.189798', 1, 59990, 1100, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (525, 127, '2015-03-02 18:33:09.59959', 2, 119980, 1099, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (526, 127, '2015-03-02 18:36:13.063929', 1, 59990, 1101, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (556, 131, '2015-03-05 22:19:38.416455', 1, 59990, 1328, '37.0', 78, 78, 2, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (544, 127, '2015-03-04 20:38:22.337375', 1, 59990, 1237, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (545, 128, '2015-03-04 22:34:06.016098', 1, 59990, 1260, '38.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (557, 122, '2015-03-06 01:11:19.638889', 1, 59990, 1337, '40.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (558, 141, '2015-03-06 15:47:37.440183', 1, 58990, 1349, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (573, 120, '2015-03-08 17:37:32.648316', 1, 59990, 1451, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (560, 137, '2015-03-07 03:14:10.484742', 1, 59990, 1372, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (562, 137, '2015-03-07 17:40:52.020901', 1, 59990, 1384, '36.0', 79, 79, 2, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (563, 137, '2015-03-07 17:47:35.044269', 1, 59990, 1174, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (564, 137, '2015-03-07 19:01:18.25525', 1, 59990, 27, '36.0', 31, 31, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (576, 134, '2015-03-09 17:06:20.028941', 1, 59990, 1495, '40.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (579, 123, '2015-03-11 12:20:31.291191', 1, 59990, 829, '38.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (581, 118, '2015-03-11 13:04:19.143147', 1, 59990, 1607, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (582, 117, '2015-03-11 15:11:27.389154', 1, 59990, 1609, '38.0', 81, 81, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (583, 119, '2015-03-11 18:22:00.049316', 1, 59990, 1627, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (586, 131, '2015-03-12 22:02:37.635725', 1, 59990, 1706, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (585, 118, '2015-03-12 21:40:33.835356', 1, 59990, 1704, '37.0', 82, 82, 2, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (587, 117, '2015-03-13 11:21:43.189526', 1, 59990, 1736, '38.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (588, 115, '2015-03-14 03:22:51.394326', 1, 59990, 863, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (591, 143, '2015-03-14 19:01:41.472544', 1, 58990, 1808, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (593, 128, '2015-03-15 01:28:46.642904', 1, 59990, 1214, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (594, 123, '2015-03-15 16:47:06.580562', 1, 59990, 1843, '38.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (595, 115, '2015-03-15 16:48:51.20905', 1, 59990, 1843, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (577, 122, '2015-03-09 18:00:33.425502', 1, 59990, 1494, '40.0', 87, 87, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (598, 118, '2015-03-15 18:35:56.181114', 1, 59990, 1848, '37.0', 86, 86, 2, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (600, 122, '2015-03-17 10:49:49.747364', 1, 59990, 1927, '40.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (601, 141, '2015-03-17 13:36:47.208687', 1, 58990, 1886, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (602, 142, '2015-03-17 14:29:06.977149', 1, 58990, 1932, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (603, 142, '2015-03-17 14:30:41.268777', 1, 58990, 1933, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (604, 134, '2015-03-17 21:56:03.086381', 1, 59990, 1961, '40.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (607, 116, '2015-03-18 01:05:30.922008', 1, 59990, 1969, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (608, 129, '2015-03-19 13:56:00.679297', 2, 119980, 2038, '36.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (609, 139, '2015-03-19 21:39:32.618697', 1, 59900, 2052, '38.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (610, 114, '2015-03-20 03:29:37.372999', 1, 59990, 1986, '35.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (612, 146, '2015-03-21 02:54:12.368792', 1, 58990, 2104, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (614, 134, '2015-03-21 23:43:09.036052', 1, 59990, 1790, '40.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (615, 132, '2015-03-21 23:46:03.694286', 1, 59990, 1790, '37.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (616, 117, '2015-03-22 00:52:34.369484', 2, 119980, 2139, '38.0', NULL, NULL, NULL, 1, 0);
INSERT INTO "Temp_Cart" (id, product_id, date, quantity, subtotal, user_id, size, shipping_id, billing_id, payment_type, shipping_type, bought) VALUES (617, 117, '2015-03-22 18:36:05.609777', 3, 179970, 2167, '38.0', NULL, NULL, NULL, 1, 0);


--
-- Name: Temp_Cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Temp_Cart_id_seq"', 618, true);


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (735, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-04 16:33:43.719657', 1, '2015-02-04 16:33:43.719657', '2015-02-04 16:33:43.719657', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (632, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-11 15:00:35.416644', 1, '2015-01-11 15:00:35.416644', '2015-01-11 15:00:35.416644', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (633, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-18 00:17:00.787541', 1, '2015-01-18 00:17:00.787541', '2015-01-18 00:17:00.787541', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (690, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-02-02 19:16:37.747458', 1, '2015-02-02 19:16:37.747458', '2015-02-02 19:16:37.747458', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (742, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-04 20:35:56.693903', 1, '2015-02-04 20:35:56.693903', '2015-02-04 20:35:56.693903', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (647, '{}', 3, 'jjj', 'jjj@jjj.cl', 'j', '{}', '', '', '', NULL, '2015-01-29 22:37:45.127367', 1, '2015-01-29 22:37:45.127367', '2015-01-29 22:37:45.127367', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (698, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-02-02 23:03:47.030236', 1, '2015-02-02 23:03:47.030236', '2015-02-02 23:03:47.030236', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (780, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-19 16:56:41.681998', 1, '2015-02-19 16:56:41.681998', '2015-02-19 16:56:41.681998', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (712, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-04 14:23:51.227575', 1, '2015-02-04 14:23:51.227575', '2015-02-04 14:23:51.227575', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (482, '{}', 3, 'julian', 'julian@gianidafirenze.cl', 'juliano9', '{}', '', '', '', NULL, '2014-10-21 21:15:54.506648', 1, '2014-10-21 21:15:54.506648', '2014-10-21 21:15:54.506648', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (671, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-31 00:25:46.542471', 1, '2015-01-31 00:25:46.542471', '2015-01-31 00:25:46.542471', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (634, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-19 19:49:27.600905', 1, '2015-01-19 19:49:27.600905', '2015-01-19 19:49:27.600905', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (641, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-29 02:21:04.370691', 1, '2015-01-29 02:21:04.370691', '2015-01-29 02:21:04.370691', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (684, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-02-01 14:36:36.151636', 1, '2015-02-01 14:36:36.151636', '2015-02-01 14:36:36.151636', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (648, '{}', 3, 'aa', 'aa@aac.cl', 'aa', '{}', '', '', '', NULL, '2015-01-29 22:38:17.003275', 1, '2015-01-29 22:38:17.003275', '2015-01-29 22:38:17.003275', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (655, '{}', 3, 'm', 'm@m.cl', '1234', '{}', '', '', '', NULL, '2015-01-29 22:54:30.629855', 1, '2015-01-29 22:54:30.629855', '2015-01-29 22:54:30.629855', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (699, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-02-02 23:32:30.91811', 1, '2015-02-02 23:32:30.91811', '2015-02-02 23:32:30.91811', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (750, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-05 00:04:09.884078', 1, '2015-02-05 00:04:09.884078', '2015-02-05 00:04:09.884078', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (757, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-05 19:12:39.23515', 1, '2015-02-05 19:12:39.23515', '2015-02-05 19:12:39.23515', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (769, '{}', 3, 'Chien-Hung Lin', 'chienhung.lin@usach.cl', '90a8db953336c8dabbcf48b1592a8c06', '{}', '', '', '', NULL, '2015-02-09 15:36:11.481926', 1, '2015-02-09 15:36:11.481926', '2015-02-09 15:36:11.481926', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (781, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-19 16:57:56.671014', 1, '2015-02-19 16:57:56.671014', '2015-02-19 16:57:56.671014', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (667, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-30 20:17:15.021588', 1, '2015-01-30 20:17:15.021588', '2015-01-30 20:17:15.021588', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (635, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-20 21:31:34.442978', 1, '2015-01-20 21:31:34.442978', '2015-01-20 21:31:34.442978', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (679, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-31 01:59:42.426236', 1, '2015-01-31 01:59:42.426236', '2015-01-31 01:59:42.426236', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (685, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-02-01 15:55:17.371044', 1, '2015-02-01 15:55:17.371044', '2015-02-01 15:55:17.371044', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (642, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-29 22:16:46.529291', 1, '2015-01-29 22:16:46.529291', '2015-01-29 22:16:46.529291', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (737, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-04 16:40:02.159489', 1, '2015-02-04 16:40:02.159489', '2015-02-04 16:40:02.159489', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (656, '{}', 3, 'luisa', 'luisa@gmail.com', 'kika', '{}', '', '', '', NULL, '2015-01-29 22:54:58.042848', 1, '2015-01-29 22:54:58.042848', '2015-01-29 22:54:58.042848', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (744, '{}', 3, 'oscarito', 'master_egg@hotmail.com', '942d37c245cc6de02d159b3fa2986990', '{}', '', '', '', NULL, '2015-02-04 20:53:38.139672', 1, '2015-02-04 20:53:38.139672', '2015-02-04 20:53:38.139672', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (773, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-16 01:00:11.617801', 1, '2015-02-16 01:00:11.617801', '2015-02-16 01:00:11.617801', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (782, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-19 17:03:03.154813', 1, '2015-02-19 17:03:03.154813', '2015-02-19 17:03:03.154813', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (592, '{}', 3, 'CERTIFICACION', 'certificacion2@transbank.cl', '123456', '{}', '', '', '', NULL, '2014-12-05 20:16:08.91959', 1, '2014-12-05 20:16:08.91959', '2014-12-05 20:16:08.91959', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (621, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-04 04:33:39.318339', 1, '2015-01-04 04:33:39.318339', '2015-01-04 04:33:39.318339', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (643, '{}', 3, 'yichun', 'yi@sa.cl', '1234', '{}', '', '', '', NULL, '2015-01-29 22:25:02.020935', 1, '2015-01-29 22:25:02.020935', '2015-01-29 22:25:02.020935', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (745, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-04 23:12:07.796096', 1, '2015-02-04 23:12:07.796096', '2015-02-04 23:12:07.796096', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (694, '{}', 3, 'Rumy', 'aa@cl.cl', 'escuela', '{}', '', '', '', NULL, '2015-02-02 21:07:35.123216', 1, '2015-02-02 21:07:35.123216', '2015-02-02 21:07:35.123216', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (752, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-05 03:22:54.4468', 1, '2015-02-05 03:22:54.4468', '2015-02-05 03:22:54.4468', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (708, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-02-04 13:00:49.560349', 1, '2015-02-04 13:00:49.560349', '2015-02-04 13:00:49.560349', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (715, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-04 14:55:41.750423', 1, '2015-02-04 14:55:41.750423', '2015-02-04 14:55:41.750423', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (759, '{}', 3, 'cxzczx', 'cxzcxz@gmail.com', '35188f6c9a2638ec9685082515fd0581', '{}', '', '', '', NULL, '2015-02-05 20:04:35.16932', 1, '2015-02-05 20:04:35.16932', '2015-02-05 20:04:35.16932', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (776, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-17 20:18:36.731537', 1, '2015-02-17 20:18:36.731537', '2015-02-17 20:18:36.731537', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (15, '{}', 3, 'maria', 'maomao@gl.cl', '1234', '{5}', 'Larrea', '', 'Imprenta', NULL, '2014-09-16 14:58:36.87965', 1, '2014-09-16 14:59:30.2947', '2014-09-16 14:59:46.468531', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (644, '{}', 3, 'user', 'user@user.com', '1234', '{}', '', '', '', NULL, '2015-01-29 22:29:40.818581', 1, '2015-01-29 22:29:40.818581', '2015-01-29 22:29:40.818581', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (658, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-30 14:53:06.914677', 1, '2015-01-30 14:53:06.914677', '2015-01-30 14:53:06.914677', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (674, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-31 00:54:07.822459', 1, '2015-01-31 00:54:07.822459', '2015-01-31 00:54:07.822459', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (681, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-31 02:36:39.124585', 1, '2015-01-31 02:36:39.124585', '2015-01-31 02:36:39.124585', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (687, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-02-02 16:06:05.377887', 1, '2015-02-02 16:06:05.377887', '2015-02-02 16:06:05.377887', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (695, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-02-02 21:08:56.624748', 1, '2015-02-02 21:08:56.624748', '2015-02-02 21:08:56.624748', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (573, '{}', 3, 'SOPORTE WP', 'SOPORTE11@TRANSBANK.CL', '123456', '{}', '', '', '', NULL, '2014-11-29 02:12:28.175539', 1, '2014-11-29 02:12:28.175539', '2014-11-29 02:12:28.175539', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (27, '{}', 3, 'Julian Larrea', 'julian@larrea.cl', '', '{}', '', '', '', NULL, '2014-09-16 14:58:36.87965', 1, '2014-09-16 14:59:30.2947', '2014-09-16 14:59:46.468531', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (39, '{}', 3, 'Ricardo Silva', 'ricardo.silva.16761@gmail.com', 'escuela', '{}', '', '', '', NULL, '2014-09-16 16:20:38.450674', 1, '2014-09-16 16:20:38.450674', '2014-09-16 16:20:38.450674', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (22, '{}', 3, 'Philippe Snow', 'jarenasmuller@gmail.com', '01750bc4d244cb69bfbfbed7498986c1', '{}', '', '', '', NULL, '2014-09-16 14:58:36.87965', 1, '2014-09-16 14:59:30.2947', '2014-09-16 14:59:46.468531', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (403, '{}', 3, 'Rumy', 'rumy@test.com', '123456', '{}', '', '', '', NULL, '2014-09-25 16:47:39.889639', 1, '2014-09-25 16:47:39.889639', '2014-09-25 16:47:39.889639', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (16, '{}', 3, 'Ricardo Silva', 'elp3rr0@hotmail.com', '', '{}', '', '', '', NULL, '2014-09-16 14:58:36.87965', 1, '2014-09-16 14:59:30.2947', '2014-09-16 14:59:46.468531', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (473, '{}', 3, 'julian', 'nailuj41@gmail.com', 'juliano9', '{}', '', '', '', NULL, '2014-10-20 16:58:18.731775', 1, '2014-10-20 16:58:18.731775', '2014-10-20 16:58:18.731775', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (746, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-04 23:14:44.983368', 1, '2015-02-04 23:14:44.983368', '2015-02-04 23:14:44.983368', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (507, '{}', 3, 'PruebaTBK', 'aa@aa.com', '123456', '{}', '', '', '', NULL, '2014-10-25 23:07:54.297767', 1, '2014-10-25 23:07:54.297767', '2014-10-25 23:07:54.297767', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (622, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-05 08:25:22.138865', 1, '2015-01-05 08:25:22.138865', '2015-01-05 08:25:22.138865', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (760, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-06 18:30:40.842224', 1, '2015-02-06 18:30:40.842224', '2015-02-06 18:30:40.842224', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (777, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-17 20:18:46.014057', 1, '2015-02-17 20:18:46.014057', '2015-02-17 20:18:46.014057', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (675, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-31 01:26:51.733642', 1, '2015-01-31 01:26:51.733642', '2015-01-31 01:26:51.733642', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (682, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-31 13:46:40.459838', 1, '2015-01-31 13:46:40.459838', '2015-01-31 13:46:40.459838', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (432, '{}', 3, 'Ricardo Silva', 'contact@loadingplay.com', 'escuela16761', '{}', '', '', '', NULL, '2014-09-30 21:02:37.023855', 1, '2014-09-30 21:02:37.023855', '2014-09-30 21:02:37.023855', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (450, '{}', 3, 'soporte tbk', 'soporte9@tbk.cl', '12345', '{}', '', '', '', NULL, '2014-10-15 17:12:31.674706', 1, '2014-10-15 17:12:31.674706', '2014-10-15 17:12:31.674706', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (462, '{}', 3, 'TRANSBANK', 'soporte8@transbank.cl', '123456', '{}', '', '', '', NULL, '2014-10-19 02:17:37.519394', 1, '2014-10-19 02:17:37.519394', '2014-10-19 02:17:37.519394', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (688, '{}', 3, 'Wan Yu', 'wanxulina@gmail.com', '141192', '{}', '', '', '', NULL, '2015-02-02 16:18:12.153975', 1, '2015-02-02 16:18:12.153975', '2015-02-02 16:18:12.153975', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (696, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-02-02 21:12:53.405441', 1, '2015-02-02 21:12:53.405441', '2015-02-02 21:12:53.405441', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (630, '{1,2,3,6}', 1, 'Giani', 'giani@gianidafirenze.cl', '6982', '{5}', 'Rodriguez Grunert', '', '', NULL, '2015-01-07 14:03:57.730608', 1, '2015-01-07 14:03:57.730608', '2015-01-07 14:03:57.730608', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (638, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-23 18:01:45.097298', 1, '2015-01-23 18:01:45.097298', '2015-01-23 18:01:45.097298', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (645, '{}', 3, 'qwer', 'qwer@akdhajshd.com', '1234', '{}', '', '', '', NULL, '2015-01-29 22:31:15.714694', 1, '2015-01-29 22:31:15.714694', '2015-01-29 22:31:15.714694', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (652, '{}', 3, 'q', 'q@q.cl', 'q', '{}', '', '', '', NULL, '2015-01-29 22:50:55.621207', 1, '2015-01-29 22:50:55.621207', '2015-01-29 22:50:55.621207', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (710, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-04 14:16:37.619744', 1, '2015-02-04 14:16:37.619744', '2015-02-04 14:16:37.619744', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (733, '{}', 3, 'Yi Chun Lin', 'yichun212@gmail.com', '7423be50e9bd33a1edba6be478f3efc7', '{}', '', '', '', NULL, '2015-02-04 16:33:07.141029', 1, '2015-02-04 16:33:07.141029', '2015-02-04 16:33:07.141029', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (761, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-06 18:32:38.514672', 1, '2015-02-06 18:32:38.514672', '2015-02-06 18:32:38.514672', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (768, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-09 01:26:50.096219', 1, '2015-02-09 01:26:50.096219', '2015-02-09 01:26:50.096219', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (792, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-20 22:56:25.030665', 1, '2015-02-20 22:56:25.030665', '2015-02-20 22:56:25.030665', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (676, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-31 01:36:41.935487', 1, '2015-01-31 01:36:41.935487', '2015-01-31 01:36:41.935487', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (689, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-02-02 17:44:38.412614', 1, '2015-02-02 17:44:38.412614', '2015-02-02 17:44:38.412614', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (697, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-02-02 22:33:24.690065', 1, '2015-02-02 22:33:24.690065', '2015-02-02 22:33:24.690065', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (704, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-03 22:20:09.928305', 1, '2015-02-03 22:20:09.928305', '2015-02-03 22:20:09.928305', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (631, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-07 17:25:36.717328', 1, '2015-01-07 17:25:36.717328', '2015-01-07 17:25:36.717328', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (639, '{}', 5, '', '', '', '{}', '', '', '', NULL, '2015-01-23 23:27:26.780254', 1, '2015-01-23 23:27:26.780254', '2015-01-23 23:27:26.780254', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (646, '{}', 3, 'asAS', 'asd@lp.cl', '123', '{}', '', '', '', NULL, '2015-01-29 22:34:27.070167', 1, '2015-01-29 22:34:27.070167', '2015-01-29 22:34:27.070167', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (734, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-04 16:33:36.935674', 1, '2015-02-04 16:33:36.935674', '2015-02-04 16:33:36.935674', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (779, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-19 16:23:56.148318', 1, '2015-02-19 16:23:56.148318', '2015-02-19 16:23:56.148318', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (741, '{1,2,3,4,5,6}', 3, 'test', 'yi.neko@gmail.com', '0f193d2f1d94ef6fde97072eff98a6b7', '{5,12}', '', '', '', NULL, '2015-02-04 20:34:48.478421', 1, '2015-02-04 20:34:48.478421', '2015-02-04 20:34:48.478421', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (250, '{1,2,3,4,5,6}', 1, 'Miguel Angel', 'masg@gianidafirenze.cl', '81dc9bdb52d04dc20036dbd8313ed055', '{5,12}', 'Soto', '', '', NULL, '2014-09-22 03:21:21.901746', 1, '2014-09-22 03:21:21.901746', '2014-09-22 03:21:21.901746', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (793, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-21 05:47:53.878955', 1, '2015-02-21 05:47:53.878955', '2015-02-21 05:47:53.878955', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (794, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-21 20:56:11.595251', 1, '2015-02-21 20:56:11.595251', '2015-02-21 20:56:11.595251', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (795, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-23 12:47:28.955563', 1, '2015-02-23 12:47:28.955563', '2015-02-23 12:47:28.955563', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (796, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 03:48:09.149394', 1, '2015-02-24 03:48:09.149394', '2015-02-24 03:48:09.149394', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (797, '{}', 3, 'julian', 'julian@loadingplay.com', '0619180fa639db7598672caf15f0a74b', '{}', '', '', '', NULL, '2015-02-24 03:53:05.144393', 1, '2015-02-24 03:53:05.144393', '2015-02-24 03:53:05.144393', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (799, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 04:26:41.3467', 1, '2015-02-24 04:26:41.3467', '2015-02-24 04:26:41.3467', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (800, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 04:57:11.207322', 1, '2015-02-24 04:57:11.207322', '2015-02-24 04:57:11.207322', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (801, '{}', 3, 'Camila garces', 'camila.g94@hotmail.com', '710d41a78b3394f4070298c9933d5aef', '{}', '', '', '', NULL, '2015-02-24 08:29:04.163248', 1, '2015-02-24 08:29:04.163248', '2015-02-24 08:29:04.163248', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (802, '{}', 3, 'Monserrat Chandia Olate', 'monserrat.chandia@gmail.com', '0a8063851bd8947359df78ec711a2aaf', '{}', '', '', '', NULL, '2015-02-24 12:05:44.707126', 1, '2015-02-24 12:05:44.707126', '2015-02-24 12:05:44.707126', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (803, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 12:14:11.815238', 1, '2015-02-24 12:14:11.815238', '2015-02-24 12:14:11.815238', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (804, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 12:50:54.665352', 1, '2015-02-24 12:50:54.665352', '2015-02-24 12:50:54.665352', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (805, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 13:13:54.490297', 1, '2015-02-24 13:13:54.490297', '2015-02-24 13:13:54.490297', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (806, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 13:15:10.217518', 1, '2015-02-24 13:15:10.217518', '2015-02-24 13:15:10.217518', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (807, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 13:19:49.092387', 1, '2015-02-24 13:19:49.092387', '2015-02-24 13:19:49.092387', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (809, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 13:30:55.187232', 1, '2015-02-24 13:30:55.187232', '2015-02-24 13:30:55.187232', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (810, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 13:32:33.359426', 1, '2015-02-24 13:32:33.359426', '2015-02-24 13:32:33.359426', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (811, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 13:41:30.141738', 1, '2015-02-24 13:41:30.141738', '2015-02-24 13:41:30.141738', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (812, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 13:42:21.779574', 1, '2015-02-24 13:42:21.779574', '2015-02-24 13:42:21.779574', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (816, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 13:53:26.262103', 1, '2015-02-24 13:53:26.262103', '2015-02-24 13:53:26.262103', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (818, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 13:53:46.374154', 1, '2015-02-24 13:53:46.374154', '2015-02-24 13:53:46.374154', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (817, '{}', 3, 'maria jose maragaño', 'cotemaragano@hotmail.cl', 'd71fb7725de2ac59cda40f4d89d15b3c', '{}', '', '', '', NULL, '2015-02-24 13:53:43.077913', 1, '2015-02-24 13:53:43.077913', '2015-02-24 13:53:43.077913', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (819, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 14:11:33.85604', 1, '2015-02-24 14:11:33.85604', '2015-02-24 14:11:33.85604', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (820, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 14:22:36.101681', 1, '2015-02-24 14:22:36.101681', '2015-02-24 14:22:36.101681', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (821, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 14:25:26.581411', 1, '2015-02-24 14:25:26.581411', '2015-02-24 14:25:26.581411', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (822, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 14:28:14.834674', 1, '2015-02-24 14:28:14.834674', '2015-02-24 14:28:14.834674', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (823, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 14:28:39.583411', 1, '2015-02-24 14:28:39.583411', '2015-02-24 14:28:39.583411', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (824, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 14:29:56.477951', 1, '2015-02-24 14:29:56.477951', '2015-02-24 14:29:56.477951', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (826, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 14:55:08.445262', 1, '2015-02-24 14:55:08.445262', '2015-02-24 14:55:08.445262', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (827, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 15:05:19.750674', 1, '2015-02-24 15:05:19.750674', '2015-02-24 15:05:19.750674', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (828, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 15:07:06.3057', 1, '2015-02-24 15:07:06.3057', '2015-02-24 15:07:06.3057', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (830, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 15:29:17.787121', 1, '2015-02-24 15:29:17.787121', '2015-02-24 15:29:17.787121', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (831, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 15:37:16.550265', 1, '2015-02-24 15:37:16.550265', '2015-02-24 15:37:16.550265', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (832, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 15:38:34.984865', 1, '2015-02-24 15:38:34.984865', '2015-02-24 15:38:34.984865', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (833, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 15:45:32.327153', 1, '2015-02-24 15:45:32.327153', '2015-02-24 15:45:32.327153', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (834, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 15:58:01.178314', 1, '2015-02-24 15:58:01.178314', '2015-02-24 15:58:01.178314', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (835, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 16:00:29.077395', 1, '2015-02-24 16:00:29.077395', '2015-02-24 16:00:29.077395', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (836, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 16:20:29.579666', 1, '2015-02-24 16:20:29.579666', '2015-02-24 16:20:29.579666', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (837, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 16:38:10.003177', 1, '2015-02-24 16:38:10.003177', '2015-02-24 16:38:10.003177', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (838, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 16:49:31.60871', 1, '2015-02-24 16:49:31.60871', '2015-02-24 16:49:31.60871', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (839, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 16:51:41.525181', 1, '2015-02-24 16:51:41.525181', '2015-02-24 16:51:41.525181', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (840, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 17:21:33.754585', 1, '2015-02-24 17:21:33.754585', '2015-02-24 17:21:33.754585', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (841, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 17:29:07.668182', 1, '2015-02-24 17:29:07.668182', '2015-02-24 17:29:07.668182', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (842, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 17:38:21.542199', 1, '2015-02-24 17:38:21.542199', '2015-02-24 17:38:21.542199', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (843, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 17:46:47.473995', 1, '2015-02-24 17:46:47.473995', '2015-02-24 17:46:47.473995', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (844, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 17:53:14.008909', 1, '2015-02-24 17:53:14.008909', '2015-02-24 17:53:14.008909', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (845, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 18:00:25.796909', 1, '2015-02-24 18:00:25.796909', '2015-02-24 18:00:25.796909', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (846, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 18:04:47.8445', 1, '2015-02-24 18:04:47.8445', '2015-02-24 18:04:47.8445', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (848, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 18:20:04.116585', 1, '2015-02-24 18:20:04.116585', '2015-02-24 18:20:04.116585', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (849, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 18:31:42.934511', 1, '2015-02-24 18:31:42.934511', '2015-02-24 18:31:42.934511', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (850, '{}', 3, 'Marioly', 'marioly.sav@gmail.com', 'af2c7f69099de1644ed94be2c3f46fb8', '{}', '', '', '', NULL, '2015-02-24 18:44:32.903217', 1, '2015-02-24 18:44:32.903217', '2015-02-24 18:44:32.903217', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (851, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 18:50:02.814869', 1, '2015-02-24 18:50:02.814869', '2015-02-24 18:50:02.814869', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (852, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 19:00:16.960425', 1, '2015-02-24 19:00:16.960425', '2015-02-24 19:00:16.960425', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (853, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 19:01:35.237735', 1, '2015-02-24 19:01:35.237735', '2015-02-24 19:01:35.237735', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (854, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 19:04:22.530904', 1, '2015-02-24 19:04:22.530904', '2015-02-24 19:04:22.530904', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (855, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 19:41:21.724753', 1, '2015-02-24 19:41:21.724753', '2015-02-24 19:41:21.724753', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (856, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 19:50:00.464581', 1, '2015-02-24 19:50:00.464581', '2015-02-24 19:50:00.464581', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (857, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 20:05:04.968465', 1, '2015-02-24 20:05:04.968465', '2015-02-24 20:05:04.968465', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (858, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 20:20:15.761709', 1, '2015-02-24 20:20:15.761709', '2015-02-24 20:20:15.761709', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (859, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 20:31:51.609124', 1, '2015-02-24 20:31:51.609124', '2015-02-24 20:31:51.609124', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (860, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 20:32:13.555678', 1, '2015-02-24 20:32:13.555678', '2015-02-24 20:32:13.555678', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (861, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 20:48:02.801025', 1, '2015-02-24 20:48:02.801025', '2015-02-24 20:48:02.801025', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (862, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 20:51:23.210416', 1, '2015-02-24 20:51:23.210416', '2015-02-24 20:51:23.210416', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (864, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 21:27:24.814067', 1, '2015-02-24 21:27:24.814067', '2015-02-24 21:27:24.814067', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (865, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 21:32:02.37076', 1, '2015-02-24 21:32:02.37076', '2015-02-24 21:32:02.37076', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (866, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 21:37:08.124812', 1, '2015-02-24 21:37:08.124812', '2015-02-24 21:37:08.124812', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (867, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 22:01:01.708954', 1, '2015-02-24 22:01:01.708954', '2015-02-24 22:01:01.708954', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (829, '{}', 3, 'Gianina Rodriguez', 'gianiro@gmail.com', '8a05d98544d2e36f0ff195a406f11190', '{}', '', '', '', NULL, '2015-02-24 15:09:32.916757', 1, '2015-02-24 15:09:32.916757', '2015-02-24 15:09:32.916757', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (863, '{}', 3, 'Gabriela Rodríguez', 'gabyatacama@gmail.com', '3481f16c5608e7234b65b87a42b98e0f', '{}', '', '', '', NULL, '2015-02-24 21:06:27.132607', 1, '2015-02-24 21:06:27.132607', '2015-02-24 21:06:27.132607', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (868, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 22:47:59.943236', 1, '2015-02-24 22:47:59.943236', '2015-02-24 22:47:59.943236', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (869, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-24 23:47:15.123247', 1, '2015-02-24 23:47:15.123247', '2015-02-24 23:47:15.123247', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (870, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 00:03:31.905793', 1, '2015-02-25 00:03:31.905793', '2015-02-25 00:03:31.905793', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (871, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 00:48:36.742746', 1, '2015-02-25 00:48:36.742746', '2015-02-25 00:48:36.742746', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (872, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 00:57:48.784385', 1, '2015-02-25 00:57:48.784385', '2015-02-25 00:57:48.784385', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (873, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 01:07:56.11118', 1, '2015-02-25 01:07:56.11118', '2015-02-25 01:07:56.11118', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (874, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 01:20:35.616241', 1, '2015-02-25 01:20:35.616241', '2015-02-25 01:20:35.616241', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (875, '{}', 3, 'ANITA SANTANA', 'anita.santana@gmail.com', 'b422be585ab9e610594ecbba8f0a86de', '{}', '', '', '', NULL, '2015-02-25 01:20:44.142829', 1, '2015-02-25 01:20:44.142829', '2015-02-25 01:20:44.142829', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (876, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 01:30:35.395105', 1, '2015-02-25 01:30:35.395105', '2015-02-25 01:30:35.395105', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (878, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 02:03:51.166443', 1, '2015-02-25 02:03:51.166443', '2015-02-25 02:03:51.166443', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (877, '{}', 3, 'Belen', 'seguelbelen@gmail.com', '1d419d26520cc8e553f4259d9a12402e', '{}', '', '', '', NULL, '2015-02-25 01:34:20.980201', 1, '2015-02-25 01:34:20.980201', '2015-02-25 01:34:20.980201', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (879, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 02:33:21.454096', 1, '2015-02-25 02:33:21.454096', '2015-02-25 02:33:21.454096', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (880, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 02:52:35.775904', 1, '2015-02-25 02:52:35.775904', '2015-02-25 02:52:35.775904', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (881, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 03:02:50.267447', 1, '2015-02-25 03:02:50.267447', '2015-02-25 03:02:50.267447', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (882, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 03:05:40.649495', 1, '2015-02-25 03:05:40.649495', '2015-02-25 03:05:40.649495', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (883, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 03:12:53.701894', 1, '2015-02-25 03:12:53.701894', '2015-02-25 03:12:53.701894', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (884, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 03:26:15.189857', 1, '2015-02-25 03:26:15.189857', '2015-02-25 03:26:15.189857', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (885, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 04:57:21.584904', 1, '2015-02-25 04:57:21.584904', '2015-02-25 04:57:21.584904', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (886, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 07:10:11.279853', 1, '2015-02-25 07:10:11.279853', '2015-02-25 07:10:11.279853', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (887, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 12:35:23.155855', 1, '2015-02-25 12:35:23.155855', '2015-02-25 12:35:23.155855', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (888, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 13:09:46.692574', 1, '2015-02-25 13:09:46.692574', '2015-02-25 13:09:46.692574', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (889, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 14:06:00.640068', 1, '2015-02-25 14:06:00.640068', '2015-02-25 14:06:00.640068', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (890, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 15:09:05.360981', 1, '2015-02-25 15:09:05.360981', '2015-02-25 15:09:05.360981', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (891, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 15:12:29.7189', 1, '2015-02-25 15:12:29.7189', '2015-02-25 15:12:29.7189', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (892, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 15:17:49.402419', 1, '2015-02-25 15:17:49.402419', '2015-02-25 15:17:49.402419', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (893, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 15:28:42.455283', 1, '2015-02-25 15:28:42.455283', '2015-02-25 15:28:42.455283', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (894, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 15:31:56.30189', 1, '2015-02-25 15:31:56.30189', '2015-02-25 15:31:56.30189', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (895, '{}', 3, 'paulina vallejos', 'paulina.vallejos@alumnos.usm.cl', 'f2449cd0ce4547f8ed4e3b347fba4aa9', '{}', '', '', '', NULL, '2015-02-25 15:33:45.399913', 1, '2015-02-25 15:33:45.399913', '2015-02-25 15:33:45.399913', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (896, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 15:41:41.69252', 1, '2015-02-25 15:41:41.69252', '2015-02-25 15:41:41.69252', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (897, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 15:43:00.003829', 1, '2015-02-25 15:43:00.003829', '2015-02-25 15:43:00.003829', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (898, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 16:12:59.826169', 1, '2015-02-25 16:12:59.826169', '2015-02-25 16:12:59.826169', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (899, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 16:26:19.770424', 1, '2015-02-25 16:26:19.770424', '2015-02-25 16:26:19.770424', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (900, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 16:29:40.393267', 1, '2015-02-25 16:29:40.393267', '2015-02-25 16:29:40.393267', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (901, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 17:06:26.607068', 1, '2015-02-25 17:06:26.607068', '2015-02-25 17:06:26.607068', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (902, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 17:47:32.285403', 1, '2015-02-25 17:47:32.285403', '2015-02-25 17:47:32.285403', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (903, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 17:48:45.880012', 1, '2015-02-25 17:48:45.880012', '2015-02-25 17:48:45.880012', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (904, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 18:31:12.104832', 1, '2015-02-25 18:31:12.104832', '2015-02-25 18:31:12.104832', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (905, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 19:12:01.913972', 1, '2015-02-25 19:12:01.913972', '2015-02-25 19:12:01.913972', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (906, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 19:22:37.361529', 1, '2015-02-25 19:22:37.361529', '2015-02-25 19:22:37.361529', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (907, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 19:38:35.790273', 1, '2015-02-25 19:38:35.790273', '2015-02-25 19:38:35.790273', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (908, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 20:00:36.946675', 1, '2015-02-25 20:00:36.946675', '2015-02-25 20:00:36.946675', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (909, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 20:15:10.145451', 1, '2015-02-25 20:15:10.145451', '2015-02-25 20:15:10.145451', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (910, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 20:18:31.576981', 1, '2015-02-25 20:18:31.576981', '2015-02-25 20:18:31.576981', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (911, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 20:18:48.222146', 1, '2015-02-25 20:18:48.222146', '2015-02-25 20:18:48.222146', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (912, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 20:25:37.257756', 1, '2015-02-25 20:25:37.257756', '2015-02-25 20:25:37.257756', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (913, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 20:40:01.374613', 1, '2015-02-25 20:40:01.374613', '2015-02-25 20:40:01.374613', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (914, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 20:53:00.693164', 1, '2015-02-25 20:53:00.693164', '2015-02-25 20:53:00.693164', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (915, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 20:56:00.352448', 1, '2015-02-25 20:56:00.352448', '2015-02-25 20:56:00.352448', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (916, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 21:49:40.456635', 1, '2015-02-25 21:49:40.456635', '2015-02-25 21:49:40.456635', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (918, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 22:02:38.385512', 1, '2015-02-25 22:02:38.385512', '2015-02-25 22:02:38.385512', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (919, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-25 23:27:29.029404', 1, '2015-02-25 23:27:29.029404', '2015-02-25 23:27:29.029404', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (920, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 00:06:26.126191', 1, '2015-02-26 00:06:26.126191', '2015-02-26 00:06:26.126191', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (921, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 00:46:09.877467', 1, '2015-02-26 00:46:09.877467', '2015-02-26 00:46:09.877467', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (922, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 01:19:46.7217', 1, '2015-02-26 01:19:46.7217', '2015-02-26 01:19:46.7217', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (923, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 01:25:04.971506', 1, '2015-02-26 01:25:04.971506', '2015-02-26 01:25:04.971506', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (924, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 02:06:59.033748', 1, '2015-02-26 02:06:59.033748', '2015-02-26 02:06:59.033748', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (925, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 02:23:49.515318', 1, '2015-02-26 02:23:49.515318', '2015-02-26 02:23:49.515318', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (926, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 02:36:34.778009', 1, '2015-02-26 02:36:34.778009', '2015-02-26 02:36:34.778009', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (927, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 02:37:00.759844', 1, '2015-02-26 02:37:00.759844', '2015-02-26 02:37:00.759844', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (928, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 02:41:09.475434', 1, '2015-02-26 02:41:09.475434', '2015-02-26 02:41:09.475434', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (929, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 03:00:31.958592', 1, '2015-02-26 03:00:31.958592', '2015-02-26 03:00:31.958592', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (930, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 03:25:43.884111', 1, '2015-02-26 03:25:43.884111', '2015-02-26 03:25:43.884111', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (931, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 03:44:58.696292', 1, '2015-02-26 03:44:58.696292', '2015-02-26 03:44:58.696292', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (932, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 06:06:16.27834', 1, '2015-02-26 06:06:16.27834', '2015-02-26 06:06:16.27834', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (933, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 06:21:26.587929', 1, '2015-02-26 06:21:26.587929', '2015-02-26 06:21:26.587929', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (934, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 12:25:25.374433', 1, '2015-02-26 12:25:25.374433', '2015-02-26 12:25:25.374433', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (935, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 12:47:19.993257', 1, '2015-02-26 12:47:19.993257', '2015-02-26 12:47:19.993257', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (936, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 13:02:25.634937', 1, '2015-02-26 13:02:25.634937', '2015-02-26 13:02:25.634937', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (937, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 13:24:40.904103', 1, '2015-02-26 13:24:40.904103', '2015-02-26 13:24:40.904103', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (938, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 14:23:40.305181', 1, '2015-02-26 14:23:40.305181', '2015-02-26 14:23:40.305181', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (939, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 14:26:54.084265', 1, '2015-02-26 14:26:54.084265', '2015-02-26 14:26:54.084265', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (940, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 14:37:45.764838', 1, '2015-02-26 14:37:45.764838', '2015-02-26 14:37:45.764838', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (941, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 14:52:15.886346', 1, '2015-02-26 14:52:15.886346', '2015-02-26 14:52:15.886346', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (942, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 16:03:45.99071', 1, '2015-02-26 16:03:45.99071', '2015-02-26 16:03:45.99071', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (943, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 16:07:36.902896', 1, '2015-02-26 16:07:36.902896', '2015-02-26 16:07:36.902896', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (944, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 16:08:07.052262', 1, '2015-02-26 16:08:07.052262', '2015-02-26 16:08:07.052262', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (945, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 16:59:55.72158', 1, '2015-02-26 16:59:55.72158', '2015-02-26 16:59:55.72158', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (946, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 17:42:50.554211', 1, '2015-02-26 17:42:50.554211', '2015-02-26 17:42:50.554211', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (947, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 18:03:08.146013', 1, '2015-02-26 18:03:08.146013', '2015-02-26 18:03:08.146013', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (948, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 18:32:55.822775', 1, '2015-02-26 18:32:55.822775', '2015-02-26 18:32:55.822775', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (949, '{}', 3, 'Angélica Pérez Miranda', 'angiieeh@live.cl', '78922f88bb7841e6298fc1a656eb4e7e', '{}', '', '', '', NULL, '2015-02-26 18:34:19.416389', 1, '2015-02-26 18:34:19.416389', '2015-02-26 18:34:19.416389', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (950, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 18:37:48.2763', 1, '2015-02-26 18:37:48.2763', '2015-02-26 18:37:48.2763', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (951, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 19:01:21.748175', 1, '2015-02-26 19:01:21.748175', '2015-02-26 19:01:21.748175', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (953, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 19:40:26.247405', 1, '2015-02-26 19:40:26.247405', '2015-02-26 19:40:26.247405', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (954, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 19:55:48.173154', 1, '2015-02-26 19:55:48.173154', '2015-02-26 19:55:48.173154', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (955, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 20:00:31.455067', 1, '2015-02-26 20:00:31.455067', '2015-02-26 20:00:31.455067', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (956, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 20:28:21.111542', 1, '2015-02-26 20:28:21.111542', '2015-02-26 20:28:21.111542', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (957, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 21:07:22.914375', 1, '2015-02-26 21:07:22.914375', '2015-02-26 21:07:22.914375', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (958, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 21:07:32.127276', 1, '2015-02-26 21:07:32.127276', '2015-02-26 21:07:32.127276', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (959, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 21:27:49.617133', 1, '2015-02-26 21:27:49.617133', '2015-02-26 21:27:49.617133', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (960, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 21:54:10.245807', 1, '2015-02-26 21:54:10.245807', '2015-02-26 21:54:10.245807', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (961, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 22:45:43.017066', 1, '2015-02-26 22:45:43.017066', '2015-02-26 22:45:43.017066', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (962, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 23:11:27.326696', 1, '2015-02-26 23:11:27.326696', '2015-02-26 23:11:27.326696', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (963, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-26 23:37:42.439579', 1, '2015-02-26 23:37:42.439579', '2015-02-26 23:37:42.439579', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (964, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 00:16:13.483959', 1, '2015-02-27 00:16:13.483959', '2015-02-27 00:16:13.483959', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (965, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 00:44:13.008258', 1, '2015-02-27 00:44:13.008258', '2015-02-27 00:44:13.008258', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (966, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 00:47:01.54329', 1, '2015-02-27 00:47:01.54329', '2015-02-27 00:47:01.54329', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (967, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 01:06:27.325185', 1, '2015-02-27 01:06:27.325185', '2015-02-27 01:06:27.325185', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (968, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 01:23:49.625313', 1, '2015-02-27 01:23:49.625313', '2015-02-27 01:23:49.625313', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (969, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 01:39:33.387624', 1, '2015-02-27 01:39:33.387624', '2015-02-27 01:39:33.387624', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (970, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 01:48:18.335935', 1, '2015-02-27 01:48:18.335935', '2015-02-27 01:48:18.335935', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (971, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 02:05:21.671764', 1, '2015-02-27 02:05:21.671764', '2015-02-27 02:05:21.671764', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (972, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 02:16:48.841083', 1, '2015-02-27 02:16:48.841083', '2015-02-27 02:16:48.841083', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (973, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 02:21:35.007795', 1, '2015-02-27 02:21:35.007795', '2015-02-27 02:21:35.007795', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (974, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 02:39:25.691953', 1, '2015-02-27 02:39:25.691953', '2015-02-27 02:39:25.691953', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (975, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 02:47:20.538979', 1, '2015-02-27 02:47:20.538979', '2015-02-27 02:47:20.538979', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (976, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 02:50:01.123593', 1, '2015-02-27 02:50:01.123593', '2015-02-27 02:50:01.123593', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (977, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 02:50:34.511747', 1, '2015-02-27 02:50:34.511747', '2015-02-27 02:50:34.511747', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (978, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 03:14:08.440323', 1, '2015-02-27 03:14:08.440323', '2015-02-27 03:14:08.440323', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (979, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 03:14:22.809558', 1, '2015-02-27 03:14:22.809558', '2015-02-27 03:14:22.809558', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (980, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 03:18:02.642249', 1, '2015-02-27 03:18:02.642249', '2015-02-27 03:18:02.642249', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (981, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 03:46:08.902296', 1, '2015-02-27 03:46:08.902296', '2015-02-27 03:46:08.902296', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (982, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 03:46:42.882341', 1, '2015-02-27 03:46:42.882341', '2015-02-27 03:46:42.882341', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (983, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 03:46:52.700672', 1, '2015-02-27 03:46:52.700672', '2015-02-27 03:46:52.700672', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (984, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 05:02:37.698503', 1, '2015-02-27 05:02:37.698503', '2015-02-27 05:02:37.698503', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (985, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 13:10:03.592236', 1, '2015-02-27 13:10:03.592236', '2015-02-27 13:10:03.592236', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (986, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 13:54:01.352586', 1, '2015-02-27 13:54:01.352586', '2015-02-27 13:54:01.352586', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (987, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 14:25:08.100656', 1, '2015-02-27 14:25:08.100656', '2015-02-27 14:25:08.100656', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (988, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 14:29:24.15973', 1, '2015-02-27 14:29:24.15973', '2015-02-27 14:29:24.15973', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (989, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 15:35:58.546131', 1, '2015-02-27 15:35:58.546131', '2015-02-27 15:35:58.546131', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (990, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 16:32:18.148057', 1, '2015-02-27 16:32:18.148057', '2015-02-27 16:32:18.148057', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (991, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 17:05:44.623034', 1, '2015-02-27 17:05:44.623034', '2015-02-27 17:05:44.623034', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (992, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 17:26:15.778473', 1, '2015-02-27 17:26:15.778473', '2015-02-27 17:26:15.778473', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (994, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 18:08:21.170127', 1, '2015-02-27 18:08:21.170127', '2015-02-27 18:08:21.170127', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (995, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 18:25:17.761464', 1, '2015-02-27 18:25:17.761464', '2015-02-27 18:25:17.761464', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (996, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 18:39:13.188367', 1, '2015-02-27 18:39:13.188367', '2015-02-27 18:39:13.188367', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (997, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 21:37:21.783773', 1, '2015-02-27 21:37:21.783773', '2015-02-27 21:37:21.783773', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (998, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 22:18:10.853056', 1, '2015-02-27 22:18:10.853056', '2015-02-27 22:18:10.853056', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (999, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 22:59:41.216609', 1, '2015-02-27 22:59:41.216609', '2015-02-27 22:59:41.216609', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1000, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 23:10:34.831678', 1, '2015-02-27 23:10:34.831678', '2015-02-27 23:10:34.831678', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1001, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 23:24:49.530417', 1, '2015-02-27 23:24:49.530417', '2015-02-27 23:24:49.530417', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1002, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 23:30:20.602574', 1, '2015-02-27 23:30:20.602574', '2015-02-27 23:30:20.602574', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1003, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-27 23:43:24.959894', 1, '2015-02-27 23:43:24.959894', '2015-02-27 23:43:24.959894', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1004, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 00:28:18.730276', 1, '2015-02-28 00:28:18.730276', '2015-02-28 00:28:18.730276', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1005, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 00:41:20.015148', 1, '2015-02-28 00:41:20.015148', '2015-02-28 00:41:20.015148', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1006, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 00:48:12.655229', 1, '2015-02-28 00:48:12.655229', '2015-02-28 00:48:12.655229', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1007, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 01:10:15.043556', 1, '2015-02-28 01:10:15.043556', '2015-02-28 01:10:15.043556', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1008, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 01:49:58.915529', 1, '2015-02-28 01:49:58.915529', '2015-02-28 01:49:58.915529', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (993, '{}', 3, 'catalina herdenes', 'cataa_herdenes@hotmail.com', '097daa5450346f7593ae4f3fecefdc9c', '{}', '', '', '', NULL, '2015-02-27 17:56:06.045953', 1, '2015-02-27 17:56:06.045953', '2015-02-27 17:56:06.045953', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1009, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 03:17:18.001108', 1, '2015-02-28 03:17:18.001108', '2015-02-28 03:17:18.001108', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1010, '{}', 3, 'Claudia Aravena', 'c.aravenabernal@gmail.con', '65871369601026dffc028781c2f99e45', '{}', '', '', '', NULL, '2015-02-28 04:07:15.920934', 1, '2015-02-28 04:07:15.920934', '2015-02-28 04:07:15.920934', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1011, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 04:17:24.450504', 1, '2015-02-28 04:17:24.450504', '2015-02-28 04:17:24.450504', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1013, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 12:53:03.112299', 1, '2015-02-28 12:53:03.112299', '2015-02-28 12:53:03.112299', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1014, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 13:14:34.038953', 1, '2015-02-28 13:14:34.038953', '2015-02-28 13:14:34.038953', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1015, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 14:16:35.587339', 1, '2015-02-28 14:16:35.587339', '2015-02-28 14:16:35.587339', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1016, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 14:35:55.242306', 1, '2015-02-28 14:35:55.242306', '2015-02-28 14:35:55.242306', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1017, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 17:08:06.469528', 1, '2015-02-28 17:08:06.469528', '2015-02-28 17:08:06.469528', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1018, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 17:27:23.768236', 1, '2015-02-28 17:27:23.768236', '2015-02-28 17:27:23.768236', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1019, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 18:31:44.305621', 1, '2015-02-28 18:31:44.305621', '2015-02-28 18:31:44.305621', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1020, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 19:11:43.213068', 1, '2015-02-28 19:11:43.213068', '2015-02-28 19:11:43.213068', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1022, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 19:55:36.290455', 1, '2015-02-28 19:55:36.290455', '2015-02-28 19:55:36.290455', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1023, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-02-28 22:20:17.268363', 1, '2015-02-28 22:20:17.268363', '2015-02-28 22:20:17.268363', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1024, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 00:08:58.218941', 1, '2015-03-01 00:08:58.218941', '2015-03-01 00:08:58.218941', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1025, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 00:09:44.387596', 1, '2015-03-01 00:09:44.387596', '2015-03-01 00:09:44.387596', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1027, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 00:28:45.541817', 1, '2015-03-01 00:28:45.541817', '2015-03-01 00:28:45.541817', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1026, '{}', 3, 'Francisca ortiz', 'fca_ortiz@hotmail.com', 'd6f66597a1da2f7d1ec02c7f2af2c39d', '{}', '', '', '', NULL, '2015-03-01 00:18:36.067344', 1, '2015-03-01 00:18:36.067344', '2015-03-01 00:18:36.067344', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1028, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 00:41:41.074207', 1, '2015-03-01 00:41:41.074207', '2015-03-01 00:41:41.074207', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1029, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 00:44:08.004308', 1, '2015-03-01 00:44:08.004308', '2015-03-01 00:44:08.004308', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1030, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 01:29:34.549855', 1, '2015-03-01 01:29:34.549855', '2015-03-01 01:29:34.549855', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1031, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 01:51:32.102238', 1, '2015-03-01 01:51:32.102238', '2015-03-01 01:51:32.102238', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1032, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 01:54:57.473944', 1, '2015-03-01 01:54:57.473944', '2015-03-01 01:54:57.473944', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1033, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 03:00:24.300587', 1, '2015-03-01 03:00:24.300587', '2015-03-01 03:00:24.300587', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1034, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 03:11:25.465172', 1, '2015-03-01 03:11:25.465172', '2015-03-01 03:11:25.465172', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1035, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 03:23:58.442418', 1, '2015-03-01 03:23:58.442418', '2015-03-01 03:23:58.442418', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1036, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 04:14:22.363685', 1, '2015-03-01 04:14:22.363685', '2015-03-01 04:14:22.363685', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1037, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 04:33:43.043957', 1, '2015-03-01 04:33:43.043957', '2015-03-01 04:33:43.043957', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1038, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 05:07:40.957135', 1, '2015-03-01 05:07:40.957135', '2015-03-01 05:07:40.957135', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1039, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 06:23:37.819147', 1, '2015-03-01 06:23:37.819147', '2015-03-01 06:23:37.819147', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1040, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 12:26:42.887419', 1, '2015-03-01 12:26:42.887419', '2015-03-01 12:26:42.887419', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1041, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 13:12:23.910969', 1, '2015-03-01 13:12:23.910969', '2015-03-01 13:12:23.910969', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1042, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 13:15:57.107525', 1, '2015-03-01 13:15:57.107525', '2015-03-01 13:15:57.107525', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1043, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 13:46:22.034791', 1, '2015-03-01 13:46:22.034791', '2015-03-01 13:46:22.034791', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1044, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 14:34:43.218299', 1, '2015-03-01 14:34:43.218299', '2015-03-01 14:34:43.218299', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1045, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 14:42:49.303358', 1, '2015-03-01 14:42:49.303358', '2015-03-01 14:42:49.303358', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1046, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 16:19:13.70517', 1, '2015-03-01 16:19:13.70517', '2015-03-01 16:19:13.70517', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1047, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 16:26:44.54754', 1, '2015-03-01 16:26:44.54754', '2015-03-01 16:26:44.54754', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1048, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 16:34:13.6778', 1, '2015-03-01 16:34:13.6778', '2015-03-01 16:34:13.6778', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1049, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 16:39:28.100373', 1, '2015-03-01 16:39:28.100373', '2015-03-01 16:39:28.100373', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1050, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 16:52:11.561326', 1, '2015-03-01 16:52:11.561326', '2015-03-01 16:52:11.561326', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1051, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 18:23:30.225725', 1, '2015-03-01 18:23:30.225725', '2015-03-01 18:23:30.225725', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1052, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 19:44:29.165735', 1, '2015-03-01 19:44:29.165735', '2015-03-01 19:44:29.165735', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1053, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 19:59:29.298432', 1, '2015-03-01 19:59:29.298432', '2015-03-01 19:59:29.298432', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1054, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 20:38:46.06931', 1, '2015-03-01 20:38:46.06931', '2015-03-01 20:38:46.06931', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1055, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 21:27:39.827813', 1, '2015-03-01 21:27:39.827813', '2015-03-01 21:27:39.827813', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1056, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 22:08:04.901469', 1, '2015-03-01 22:08:04.901469', '2015-03-01 22:08:04.901469', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1057, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 22:33:45.954363', 1, '2015-03-01 22:33:45.954363', '2015-03-01 22:33:45.954363', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1058, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-01 22:55:44.764524', 1, '2015-03-01 22:55:44.764524', '2015-03-01 22:55:44.764524', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1059, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 00:10:34.831745', 1, '2015-03-02 00:10:34.831745', '2015-03-02 00:10:34.831745', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1060, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 00:11:22.54313', 1, '2015-03-02 00:11:22.54313', '2015-03-02 00:11:22.54313', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1061, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 00:25:25.605505', 1, '2015-03-02 00:25:25.605505', '2015-03-02 00:25:25.605505', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1062, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 00:53:42.19682', 1, '2015-03-02 00:53:42.19682', '2015-03-02 00:53:42.19682', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1063, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 01:41:06.925787', 1, '2015-03-02 01:41:06.925787', '2015-03-02 01:41:06.925787', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1064, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 01:44:03.438922', 1, '2015-03-02 01:44:03.438922', '2015-03-02 01:44:03.438922', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1065, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 02:33:45.475176', 1, '2015-03-02 02:33:45.475176', '2015-03-02 02:33:45.475176', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1066, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 02:33:57.410532', 1, '2015-03-02 02:33:57.410532', '2015-03-02 02:33:57.410532', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1067, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 02:40:36.150339', 1, '2015-03-02 02:40:36.150339', '2015-03-02 02:40:36.150339', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1068, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 03:12:58.718364', 1, '2015-03-02 03:12:58.718364', '2015-03-02 03:12:58.718364', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1069, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 03:16:07.512109', 1, '2015-03-02 03:16:07.512109', '2015-03-02 03:16:07.512109', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1070, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 03:25:13.3288', 1, '2015-03-02 03:25:13.3288', '2015-03-02 03:25:13.3288', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1071, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 03:33:23.242431', 1, '2015-03-02 03:33:23.242431', '2015-03-02 03:33:23.242431', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1072, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 04:19:16.684927', 1, '2015-03-02 04:19:16.684927', '2015-03-02 04:19:16.684927', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1073, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 05:53:26.423059', 1, '2015-03-02 05:53:26.423059', '2015-03-02 05:53:26.423059', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1074, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 09:08:51.568328', 1, '2015-03-02 09:08:51.568328', '2015-03-02 09:08:51.568328', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1075, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 09:16:46.300268', 1, '2015-03-02 09:16:46.300268', '2015-03-02 09:16:46.300268', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1076, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 12:02:24.490819', 1, '2015-03-02 12:02:24.490819', '2015-03-02 12:02:24.490819', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1077, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 12:17:10.863593', 1, '2015-03-02 12:17:10.863593', '2015-03-02 12:17:10.863593', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1078, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 12:19:38.032944', 1, '2015-03-02 12:19:38.032944', '2015-03-02 12:19:38.032944', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1079, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 12:21:02.754572', 1, '2015-03-02 12:21:02.754572', '2015-03-02 12:21:02.754572', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1080, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 13:07:00.285715', 1, '2015-03-02 13:07:00.285715', '2015-03-02 13:07:00.285715', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1081, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 13:53:10.290806', 1, '2015-03-02 13:53:10.290806', '2015-03-02 13:53:10.290806', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1082, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 13:54:44.808698', 1, '2015-03-02 13:54:44.808698', '2015-03-02 13:54:44.808698', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1083, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 14:05:03.23182', 1, '2015-03-02 14:05:03.23182', '2015-03-02 14:05:03.23182', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1084, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 14:12:24.344264', 1, '2015-03-02 14:12:24.344264', '2015-03-02 14:12:24.344264', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1085, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 14:24:59.169962', 1, '2015-03-02 14:24:59.169962', '2015-03-02 14:24:59.169962', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1086, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 14:49:26.606703', 1, '2015-03-02 14:49:26.606703', '2015-03-02 14:49:26.606703', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1087, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 14:56:37.973952', 1, '2015-03-02 14:56:37.973952', '2015-03-02 14:56:37.973952', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1088, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 15:04:13.735565', 1, '2015-03-02 15:04:13.735565', '2015-03-02 15:04:13.735565', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1089, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 15:16:07.025691', 1, '2015-03-02 15:16:07.025691', '2015-03-02 15:16:07.025691', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1090, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 15:29:54.030073', 1, '2015-03-02 15:29:54.030073', '2015-03-02 15:29:54.030073', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1091, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 15:40:16.305661', 1, '2015-03-02 15:40:16.305661', '2015-03-02 15:40:16.305661', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1092, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 16:04:19.093765', 1, '2015-03-02 16:04:19.093765', '2015-03-02 16:04:19.093765', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1093, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 16:12:16.496189', 1, '2015-03-02 16:12:16.496189', '2015-03-02 16:12:16.496189', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1094, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 16:17:53.3288', 1, '2015-03-02 16:17:53.3288', '2015-03-02 16:17:53.3288', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1095, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 16:48:40.305155', 1, '2015-03-02 16:48:40.305155', '2015-03-02 16:48:40.305155', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1096, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 16:55:41.251278', 1, '2015-03-02 16:55:41.251278', '2015-03-02 16:55:41.251278', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1097, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 18:21:20.61574', 1, '2015-03-02 18:21:20.61574', '2015-03-02 18:21:20.61574', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1098, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 18:27:42.82736', 1, '2015-03-02 18:27:42.82736', '2015-03-02 18:27:42.82736', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1099, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 18:28:28.426966', 1, '2015-03-02 18:28:28.426966', '2015-03-02 18:28:28.426966', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1100, '{}', 3, 'marcela', 'marcelaesc@gmail.com', '937179a96450e2812e913cd98ab18bcf', '{}', '', '', '', NULL, '2015-03-02 18:29:51.769967', 1, '2015-03-02 18:29:51.769967', '2015-03-02 18:29:51.769967', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1101, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 18:34:12.064953', 1, '2015-03-02 18:34:12.064953', '2015-03-02 18:34:12.064953', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1102, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 18:35:49.641372', 1, '2015-03-02 18:35:49.641372', '2015-03-02 18:35:49.641372', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1104, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 18:39:30.444762', 1, '2015-03-02 18:39:30.444762', '2015-03-02 18:39:30.444762', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1105, '{}', 3, 'Maria vidal', 'mvidalh@yahoo.es', '62299528825ab997300465f904083b6b', '{}', '', '', '', NULL, '2015-03-02 18:40:12.857233', 1, '2015-03-02 18:40:12.857233', '2015-03-02 18:40:12.857233', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1107, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 18:44:34.242879', 1, '2015-03-02 18:44:34.242879', '2015-03-02 18:44:34.242879', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1108, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 19:23:00.11924', 1, '2015-03-02 19:23:00.11924', '2015-03-02 19:23:00.11924', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1109, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 19:27:56.972048', 1, '2015-03-02 19:27:56.972048', '2015-03-02 19:27:56.972048', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1110, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 19:33:12.34509', 1, '2015-03-02 19:33:12.34509', '2015-03-02 19:33:12.34509', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1111, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 19:59:18.133263', 1, '2015-03-02 19:59:18.133263', '2015-03-02 19:59:18.133263', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1112, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 20:13:27.903804', 1, '2015-03-02 20:13:27.903804', '2015-03-02 20:13:27.903804', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1113, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 20:26:36.891277', 1, '2015-03-02 20:26:36.891277', '2015-03-02 20:26:36.891277', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1114, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 20:30:53.113201', 1, '2015-03-02 20:30:53.113201', '2015-03-02 20:30:53.113201', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1115, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 20:50:16.962762', 1, '2015-03-02 20:50:16.962762', '2015-03-02 20:50:16.962762', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1116, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 20:54:31.755914', 1, '2015-03-02 20:54:31.755914', '2015-03-02 20:54:31.755914', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1117, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 21:18:26.525251', 1, '2015-03-02 21:18:26.525251', '2015-03-02 21:18:26.525251', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1118, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 21:39:35.852643', 1, '2015-03-02 21:39:35.852643', '2015-03-02 21:39:35.852643', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1119, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 22:13:49.437869', 1, '2015-03-02 22:13:49.437869', '2015-03-02 22:13:49.437869', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1120, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 22:50:26.085184', 1, '2015-03-02 22:50:26.085184', '2015-03-02 22:50:26.085184', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1121, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 23:02:17.808686', 1, '2015-03-02 23:02:17.808686', '2015-03-02 23:02:17.808686', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1122, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 23:05:54.624118', 1, '2015-03-02 23:05:54.624118', '2015-03-02 23:05:54.624118', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1123, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 23:11:21.773728', 1, '2015-03-02 23:11:21.773728', '2015-03-02 23:11:21.773728', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1124, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 23:18:47.453434', 1, '2015-03-02 23:18:47.453434', '2015-03-02 23:18:47.453434', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1125, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 23:28:37.903678', 1, '2015-03-02 23:28:37.903678', '2015-03-02 23:28:37.903678', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1126, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-02 23:55:49.598253', 1, '2015-03-02 23:55:49.598253', '2015-03-02 23:55:49.598253', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1127, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 01:06:39.237891', 1, '2015-03-03 01:06:39.237891', '2015-03-03 01:06:39.237891', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1128, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 01:08:12.110286', 1, '2015-03-03 01:08:12.110286', '2015-03-03 01:08:12.110286', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1129, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 01:26:28.345093', 1, '2015-03-03 01:26:28.345093', '2015-03-03 01:26:28.345093', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1130, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 01:56:32.128533', 1, '2015-03-03 01:56:32.128533', '2015-03-03 01:56:32.128533', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1131, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 01:56:59.558301', 1, '2015-03-03 01:56:59.558301', '2015-03-03 01:56:59.558301', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1132, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 02:00:30.245589', 1, '2015-03-03 02:00:30.245589', '2015-03-03 02:00:30.245589', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1133, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 02:23:57.45961', 1, '2015-03-03 02:23:57.45961', '2015-03-03 02:23:57.45961', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1134, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 02:32:25.070498', 1, '2015-03-03 02:32:25.070498', '2015-03-03 02:32:25.070498', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1135, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 04:08:20.856287', 1, '2015-03-03 04:08:20.856287', '2015-03-03 04:08:20.856287', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1136, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 06:41:23.439314', 1, '2015-03-03 06:41:23.439314', '2015-03-03 06:41:23.439314', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1137, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 10:14:59.690689', 1, '2015-03-03 10:14:59.690689', '2015-03-03 10:14:59.690689', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1138, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 10:16:05.293835', 1, '2015-03-03 10:16:05.293835', '2015-03-03 10:16:05.293835', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1139, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 11:42:47.191624', 1, '2015-03-03 11:42:47.191624', '2015-03-03 11:42:47.191624', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1140, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 11:45:34.089046', 1, '2015-03-03 11:45:34.089046', '2015-03-03 11:45:34.089046', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1141, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 11:46:21.018501', 1, '2015-03-03 11:46:21.018501', '2015-03-03 11:46:21.018501', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1142, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 11:46:29.427319', 1, '2015-03-03 11:46:29.427319', '2015-03-03 11:46:29.427319', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1143, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 11:55:30.485824', 1, '2015-03-03 11:55:30.485824', '2015-03-03 11:55:30.485824', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1144, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 12:46:41.872177', 1, '2015-03-03 12:46:41.872177', '2015-03-03 12:46:41.872177', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1145, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 13:07:36.109715', 1, '2015-03-03 13:07:36.109715', '2015-03-03 13:07:36.109715', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1146, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 13:07:39.251808', 1, '2015-03-03 13:07:39.251808', '2015-03-03 13:07:39.251808', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1147, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 13:10:02.060163', 1, '2015-03-03 13:10:02.060163', '2015-03-03 13:10:02.060163', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (8, '{1,2,3,4,5,6}', 1, 'Ricardo', 'ricardo@loadingplay.com', '20b0d5ee97255d7ad48933ec61f2c49b', '{5}', 'silva', '', '', '2014-09-21 00:00:00', '2014-09-16 14:58:36.87965', 1, '2014-09-16 14:59:30.2947', '2014-09-16 14:59:46.468531', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1148, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 13:12:10.425958', 1, '2015-03-03 13:12:10.425958', '2015-03-03 13:12:10.425958', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1149, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 13:48:38.227891', 1, '2015-03-03 13:48:38.227891', '2015-03-03 13:48:38.227891', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1150, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 13:53:04.993828', 1, '2015-03-03 13:53:04.993828', '2015-03-03 13:53:04.993828', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1151, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 13:58:07.231417', 1, '2015-03-03 13:58:07.231417', '2015-03-03 13:58:07.231417', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1152, '{}', 3, 'Omar Saldias', 'omansadu19@gmail.com', 'f045ef886564d5bce20f6ef7c18b7d62', '{}', '', '', '', NULL, '2015-03-03 15:01:28.669068', 1, '2015-03-03 15:01:28.669068', '2015-03-03 15:01:28.669068', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1153, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 15:45:06.928521', 1, '2015-03-03 15:45:06.928521', '2015-03-03 15:45:06.928521', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1154, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 16:30:24.707335', 1, '2015-03-03 16:30:24.707335', '2015-03-03 16:30:24.707335', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1155, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 16:43:20.267863', 1, '2015-03-03 16:43:20.267863', '2015-03-03 16:43:20.267863', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1156, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 16:44:30.968072', 1, '2015-03-03 16:44:30.968072', '2015-03-03 16:44:30.968072', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1158, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 16:48:49.086901', 1, '2015-03-03 16:48:49.086901', '2015-03-03 16:48:49.086901', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1159, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 16:50:13.522731', 1, '2015-03-03 16:50:13.522731', '2015-03-03 16:50:13.522731', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1157, '{}', 3, 'Valentina Gatica Gallegos', 'valentinagaticag@gmail.com', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 16:47:26.661112', 1, '2015-03-03 16:47:26.661112', '2015-03-03 16:47:26.661112', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1160, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 17:14:49.029888', 1, '2015-03-03 17:14:49.029888', '2015-03-03 17:14:49.029888', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1161, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 17:53:49.236576', 1, '2015-03-03 17:53:49.236576', '2015-03-03 17:53:49.236576', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1162, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 17:58:59.166989', 1, '2015-03-03 17:58:59.166989', '2015-03-03 17:58:59.166989', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1163, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 18:03:44.766003', 1, '2015-03-03 18:03:44.766003', '2015-03-03 18:03:44.766003', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1164, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 18:04:17.690674', 1, '2015-03-03 18:04:17.690674', '2015-03-03 18:04:17.690674', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1165, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 18:14:19.953499', 1, '2015-03-03 18:14:19.953499', '2015-03-03 18:14:19.953499', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1166, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 18:20:49.617564', 1, '2015-03-03 18:20:49.617564', '2015-03-03 18:20:49.617564', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1167, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 18:42:47.385826', 1, '2015-03-03 18:42:47.385826', '2015-03-03 18:42:47.385826', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1168, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 18:54:22.288057', 1, '2015-03-03 18:54:22.288057', '2015-03-03 18:54:22.288057', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1169, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 18:56:32.6015', 1, '2015-03-03 18:56:32.6015', '2015-03-03 18:56:32.6015', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1170, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 18:57:53.076286', 1, '2015-03-03 18:57:53.076286', '2015-03-03 18:57:53.076286', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1171, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 18:58:05.17281', 1, '2015-03-03 18:58:05.17281', '2015-03-03 18:58:05.17281', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1173, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 19:03:59.557789', 1, '2015-03-03 19:03:59.557789', '2015-03-03 19:03:59.557789', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1174, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 19:08:31.640056', 1, '2015-03-03 19:08:31.640056', '2015-03-03 19:08:31.640056', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1175, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 19:22:18.176367', 1, '2015-03-03 19:22:18.176367', '2015-03-03 19:22:18.176367', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1172, '{}', 3, 'TANIA LOPEZ', 'tania.melizald@gmail.com', '811253697e9f0bfc9dd94e72f3c03746', '{}', '', '', '', NULL, '2015-03-03 19:03:09.648177', 1, '2015-03-03 19:03:09.648177', '2015-03-03 19:03:09.648177', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1176, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 19:23:38.684678', 1, '2015-03-03 19:23:38.684678', '2015-03-03 19:23:38.684678', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1177, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 19:29:05.767721', 1, '2015-03-03 19:29:05.767721', '2015-03-03 19:29:05.767721', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1178, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 19:51:27.42239', 1, '2015-03-03 19:51:27.42239', '2015-03-03 19:51:27.42239', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1179, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 20:07:10.80394', 1, '2015-03-03 20:07:10.80394', '2015-03-03 20:07:10.80394', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1180, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 20:20:23.570649', 1, '2015-03-03 20:20:23.570649', '2015-03-03 20:20:23.570649', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1181, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 20:39:06.848007', 1, '2015-03-03 20:39:06.848007', '2015-03-03 20:39:06.848007', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1182, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 21:01:17.144058', 1, '2015-03-03 21:01:17.144058', '2015-03-03 21:01:17.144058', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1183, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 21:03:12.88416', 1, '2015-03-03 21:03:12.88416', '2015-03-03 21:03:12.88416', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1184, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 21:07:16.646728', 1, '2015-03-03 21:07:16.646728', '2015-03-03 21:07:16.646728', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1185, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 21:11:29.200504', 1, '2015-03-03 21:11:29.200504', '2015-03-03 21:11:29.200504', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1186, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 21:12:32.030665', 1, '2015-03-03 21:12:32.030665', '2015-03-03 21:12:32.030665', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1187, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 21:15:19.266143', 1, '2015-03-03 21:15:19.266143', '2015-03-03 21:15:19.266143', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1188, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 21:16:42.447961', 1, '2015-03-03 21:16:42.447961', '2015-03-03 21:16:42.447961', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1189, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 21:18:02.053528', 1, '2015-03-03 21:18:02.053528', '2015-03-03 21:18:02.053528', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1190, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 21:51:13.256106', 1, '2015-03-03 21:51:13.256106', '2015-03-03 21:51:13.256106', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1191, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 22:04:21.502381', 1, '2015-03-03 22:04:21.502381', '2015-03-03 22:04:21.502381', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1192, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 22:04:48.941124', 1, '2015-03-03 22:04:48.941124', '2015-03-03 22:04:48.941124', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1193, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 22:13:29.022755', 1, '2015-03-03 22:13:29.022755', '2015-03-03 22:13:29.022755', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1194, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 23:04:00.02995', 1, '2015-03-03 23:04:00.02995', '2015-03-03 23:04:00.02995', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1195, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 23:17:54.839192', 1, '2015-03-03 23:17:54.839192', '2015-03-03 23:17:54.839192', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1196, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 23:47:04.021659', 1, '2015-03-03 23:47:04.021659', '2015-03-03 23:47:04.021659', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1197, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 23:47:04.158091', 1, '2015-03-03 23:47:04.158091', '2015-03-03 23:47:04.158091', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1198, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 23:49:08.227473', 1, '2015-03-03 23:49:08.227473', '2015-03-03 23:49:08.227473', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1199, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-03 23:52:38.476739', 1, '2015-03-03 23:52:38.476739', '2015-03-03 23:52:38.476739', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1200, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 00:14:57.735392', 1, '2015-03-04 00:14:57.735392', '2015-03-04 00:14:57.735392', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1201, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 00:20:51.556104', 1, '2015-03-04 00:20:51.556104', '2015-03-04 00:20:51.556104', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1202, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 00:43:33.326785', 1, '2015-03-04 00:43:33.326785', '2015-03-04 00:43:33.326785', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1203, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 00:49:52.550207', 1, '2015-03-04 00:49:52.550207', '2015-03-04 00:49:52.550207', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1204, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 00:51:08.370033', 1, '2015-03-04 00:51:08.370033', '2015-03-04 00:51:08.370033', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1205, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 00:58:46.773976', 1, '2015-03-04 00:58:46.773976', '2015-03-04 00:58:46.773976', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1206, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 01:02:27.295979', 1, '2015-03-04 01:02:27.295979', '2015-03-04 01:02:27.295979', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1207, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 01:03:07.134768', 1, '2015-03-04 01:03:07.134768', '2015-03-04 01:03:07.134768', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1208, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 01:25:48.392814', 1, '2015-03-04 01:25:48.392814', '2015-03-04 01:25:48.392814', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1209, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 01:38:34.677871', 1, '2015-03-04 01:38:34.677871', '2015-03-04 01:38:34.677871', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1210, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 01:56:49.455771', 1, '2015-03-04 01:56:49.455771', '2015-03-04 01:56:49.455771', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1211, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 02:09:00.134787', 1, '2015-03-04 02:09:00.134787', '2015-03-04 02:09:00.134787', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1212, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 04:01:23.068652', 1, '2015-03-04 04:01:23.068652', '2015-03-04 04:01:23.068652', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1213, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 04:03:29.734892', 1, '2015-03-04 04:03:29.734892', '2015-03-04 04:03:29.734892', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1215, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 05:01:16.691318', 1, '2015-03-04 05:01:16.691318', '2015-03-04 05:01:16.691318', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1216, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 11:29:44.613242', 1, '2015-03-04 11:29:44.613242', '2015-03-04 11:29:44.613242', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1217, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 11:40:21.284025', 1, '2015-03-04 11:40:21.284025', '2015-03-04 11:40:21.284025', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1012, '{}', 3, 'Ruth Salazar Silva', 'blackrose.sssr@gmail.com', '9b6032ee4db12d7055812a04d4f5b852', '{}', '', '', '', NULL, '2015-02-28 11:39:15.960426', 1, '2015-02-28 11:39:15.960426', '2015-02-28 11:39:15.960426', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1218, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 12:07:37.111583', 1, '2015-03-04 12:07:37.111583', '2015-03-04 12:07:37.111583', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1219, '{}', 3, 'Antonia Vial', 'antoniavialt@gmail.com', '710843096d2379139f52e3e398d15687', '{}', '', '', '', NULL, '2015-03-04 12:13:13.885936', 1, '2015-03-04 12:13:13.885936', '2015-03-04 12:13:13.885936', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1220, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 12:26:09.562615', 1, '2015-03-04 12:26:09.562615', '2015-03-04 12:26:09.562615', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1221, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 13:13:23.152573', 1, '2015-03-04 13:13:23.152573', '2015-03-04 13:13:23.152573', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1222, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 13:31:22.666823', 1, '2015-03-04 13:31:22.666823', '2015-03-04 13:31:22.666823', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1223, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 13:31:26.690546', 1, '2015-03-04 13:31:26.690546', '2015-03-04 13:31:26.690546', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1224, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 13:35:28.828078', 1, '2015-03-04 13:35:28.828078', '2015-03-04 13:35:28.828078', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1225, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 13:43:25.249717', 1, '2015-03-04 13:43:25.249717', '2015-03-04 13:43:25.249717', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1226, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 13:50:29.249935', 1, '2015-03-04 13:50:29.249935', '2015-03-04 13:50:29.249935', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1227, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 14:00:17.050441', 1, '2015-03-04 14:00:17.050441', '2015-03-04 14:00:17.050441', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1228, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 14:15:52.809089', 1, '2015-03-04 14:15:52.809089', '2015-03-04 14:15:52.809089', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1229, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 14:18:38.548154', 1, '2015-03-04 14:18:38.548154', '2015-03-04 14:18:38.548154', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1230, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 14:25:39.834475', 1, '2015-03-04 14:25:39.834475', '2015-03-04 14:25:39.834475', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1231, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 14:30:52.904673', 1, '2015-03-04 14:30:52.904673', '2015-03-04 14:30:52.904673', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1232, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 15:29:08.762302', 1, '2015-03-04 15:29:08.762302', '2015-03-04 15:29:08.762302', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1233, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 15:35:32.153986', 1, '2015-03-04 15:35:32.153986', '2015-03-04 15:35:32.153986', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1234, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 15:37:48.210609', 1, '2015-03-04 15:37:48.210609', '2015-03-04 15:37:48.210609', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1235, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 15:59:08.060971', 1, '2015-03-04 15:59:08.060971', '2015-03-04 15:59:08.060971', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1236, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 16:31:56.34106', 1, '2015-03-04 16:31:56.34106', '2015-03-04 16:31:56.34106', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1237, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 17:01:40.306076', 1, '2015-03-04 17:01:40.306076', '2015-03-04 17:01:40.306076', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1238, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 17:22:21.503587', 1, '2015-03-04 17:22:21.503587', '2015-03-04 17:22:21.503587', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1239, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 17:34:44.892134', 1, '2015-03-04 17:34:44.892134', '2015-03-04 17:34:44.892134', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1240, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 18:16:32.162734', 1, '2015-03-04 18:16:32.162734', '2015-03-04 18:16:32.162734', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1241, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 18:27:09.720297', 1, '2015-03-04 18:27:09.720297', '2015-03-04 18:27:09.720297', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1242, '{}', 3, 'MARÍA PAZ PEÑA', 'PAZ_VAL@HOTMAIL.COM', '827ccb0eea8a706c4c34a16891f84e7b', '{}', '', '', '', NULL, '2015-03-04 18:28:48.529744', 1, '2015-03-04 18:28:48.529744', '2015-03-04 18:28:48.529744', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1243, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 18:49:13.316525', 1, '2015-03-04 18:49:13.316525', '2015-03-04 18:49:13.316525', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1244, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 18:57:13.176857', 1, '2015-03-04 18:57:13.176857', '2015-03-04 18:57:13.176857', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1245, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 19:22:49.303861', 1, '2015-03-04 19:22:49.303861', '2015-03-04 19:22:49.303861', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1246, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 19:25:23.199912', 1, '2015-03-04 19:25:23.199912', '2015-03-04 19:25:23.199912', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1247, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 19:38:52.646075', 1, '2015-03-04 19:38:52.646075', '2015-03-04 19:38:52.646075', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1249, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 20:02:07.91728', 1, '2015-03-04 20:02:07.91728', '2015-03-04 20:02:07.91728', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1250, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 20:03:25.281305', 1, '2015-03-04 20:03:25.281305', '2015-03-04 20:03:25.281305', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1251, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 20:12:08.128441', 1, '2015-03-04 20:12:08.128441', '2015-03-04 20:12:08.128441', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1252, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 20:30:48.40801', 1, '2015-03-04 20:30:48.40801', '2015-03-04 20:30:48.40801', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1253, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 20:38:53.065324', 1, '2015-03-04 20:38:53.065324', '2015-03-04 20:38:53.065324', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1254, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 20:51:10.569357', 1, '2015-03-04 20:51:10.569357', '2015-03-04 20:51:10.569357', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1255, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 21:11:53.520128', 1, '2015-03-04 21:11:53.520128', '2015-03-04 21:11:53.520128', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1256, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 21:27:49.626454', 1, '2015-03-04 21:27:49.626454', '2015-03-04 21:27:49.626454', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1257, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 22:06:09.829843', 1, '2015-03-04 22:06:09.829843', '2015-03-04 22:06:09.829843', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1258, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 22:06:39.748802', 1, '2015-03-04 22:06:39.748802', '2015-03-04 22:06:39.748802', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1259, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 22:15:08.819512', 1, '2015-03-04 22:15:08.819512', '2015-03-04 22:15:08.819512', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1261, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 22:32:53.497192', 1, '2015-03-04 22:32:53.497192', '2015-03-04 22:32:53.497192', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1260, '{}', 3, 'Yarytt Arcos C', 'arcoscerna@hotmail.com', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 22:26:13.457089', 1, '2015-03-04 22:26:13.457089', '2015-03-04 22:26:13.457089', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1262, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 22:56:07.127928', 1, '2015-03-04 22:56:07.127928', '2015-03-04 22:56:07.127928', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1263, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-04 23:10:51.686737', 1, '2015-03-04 23:10:51.686737', '2015-03-04 23:10:51.686737', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1264, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 00:12:57.99543', 1, '2015-03-05 00:12:57.99543', '2015-03-05 00:12:57.99543', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1265, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 00:20:18.622518', 1, '2015-03-05 00:20:18.622518', '2015-03-05 00:20:18.622518', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1266, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 00:48:33.520852', 1, '2015-03-05 00:48:33.520852', '2015-03-05 00:48:33.520852', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1267, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 01:14:08.722552', 1, '2015-03-05 01:14:08.722552', '2015-03-05 01:14:08.722552', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1268, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 01:27:14.265636', 1, '2015-03-05 01:27:14.265636', '2015-03-05 01:27:14.265636', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1269, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 01:31:18.635842', 1, '2015-03-05 01:31:18.635842', '2015-03-05 01:31:18.635842', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1270, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 01:32:47.891396', 1, '2015-03-05 01:32:47.891396', '2015-03-05 01:32:47.891396', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1271, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 01:46:29.381133', 1, '2015-03-05 01:46:29.381133', '2015-03-05 01:46:29.381133', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1272, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 01:48:43.681591', 1, '2015-03-05 01:48:43.681591', '2015-03-05 01:48:43.681591', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1273, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 02:30:58.993248', 1, '2015-03-05 02:30:58.993248', '2015-03-05 02:30:58.993248', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1274, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 02:54:27.655885', 1, '2015-03-05 02:54:27.655885', '2015-03-05 02:54:27.655885', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1275, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 02:55:05.408176', 1, '2015-03-05 02:55:05.408176', '2015-03-05 02:55:05.408176', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1276, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 03:28:13.716452', 1, '2015-03-05 03:28:13.716452', '2015-03-05 03:28:13.716452', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1277, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 03:34:36.258776', 1, '2015-03-05 03:34:36.258776', '2015-03-05 03:34:36.258776', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1278, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 04:45:39.569197', 1, '2015-03-05 04:45:39.569197', '2015-03-05 04:45:39.569197', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1279, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 04:54:56.162675', 1, '2015-03-05 04:54:56.162675', '2015-03-05 04:54:56.162675', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1280, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 06:56:39.124913', 1, '2015-03-05 06:56:39.124913', '2015-03-05 06:56:39.124913', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1281, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 07:47:15.191649', 1, '2015-03-05 07:47:15.191649', '2015-03-05 07:47:15.191649', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1282, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 12:34:23.070882', 1, '2015-03-05 12:34:23.070882', '2015-03-05 12:34:23.070882', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1283, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 12:36:03.284269', 1, '2015-03-05 12:36:03.284269', '2015-03-05 12:36:03.284269', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1284, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 13:07:02.202935', 1, '2015-03-05 13:07:02.202935', '2015-03-05 13:07:02.202935', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1285, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 13:17:58.445151', 1, '2015-03-05 13:17:58.445151', '2015-03-05 13:17:58.445151', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1286, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 13:17:58.649597', 1, '2015-03-05 13:17:58.649597', '2015-03-05 13:17:58.649597', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1287, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 13:23:36.062025', 1, '2015-03-05 13:23:36.062025', '2015-03-05 13:23:36.062025', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1288, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 13:26:26.078148', 1, '2015-03-05 13:26:26.078148', '2015-03-05 13:26:26.078148', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1289, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 13:31:00.436277', 1, '2015-03-05 13:31:00.436277', '2015-03-05 13:31:00.436277', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1290, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 14:07:33.580417', 1, '2015-03-05 14:07:33.580417', '2015-03-05 14:07:33.580417', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1291, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 14:16:51.622745', 1, '2015-03-05 14:16:51.622745', '2015-03-05 14:16:51.622745', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1292, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 15:06:08.743345', 1, '2015-03-05 15:06:08.743345', '2015-03-05 15:06:08.743345', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1293, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 15:13:21.544205', 1, '2015-03-05 15:13:21.544205', '2015-03-05 15:13:21.544205', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1248, '{}', 3, 'Catherina Pino', 'cathi.pc@gmail.com', '342a3960bad060228370fa970fcd903d', '{}', '', '', '', NULL, '2015-03-04 19:57:07.208305', 1, '2015-03-04 19:57:07.208305', '2015-03-04 19:57:07.208305', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1294, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 15:35:23.102839', 1, '2015-03-05 15:35:23.102839', '2015-03-05 15:35:23.102839', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1324, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 21:47:17.0017', 1, '2015-03-05 21:47:17.0017', '2015-03-05 21:47:17.0017', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1296, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 16:06:56.228666', 1, '2015-03-05 16:06:56.228666', '2015-03-05 16:06:56.228666', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1295, '{}', 3, 'Yanela Jaramillo Díaz', 'yanelajaramillodiaz@hotmail.com', '3aeb1f92c1262ae4a0d5000b0aecd120', '{}', '', '', '', NULL, '2015-03-05 15:53:12.1177', 1, '2015-03-05 15:53:12.1177', '2015-03-05 15:53:12.1177', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1298, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 16:59:24.823347', 1, '2015-03-05 16:59:24.823347', '2015-03-05 16:59:24.823347', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1299, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 17:11:24.240055', 1, '2015-03-05 17:11:24.240055', '2015-03-05 17:11:24.240055', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1300, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 17:14:50.848359', 1, '2015-03-05 17:14:50.848359', '2015-03-05 17:14:50.848359', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1302, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 17:34:52.537407', 1, '2015-03-05 17:34:52.537407', '2015-03-05 17:34:52.537407', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1303, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 17:42:42.744352', 1, '2015-03-05 17:42:42.744352', '2015-03-05 17:42:42.744352', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1304, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 17:43:40.301177', 1, '2015-03-05 17:43:40.301177', '2015-03-05 17:43:40.301177', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1305, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 17:45:13.761922', 1, '2015-03-05 17:45:13.761922', '2015-03-05 17:45:13.761922', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1306, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 17:46:22.686307', 1, '2015-03-05 17:46:22.686307', '2015-03-05 17:46:22.686307', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1307, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 17:57:39.298268', 1, '2015-03-05 17:57:39.298268', '2015-03-05 17:57:39.298268', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1308, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 18:09:37.268992', 1, '2015-03-05 18:09:37.268992', '2015-03-05 18:09:37.268992', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1309, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 18:14:55.330181', 1, '2015-03-05 18:14:55.330181', '2015-03-05 18:14:55.330181', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1310, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 18:24:05.277771', 1, '2015-03-05 18:24:05.277771', '2015-03-05 18:24:05.277771', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1311, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 18:44:37.422019', 1, '2015-03-05 18:44:37.422019', '2015-03-05 18:44:37.422019', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1312, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 19:19:55.957006', 1, '2015-03-05 19:19:55.957006', '2015-03-05 19:19:55.957006', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1313, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 19:24:36.057738', 1, '2015-03-05 19:24:36.057738', '2015-03-05 19:24:36.057738', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1314, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 19:25:20.977863', 1, '2015-03-05 19:25:20.977863', '2015-03-05 19:25:20.977863', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1315, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 19:36:47.32803', 1, '2015-03-05 19:36:47.32803', '2015-03-05 19:36:47.32803', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1316, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 19:46:42.32995', 1, '2015-03-05 19:46:42.32995', '2015-03-05 19:46:42.32995', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1317, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 19:51:04.164351', 1, '2015-03-05 19:51:04.164351', '2015-03-05 19:51:04.164351', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1318, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 20:21:09.727423', 1, '2015-03-05 20:21:09.727423', '2015-03-05 20:21:09.727423', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1319, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 20:45:23.427664', 1, '2015-03-05 20:45:23.427664', '2015-03-05 20:45:23.427664', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1320, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 21:08:00.343466', 1, '2015-03-05 21:08:00.343466', '2015-03-05 21:08:00.343466', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1321, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 21:27:12.324902', 1, '2015-03-05 21:27:12.324902', '2015-03-05 21:27:12.324902', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1322, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 21:32:55.840842', 1, '2015-03-05 21:32:55.840842', '2015-03-05 21:32:55.840842', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1323, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 21:33:17.377059', 1, '2015-03-05 21:33:17.377059', '2015-03-05 21:33:17.377059', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1326, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 21:59:37.4224', 1, '2015-03-05 21:59:37.4224', '2015-03-05 21:59:37.4224', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1327, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 22:05:32.076309', 1, '2015-03-05 22:05:32.076309', '2015-03-05 22:05:32.076309', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1329, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 22:15:12.870865', 1, '2015-03-05 22:15:12.870865', '2015-03-05 22:15:12.870865', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1328, '{}', 3, 'ivette', 'ivette.arroyop@gmail.com', '588539d64bcc61065aa569f58f1155e9', '{}', '', '', '', NULL, '2015-03-05 22:13:29.053816', 1, '2015-03-05 22:13:29.053816', '2015-03-05 22:13:29.053816', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1330, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 22:36:30.545173', 1, '2015-03-05 22:36:30.545173', '2015-03-05 22:36:30.545173', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1331, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 22:52:11.139742', 1, '2015-03-05 22:52:11.139742', '2015-03-05 22:52:11.139742', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1332, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 23:51:45.306919', 1, '2015-03-05 23:51:45.306919', '2015-03-05 23:51:45.306919', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1333, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-05 23:52:05.895394', 1, '2015-03-05 23:52:05.895394', '2015-03-05 23:52:05.895394', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1334, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 00:07:00.789911', 1, '2015-03-06 00:07:00.789911', '2015-03-06 00:07:00.789911', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1335, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 00:38:20.486845', 1, '2015-03-06 00:38:20.486845', '2015-03-06 00:38:20.486845', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1336, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 00:47:51.03496', 1, '2015-03-06 00:47:51.03496', '2015-03-06 00:47:51.03496', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1337, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 01:02:16.855978', 1, '2015-03-06 01:02:16.855978', '2015-03-06 01:02:16.855978', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1338, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 01:27:25.59157', 1, '2015-03-06 01:27:25.59157', '2015-03-06 01:27:25.59157', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1339, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 01:34:01.03748', 1, '2015-03-06 01:34:01.03748', '2015-03-06 01:34:01.03748', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1340, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 01:43:23.486985', 1, '2015-03-06 01:43:23.486985', '2015-03-06 01:43:23.486985', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1342, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 01:56:52.789302', 1, '2015-03-06 01:56:52.789302', '2015-03-06 01:56:52.789302', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1343, '{}', 3, 'Constanza Guzmán', 'maria.constanza.guzman@gmail.com', 'bd61b62d525251884c2039f29c0ae3d2', '{}', '', '', '', NULL, '2015-03-06 02:19:20.667116', 1, '2015-03-06 02:19:20.667116', '2015-03-06 02:19:20.667116', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1344, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 02:39:59.722928', 1, '2015-03-06 02:39:59.722928', '2015-03-06 02:39:59.722928', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1345, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 02:46:38.800685', 1, '2015-03-06 02:46:38.800685', '2015-03-06 02:46:38.800685', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1346, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 03:14:44.573942', 1, '2015-03-06 03:14:44.573942', '2015-03-06 03:14:44.573942', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1347, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 15:44:14.923791', 1, '2015-03-06 15:44:14.923791', '2015-03-06 15:44:14.923791', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1348, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 15:44:22.133171', 1, '2015-03-06 15:44:22.133171', '2015-03-06 15:44:22.133171', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1349, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 15:47:26.755404', 1, '2015-03-06 15:47:26.755404', '2015-03-06 15:47:26.755404', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1350, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 15:52:12.201309', 1, '2015-03-06 15:52:12.201309', '2015-03-06 15:52:12.201309', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1351, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 15:52:20.505779', 1, '2015-03-06 15:52:20.505779', '2015-03-06 15:52:20.505779', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1352, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 16:30:14.185593', 1, '2015-03-06 16:30:14.185593', '2015-03-06 16:30:14.185593', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1353, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 16:37:01.6857', 1, '2015-03-06 16:37:01.6857', '2015-03-06 16:37:01.6857', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1354, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 16:49:08.770936', 1, '2015-03-06 16:49:08.770936', '2015-03-06 16:49:08.770936', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1355, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 16:57:51.934951', 1, '2015-03-06 16:57:51.934951', '2015-03-06 16:57:51.934951', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1356, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 17:22:34.516481', 1, '2015-03-06 17:22:34.516481', '2015-03-06 17:22:34.516481', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1357, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 17:34:24.716566', 1, '2015-03-06 17:34:24.716566', '2015-03-06 17:34:24.716566', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1358, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 18:58:35.631662', 1, '2015-03-06 18:58:35.631662', '2015-03-06 18:58:35.631662', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1359, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 19:48:40.448738', 1, '2015-03-06 19:48:40.448738', '2015-03-06 19:48:40.448738', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1360, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 20:07:13.056929', 1, '2015-03-06 20:07:13.056929', '2015-03-06 20:07:13.056929', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1361, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 20:28:53.985112', 1, '2015-03-06 20:28:53.985112', '2015-03-06 20:28:53.985112', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1362, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 21:48:33.202906', 1, '2015-03-06 21:48:33.202906', '2015-03-06 21:48:33.202906', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1363, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 21:54:38.921525', 1, '2015-03-06 21:54:38.921525', '2015-03-06 21:54:38.921525', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1364, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 22:59:33.191332', 1, '2015-03-06 22:59:33.191332', '2015-03-06 22:59:33.191332', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1365, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-06 23:42:46.290445', 1, '2015-03-06 23:42:46.290445', '2015-03-06 23:42:46.290445', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1366, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 01:26:02.872926', 1, '2015-03-07 01:26:02.872926', '2015-03-07 01:26:02.872926', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1367, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 01:28:24.349187', 1, '2015-03-07 01:28:24.349187', '2015-03-07 01:28:24.349187', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1368, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 01:41:07.217337', 1, '2015-03-07 01:41:07.217337', '2015-03-07 01:41:07.217337', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1369, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 02:34:30.058445', 1, '2015-03-07 02:34:30.058445', '2015-03-07 02:34:30.058445', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1370, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 02:35:13.328143', 1, '2015-03-07 02:35:13.328143', '2015-03-07 02:35:13.328143', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1371, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 02:55:23.262558', 1, '2015-03-07 02:55:23.262558', '2015-03-07 02:55:23.262558', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1372, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 02:59:02.63407', 1, '2015-03-07 02:59:02.63407', '2015-03-07 02:59:02.63407', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1373, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 03:07:02.508675', 1, '2015-03-07 03:07:02.508675', '2015-03-07 03:07:02.508675', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1374, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 03:57:25.972696', 1, '2015-03-07 03:57:25.972696', '2015-03-07 03:57:25.972696', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1375, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 04:01:14.037819', 1, '2015-03-07 04:01:14.037819', '2015-03-07 04:01:14.037819', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1376, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 04:15:40.951588', 1, '2015-03-07 04:15:40.951588', '2015-03-07 04:15:40.951588', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1377, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 06:27:08.883505', 1, '2015-03-07 06:27:08.883505', '2015-03-07 06:27:08.883505', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1378, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 08:16:46.141051', 1, '2015-03-07 08:16:46.141051', '2015-03-07 08:16:46.141051', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1379, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 11:20:27.159206', 1, '2015-03-07 11:20:27.159206', '2015-03-07 11:20:27.159206', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1380, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 11:52:43.084295', 1, '2015-03-07 11:52:43.084295', '2015-03-07 11:52:43.084295', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1381, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 11:52:45.175173', 1, '2015-03-07 11:52:45.175173', '2015-03-07 11:52:45.175173', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1382, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 12:29:32.25284', 1, '2015-03-07 12:29:32.25284', '2015-03-07 12:29:32.25284', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1383, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 13:34:01.190282', 1, '2015-03-07 13:34:01.190282', '2015-03-07 13:34:01.190282', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1341, '{}', 3, 'Antonella mincone', 'amincone@gmail.com', 'c62c1dc61954ce2f1329fef106da76d8', '{}', '', '', '', NULL, '2015-03-06 01:43:24.584222', 1, '2015-03-06 01:43:24.584222', '2015-03-06 01:43:24.584222', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1384, '{}', 3, 'Catalina Padilla', 'cataaap.-@hotmail.com', '8d33b381801f5758f84238a7ce0268dd', '{}', '', '', '', NULL, '2015-03-07 14:14:37.544686', 1, '2015-03-07 14:14:37.544686', '2015-03-07 14:14:37.544686', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1385, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 14:57:54.978424', 1, '2015-03-07 14:57:54.978424', '2015-03-07 14:57:54.978424', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1386, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 15:11:51.762204', 1, '2015-03-07 15:11:51.762204', '2015-03-07 15:11:51.762204', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1387, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 15:41:31.080853', 1, '2015-03-07 15:41:31.080853', '2015-03-07 15:41:31.080853', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1388, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 15:44:10.020474', 1, '2015-03-07 15:44:10.020474', '2015-03-07 15:44:10.020474', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1389, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 15:53:59.478004', 1, '2015-03-07 15:53:59.478004', '2015-03-07 15:53:59.478004', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1390, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 16:25:01.611071', 1, '2015-03-07 16:25:01.611071', '2015-03-07 16:25:01.611071', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1391, '{}', 3, 'Consuelo Espinoza Caroca', 'consueloespinoza@live.cl', '54ba8b1b43768f993e0f25eecad30c47', '{}', '', '', '', NULL, '2015-03-07 17:01:23.735129', 1, '2015-03-07 17:01:23.735129', '2015-03-07 17:01:23.735129', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1392, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 17:16:17.390554', 1, '2015-03-07 17:16:17.390554', '2015-03-07 17:16:17.390554', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1393, '{}', 3, 'Leslie', 'leslie.santibanez@yahoo.cl', '7d5c9b27d648391ba1420f97bd2e793c', '{}', '', '', '', NULL, '2015-03-07 17:24:14.67659', 1, '2015-03-07 17:24:14.67659', '2015-03-07 17:24:14.67659', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1394, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 17:32:36.66003', 1, '2015-03-07 17:32:36.66003', '2015-03-07 17:32:36.66003', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1396, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 17:45:57.119891', 1, '2015-03-07 17:45:57.119891', '2015-03-07 17:45:57.119891', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1399, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 18:02:36.15998', 1, '2015-03-07 18:02:36.15998', '2015-03-07 18:02:36.15998', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1400, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 18:03:18.075166', 1, '2015-03-07 18:03:18.075166', '2015-03-07 18:03:18.075166', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1401, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 18:43:34.981702', 1, '2015-03-07 18:43:34.981702', '2015-03-07 18:43:34.981702', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1402, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 18:47:24.880313', 1, '2015-03-07 18:47:24.880313', '2015-03-07 18:47:24.880313', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (629, '{2,3,6}', 1, 'Javiera', 'javiera@gianidafirenze.cl', '03255088ed63354a54e0e5ed957e9008', '{5,12}', 'Soto Gonzales', '', '', NULL, '2015-01-07 13:41:59.018865', 1, '2015-01-07 13:41:59.018865', '2015-01-07 13:41:59.018865', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1405, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 19:34:24.85458', 1, '2015-03-07 19:34:24.85458', '2015-03-07 19:34:24.85458', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1406, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 19:48:30.53198', 1, '2015-03-07 19:48:30.53198', '2015-03-07 19:48:30.53198', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1407, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 20:19:23.826054', 1, '2015-03-07 20:19:23.826054', '2015-03-07 20:19:23.826054', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1408, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 20:35:18.304379', 1, '2015-03-07 20:35:18.304379', '2015-03-07 20:35:18.304379', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1409, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 20:52:20.584964', 1, '2015-03-07 20:52:20.584964', '2015-03-07 20:52:20.584964', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1410, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 21:10:02.675489', 1, '2015-03-07 21:10:02.675489', '2015-03-07 21:10:02.675489', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1411, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 21:19:20.155539', 1, '2015-03-07 21:19:20.155539', '2015-03-07 21:19:20.155539', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1412, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 21:40:43.667697', 1, '2015-03-07 21:40:43.667697', '2015-03-07 21:40:43.667697', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1413, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 21:52:21.97869', 1, '2015-03-07 21:52:21.97869', '2015-03-07 21:52:21.97869', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1414, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 22:27:46.847577', 1, '2015-03-07 22:27:46.847577', '2015-03-07 22:27:46.847577', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1415, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 23:01:00.941838', 1, '2015-03-07 23:01:00.941838', '2015-03-07 23:01:00.941838', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1416, '{}', 3, 'Mariola Martinez', 'marywaves_@hotmail.com', '2c669c8ee33eef1006419e0a298124f3', '{}', '', '', '', NULL, '2015-03-07 23:13:34.340675', 1, '2015-03-07 23:13:34.340675', '2015-03-07 23:13:34.340675', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1418, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 23:42:28.199287', 1, '2015-03-07 23:42:28.199287', '2015-03-07 23:42:28.199287', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1419, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-07 23:42:55.44665', 1, '2015-03-07 23:42:55.44665', '2015-03-07 23:42:55.44665', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1420, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 00:07:17.100717', 1, '2015-03-08 00:07:17.100717', '2015-03-08 00:07:17.100717', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1421, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 00:40:18.50972', 1, '2015-03-08 00:40:18.50972', '2015-03-08 00:40:18.50972', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1422, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 01:08:36.623031', 1, '2015-03-08 01:08:36.623031', '2015-03-08 01:08:36.623031', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1423, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 01:21:31.47972', 1, '2015-03-08 01:21:31.47972', '2015-03-08 01:21:31.47972', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1424, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 01:29:47.888285', 1, '2015-03-08 01:29:47.888285', '2015-03-08 01:29:47.888285', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1425, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 01:40:06.119453', 1, '2015-03-08 01:40:06.119453', '2015-03-08 01:40:06.119453', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1426, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 01:59:57.70218', 1, '2015-03-08 01:59:57.70218', '2015-03-08 01:59:57.70218', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1427, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 02:16:31.403125', 1, '2015-03-08 02:16:31.403125', '2015-03-08 02:16:31.403125', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1428, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 02:27:08.502548', 1, '2015-03-08 02:27:08.502548', '2015-03-08 02:27:08.502548', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1429, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 02:40:28.154693', 1, '2015-03-08 02:40:28.154693', '2015-03-08 02:40:28.154693', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1430, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 02:57:43.490948', 1, '2015-03-08 02:57:43.490948', '2015-03-08 02:57:43.490948', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1431, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 03:30:31.586952', 1, '2015-03-08 03:30:31.586952', '2015-03-08 03:30:31.586952', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1432, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 03:48:35.760737', 1, '2015-03-08 03:48:35.760737', '2015-03-08 03:48:35.760737', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1433, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 03:55:31.962987', 1, '2015-03-08 03:55:31.962987', '2015-03-08 03:55:31.962987', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1434, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 04:09:53.513884', 1, '2015-03-08 04:09:53.513884', '2015-03-08 04:09:53.513884', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1435, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 04:13:25.871592', 1, '2015-03-08 04:13:25.871592', '2015-03-08 04:13:25.871592', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1436, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 04:37:55.515698', 1, '2015-03-08 04:37:55.515698', '2015-03-08 04:37:55.515698', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1437, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 04:54:21.153608', 1, '2015-03-08 04:54:21.153608', '2015-03-08 04:54:21.153608', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1438, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 04:57:13.323587', 1, '2015-03-08 04:57:13.323587', '2015-03-08 04:57:13.323587', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1439, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 10:41:56.857362', 1, '2015-03-08 10:41:56.857362', '2015-03-08 10:41:56.857362', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1440, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 10:54:31.812608', 1, '2015-03-08 10:54:31.812608', '2015-03-08 10:54:31.812608', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1441, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 12:24:36.849826', 1, '2015-03-08 12:24:36.849826', '2015-03-08 12:24:36.849826', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1442, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 13:01:52.939599', 1, '2015-03-08 13:01:52.939599', '2015-03-08 13:01:52.939599', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1443, '{}', 3, 'Lorena Fuentes', 'lorena.fb@gmail.com', 'a6a02eb3ac7db24b9cf284f4463b956e', '{}', '', '', '', NULL, '2015-03-08 13:33:10.530052', 1, '2015-03-08 13:33:10.530052', '2015-03-08 13:33:10.530052', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1481, '{}', 3, 'Victoria Fischer', 'vick_fischer@hotmail.com', '0d7f0b17f7b866f76b14b5b8cb692c26', '{}', '', '', '', NULL, '2015-03-09 14:49:48.992773', 1, '2015-03-09 14:49:48.992773', '2015-03-09 14:49:48.992773', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1483, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 14:52:18.734622', 1, '2015-03-09 14:52:18.734622', '2015-03-09 14:52:18.734622', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1484, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 14:53:26.550458', 1, '2015-03-09 14:53:26.550458', '2015-03-09 14:53:26.550458', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1445, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 14:42:44.631342', 1, '2015-03-08 14:42:44.631342', '2015-03-08 14:42:44.631342', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1446, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 15:20:36.229159', 1, '2015-03-08 15:20:36.229159', '2015-03-08 15:20:36.229159', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1447, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 15:25:37.208298', 1, '2015-03-08 15:25:37.208298', '2015-03-08 15:25:37.208298', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1448, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 15:48:12.763718', 1, '2015-03-08 15:48:12.763718', '2015-03-08 15:48:12.763718', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1449, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 16:05:11.687965', 1, '2015-03-08 16:05:11.687965', '2015-03-08 16:05:11.687965', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1450, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 16:22:45.739393', 1, '2015-03-08 16:22:45.739393', '2015-03-08 16:22:45.739393', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1451, '{}', 3, 'pamela', 'sramp.-@hotmail.com', 'a82352e9a4ea3cc24b10d25f50cfb592', '{}', '', '', '', NULL, '2015-03-08 17:29:06.064686', 1, '2015-03-08 17:29:06.064686', '2015-03-08 17:29:06.064686', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1453, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 17:32:01.735896', 1, '2015-03-08 17:32:01.735896', '2015-03-08 17:32:01.735896', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1454, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 18:36:03.602817', 1, '2015-03-08 18:36:03.602817', '2015-03-08 18:36:03.602817', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1455, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 18:38:42.506786', 1, '2015-03-08 18:38:42.506786', '2015-03-08 18:38:42.506786', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1456, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 20:47:43.511141', 1, '2015-03-08 20:47:43.511141', '2015-03-08 20:47:43.511141', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1457, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 20:55:46.409228', 1, '2015-03-08 20:55:46.409228', '2015-03-08 20:55:46.409228', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1458, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 21:02:43.884462', 1, '2015-03-08 21:02:43.884462', '2015-03-08 21:02:43.884462', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1459, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 21:36:12.447998', 1, '2015-03-08 21:36:12.447998', '2015-03-08 21:36:12.447998', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1460, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 21:36:21.360684', 1, '2015-03-08 21:36:21.360684', '2015-03-08 21:36:21.360684', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1461, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-08 22:14:30.946845', 1, '2015-03-08 22:14:30.946845', '2015-03-08 22:14:30.946845', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1462, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 00:00:39.829936', 1, '2015-03-09 00:00:39.829936', '2015-03-09 00:00:39.829936', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1463, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 00:49:32.172029', 1, '2015-03-09 00:49:32.172029', '2015-03-09 00:49:32.172029', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1464, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 01:21:13.276375', 1, '2015-03-09 01:21:13.276375', '2015-03-09 01:21:13.276375', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1465, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 01:46:24.18462', 1, '2015-03-09 01:46:24.18462', '2015-03-09 01:46:24.18462', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1466, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 01:57:39.694824', 1, '2015-03-09 01:57:39.694824', '2015-03-09 01:57:39.694824', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1467, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 02:55:12.841597', 1, '2015-03-09 02:55:12.841597', '2015-03-09 02:55:12.841597', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1468, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 03:12:50.023258', 1, '2015-03-09 03:12:50.023258', '2015-03-09 03:12:50.023258', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1469, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 05:02:47.411167', 1, '2015-03-09 05:02:47.411167', '2015-03-09 05:02:47.411167', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1470, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 08:25:11.667588', 1, '2015-03-09 08:25:11.667588', '2015-03-09 08:25:11.667588', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1471, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 10:31:45.851843', 1, '2015-03-09 10:31:45.851843', '2015-03-09 10:31:45.851843', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1472, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 12:05:33.668529', 1, '2015-03-09 12:05:33.668529', '2015-03-09 12:05:33.668529', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1473, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 12:16:12.111935', 1, '2015-03-09 12:16:12.111935', '2015-03-09 12:16:12.111935', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1474, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 12:35:28.826598', 1, '2015-03-09 12:35:28.826598', '2015-03-09 12:35:28.826598', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1475, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 12:35:29.156171', 1, '2015-03-09 12:35:29.156171', '2015-03-09 12:35:29.156171', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1476, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 13:51:42.097293', 1, '2015-03-09 13:51:42.097293', '2015-03-09 13:51:42.097293', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1477, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 14:06:47.078441', 1, '2015-03-09 14:06:47.078441', '2015-03-09 14:06:47.078441', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1478, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 14:20:25.646072', 1, '2015-03-09 14:20:25.646072', '2015-03-09 14:20:25.646072', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1479, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 14:31:17.867013', 1, '2015-03-09 14:31:17.867013', '2015-03-09 14:31:17.867013', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1480, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 14:41:42.521051', 1, '2015-03-09 14:41:42.521051', '2015-03-09 14:41:42.521051', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1482, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 14:50:25.430713', 1, '2015-03-09 14:50:25.430713', '2015-03-09 14:50:25.430713', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1485, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 14:59:01.031724', 1, '2015-03-09 14:59:01.031724', '2015-03-09 14:59:01.031724', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1486, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 15:07:52.327864', 1, '2015-03-09 15:07:52.327864', '2015-03-09 15:07:52.327864', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1487, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 15:26:18.737553', 1, '2015-03-09 15:26:18.737553', '2015-03-09 15:26:18.737553', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1488, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 15:48:52.428188', 1, '2015-03-09 15:48:52.428188', '2015-03-09 15:48:52.428188', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1489, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 15:49:26.360269', 1, '2015-03-09 15:49:26.360269', '2015-03-09 15:49:26.360269', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1490, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 16:31:47.335768', 1, '2015-03-09 16:31:47.335768', '2015-03-09 16:31:47.335768', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1491, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 16:44:28.279334', 1, '2015-03-09 16:44:28.279334', '2015-03-09 16:44:28.279334', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1492, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 16:47:25.050603', 1, '2015-03-09 16:47:25.050603', '2015-03-09 16:47:25.050603', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1493, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 16:53:35.698498', 1, '2015-03-09 16:53:35.698498', '2015-03-09 16:53:35.698498', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1495, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 17:04:43.472274', 1, '2015-03-09 17:04:43.472274', '2015-03-09 17:04:43.472274', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1496, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 17:26:09.426757', 1, '2015-03-09 17:26:09.426757', '2015-03-09 17:26:09.426757', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1497, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 17:29:49.191871', 1, '2015-03-09 17:29:49.191871', '2015-03-09 17:29:49.191871', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1498, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 17:31:01.692465', 1, '2015-03-09 17:31:01.692465', '2015-03-09 17:31:01.692465', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1494, '{}', 3, 'julian', 'julian@ffff.cl', '0619180fa639db7598672caf15f0a74b', '{}', '', '', '', NULL, '2015-03-09 17:01:23.759104', 1, '2015-03-09 17:01:23.759104', '2015-03-09 17:01:23.759104', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1499, '{}', 3, 'tatiana serra conus', 'tatidelcar@hotmail.com', 'a64a23e47bba3420be9586acbf5c0523', '{}', '', '', '', NULL, '2015-03-09 18:35:45.421247', 1, '2015-03-09 18:35:45.421247', '2015-03-09 18:35:45.421247', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1500, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 18:46:32.606422', 1, '2015-03-09 18:46:32.606422', '2015-03-09 18:46:32.606422', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1501, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 20:08:09.570922', 1, '2015-03-09 20:08:09.570922', '2015-03-09 20:08:09.570922', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1502, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 20:16:24.380099', 1, '2015-03-09 20:16:24.380099', '2015-03-09 20:16:24.380099', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1503, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 20:36:55.761748', 1, '2015-03-09 20:36:55.761748', '2015-03-09 20:36:55.761748', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1504, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 20:46:17.598289', 1, '2015-03-09 20:46:17.598289', '2015-03-09 20:46:17.598289', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1505, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 20:55:31.452584', 1, '2015-03-09 20:55:31.452584', '2015-03-09 20:55:31.452584', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1506, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 21:00:48.602992', 1, '2015-03-09 21:00:48.602992', '2015-03-09 21:00:48.602992', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1507, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 21:05:37.832892', 1, '2015-03-09 21:05:37.832892', '2015-03-09 21:05:37.832892', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1508, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 21:08:39.196934', 1, '2015-03-09 21:08:39.196934', '2015-03-09 21:08:39.196934', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1509, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 21:12:43.101239', 1, '2015-03-09 21:12:43.101239', '2015-03-09 21:12:43.101239', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1510, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 21:42:43.552987', 1, '2015-03-09 21:42:43.552987', '2015-03-09 21:42:43.552987', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1511, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 21:43:16.52937', 1, '2015-03-09 21:43:16.52937', '2015-03-09 21:43:16.52937', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1512, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 21:52:02.910845', 1, '2015-03-09 21:52:02.910845', '2015-03-09 21:52:02.910845', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1513, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 22:08:44.537721', 1, '2015-03-09 22:08:44.537721', '2015-03-09 22:08:44.537721', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1514, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 23:04:47.543623', 1, '2015-03-09 23:04:47.543623', '2015-03-09 23:04:47.543623', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1515, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 23:12:36.533916', 1, '2015-03-09 23:12:36.533916', '2015-03-09 23:12:36.533916', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1516, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 23:27:36.359732', 1, '2015-03-09 23:27:36.359732', '2015-03-09 23:27:36.359732', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1517, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 23:50:15.343292', 1, '2015-03-09 23:50:15.343292', '2015-03-09 23:50:15.343292', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1518, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-09 23:59:11.641476', 1, '2015-03-09 23:59:11.641476', '2015-03-09 23:59:11.641476', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1519, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 00:15:54.5468', 1, '2015-03-10 00:15:54.5468', '2015-03-10 00:15:54.5468', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1520, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 00:18:01.675527', 1, '2015-03-10 00:18:01.675527', '2015-03-10 00:18:01.675527', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1521, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 00:22:45.61619', 1, '2015-03-10 00:22:45.61619', '2015-03-10 00:22:45.61619', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1522, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 00:35:47.01381', 1, '2015-03-10 00:35:47.01381', '2015-03-10 00:35:47.01381', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1523, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 00:37:44.171078', 1, '2015-03-10 00:37:44.171078', '2015-03-10 00:37:44.171078', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1524, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 00:42:43.763507', 1, '2015-03-10 00:42:43.763507', '2015-03-10 00:42:43.763507', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1525, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 00:51:12.31507', 1, '2015-03-10 00:51:12.31507', '2015-03-10 00:51:12.31507', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1526, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 00:56:04.727355', 1, '2015-03-10 00:56:04.727355', '2015-03-10 00:56:04.727355', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1527, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 00:59:25.232876', 1, '2015-03-10 00:59:25.232876', '2015-03-10 00:59:25.232876', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1528, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 01:08:26.459323', 1, '2015-03-10 01:08:26.459323', '2015-03-10 01:08:26.459323', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1529, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 01:29:28.116105', 1, '2015-03-10 01:29:28.116105', '2015-03-10 01:29:28.116105', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1530, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 01:34:28.642594', 1, '2015-03-10 01:34:28.642594', '2015-03-10 01:34:28.642594', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1531, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 01:36:58.772878', 1, '2015-03-10 01:36:58.772878', '2015-03-10 01:36:58.772878', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1532, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 01:55:40.364442', 1, '2015-03-10 01:55:40.364442', '2015-03-10 01:55:40.364442', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1533, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 01:57:38.171087', 1, '2015-03-10 01:57:38.171087', '2015-03-10 01:57:38.171087', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1534, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 01:59:50.644597', 1, '2015-03-10 01:59:50.644597', '2015-03-10 01:59:50.644597', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1535, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 02:08:40.594533', 1, '2015-03-10 02:08:40.594533', '2015-03-10 02:08:40.594533', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1536, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 02:10:55.260767', 1, '2015-03-10 02:10:55.260767', '2015-03-10 02:10:55.260767', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1537, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 02:22:45.273175', 1, '2015-03-10 02:22:45.273175', '2015-03-10 02:22:45.273175', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1538, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 02:24:40.184926', 1, '2015-03-10 02:24:40.184926', '2015-03-10 02:24:40.184926', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1539, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 03:35:48.779668', 1, '2015-03-10 03:35:48.779668', '2015-03-10 03:35:48.779668', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1540, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 04:39:53.532323', 1, '2015-03-10 04:39:53.532323', '2015-03-10 04:39:53.532323', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1541, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 05:41:18.751812', 1, '2015-03-10 05:41:18.751812', '2015-03-10 05:41:18.751812', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1542, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 05:51:53.35285', 1, '2015-03-10 05:51:53.35285', '2015-03-10 05:51:53.35285', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1543, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 10:31:17.463139', 1, '2015-03-10 10:31:17.463139', '2015-03-10 10:31:17.463139', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1544, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 11:02:03.287377', 1, '2015-03-10 11:02:03.287377', '2015-03-10 11:02:03.287377', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1545, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 11:58:48.747169', 1, '2015-03-10 11:58:48.747169', '2015-03-10 11:58:48.747169', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1546, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 11:58:48.907291', 1, '2015-03-10 11:58:48.907291', '2015-03-10 11:58:48.907291', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1547, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 12:40:33.857165', 1, '2015-03-10 12:40:33.857165', '2015-03-10 12:40:33.857165', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1548, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 12:52:16.11228', 1, '2015-03-10 12:52:16.11228', '2015-03-10 12:52:16.11228', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1549, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 13:12:05.559008', 1, '2015-03-10 13:12:05.559008', '2015-03-10 13:12:05.559008', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1550, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 13:21:21.966332', 1, '2015-03-10 13:21:21.966332', '2015-03-10 13:21:21.966332', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1551, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 13:32:55.648685', 1, '2015-03-10 13:32:55.648685', '2015-03-10 13:32:55.648685', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1552, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 13:45:33.257487', 1, '2015-03-10 13:45:33.257487', '2015-03-10 13:45:33.257487', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1553, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 14:19:05.619653', 1, '2015-03-10 14:19:05.619653', '2015-03-10 14:19:05.619653', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1554, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 14:29:19.87456', 1, '2015-03-10 14:29:19.87456', '2015-03-10 14:29:19.87456', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1555, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 14:40:02.4734', 1, '2015-03-10 14:40:02.4734', '2015-03-10 14:40:02.4734', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1556, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 14:43:24.668452', 1, '2015-03-10 14:43:24.668452', '2015-03-10 14:43:24.668452', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1557, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 15:11:46.621247', 1, '2015-03-10 15:11:46.621247', '2015-03-10 15:11:46.621247', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1558, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 15:38:40.520636', 1, '2015-03-10 15:38:40.520636', '2015-03-10 15:38:40.520636', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1559, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 15:43:25.14118', 1, '2015-03-10 15:43:25.14118', '2015-03-10 15:43:25.14118', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1560, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 17:22:29.306957', 1, '2015-03-10 17:22:29.306957', '2015-03-10 17:22:29.306957', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1561, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 18:17:50.844372', 1, '2015-03-10 18:17:50.844372', '2015-03-10 18:17:50.844372', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1562, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 18:21:22.104558', 1, '2015-03-10 18:21:22.104558', '2015-03-10 18:21:22.104558', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1563, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 18:23:10.642451', 1, '2015-03-10 18:23:10.642451', '2015-03-10 18:23:10.642451', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1565, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 18:31:32.260252', 1, '2015-03-10 18:31:32.260252', '2015-03-10 18:31:32.260252', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1566, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 18:49:30.392876', 1, '2015-03-10 18:49:30.392876', '2015-03-10 18:49:30.392876', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1567, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 19:10:42.128987', 1, '2015-03-10 19:10:42.128987', '2015-03-10 19:10:42.128987', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1568, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 19:17:11.753675', 1, '2015-03-10 19:17:11.753675', '2015-03-10 19:17:11.753675', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1569, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 19:19:50.096013', 1, '2015-03-10 19:19:50.096013', '2015-03-10 19:19:50.096013', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1570, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 19:50:28.445071', 1, '2015-03-10 19:50:28.445071', '2015-03-10 19:50:28.445071', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1571, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 20:12:08.387179', 1, '2015-03-10 20:12:08.387179', '2015-03-10 20:12:08.387179', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1572, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 20:29:19.101581', 1, '2015-03-10 20:29:19.101581', '2015-03-10 20:29:19.101581', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1573, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 20:37:09.959882', 1, '2015-03-10 20:37:09.959882', '2015-03-10 20:37:09.959882', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1574, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 21:20:23.960265', 1, '2015-03-10 21:20:23.960265', '2015-03-10 21:20:23.960265', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1575, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 21:44:53.373374', 1, '2015-03-10 21:44:53.373374', '2015-03-10 21:44:53.373374', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1576, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 22:08:05.301427', 1, '2015-03-10 22:08:05.301427', '2015-03-10 22:08:05.301427', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1577, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 22:55:08.849653', 1, '2015-03-10 22:55:08.849653', '2015-03-10 22:55:08.849653', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1578, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 23:11:35.13324', 1, '2015-03-10 23:11:35.13324', '2015-03-10 23:11:35.13324', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1579, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-10 23:34:18.719584', 1, '2015-03-10 23:34:18.719584', '2015-03-10 23:34:18.719584', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1580, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 00:48:21.266579', 1, '2015-03-11 00:48:21.266579', '2015-03-11 00:48:21.266579', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1581, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 00:51:30.116263', 1, '2015-03-11 00:51:30.116263', '2015-03-11 00:51:30.116263', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1582, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 00:58:24.042316', 1, '2015-03-11 00:58:24.042316', '2015-03-11 00:58:24.042316', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1583, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 00:59:01.038293', 1, '2015-03-11 00:59:01.038293', '2015-03-11 00:59:01.038293', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1584, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 01:32:08.982068', 1, '2015-03-11 01:32:08.982068', '2015-03-11 01:32:08.982068', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1585, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 01:39:23.094988', 1, '2015-03-11 01:39:23.094988', '2015-03-11 01:39:23.094988', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1586, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 01:43:45.126691', 1, '2015-03-11 01:43:45.126691', '2015-03-11 01:43:45.126691', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1587, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 01:49:45.620329', 1, '2015-03-11 01:49:45.620329', '2015-03-11 01:49:45.620329', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1588, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 01:51:43.221131', 1, '2015-03-11 01:51:43.221131', '2015-03-11 01:51:43.221131', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1589, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 02:13:41.540444', 1, '2015-03-11 02:13:41.540444', '2015-03-11 02:13:41.540444', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1590, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 02:19:54.658707', 1, '2015-03-11 02:19:54.658707', '2015-03-11 02:19:54.658707', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1591, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 02:43:54.896791', 1, '2015-03-11 02:43:54.896791', '2015-03-11 02:43:54.896791', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1592, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 02:48:23.390014', 1, '2015-03-11 02:48:23.390014', '2015-03-11 02:48:23.390014', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1593, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 02:53:37.58763', 1, '2015-03-11 02:53:37.58763', '2015-03-11 02:53:37.58763', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1594, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 02:55:49.573071', 1, '2015-03-11 02:55:49.573071', '2015-03-11 02:55:49.573071', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1595, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 03:00:33.377397', 1, '2015-03-11 03:00:33.377397', '2015-03-11 03:00:33.377397', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1596, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 03:04:35.900994', 1, '2015-03-11 03:04:35.900994', '2015-03-11 03:04:35.900994', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1597, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 03:10:41.854326', 1, '2015-03-11 03:10:41.854326', '2015-03-11 03:10:41.854326', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1598, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 03:21:27.086924', 1, '2015-03-11 03:21:27.086924', '2015-03-11 03:21:27.086924', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1599, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 03:39:26.195427', 1, '2015-03-11 03:39:26.195427', '2015-03-11 03:39:26.195427', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1600, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 03:39:38.78666', 1, '2015-03-11 03:39:38.78666', '2015-03-11 03:39:38.78666', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1601, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 03:46:21.995676', 1, '2015-03-11 03:46:21.995676', '2015-03-11 03:46:21.995676', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1602, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 03:52:38.103122', 1, '2015-03-11 03:52:38.103122', '2015-03-11 03:52:38.103122', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1603, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 06:20:16.078748', 1, '2015-03-11 06:20:16.078748', '2015-03-11 06:20:16.078748', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1604, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 09:01:03.164177', 1, '2015-03-11 09:01:03.164177', '2015-03-11 09:01:03.164177', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1605, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 11:21:39.021572', 1, '2015-03-11 11:21:39.021572', '2015-03-11 11:21:39.021572', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1607, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 12:50:10.496352', 1, '2015-03-11 12:50:10.496352', '2015-03-11 12:50:10.496352', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1608, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 14:52:03.958104', 1, '2015-03-11 14:52:03.958104', '2015-03-11 14:52:03.958104', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1610, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 15:00:36.968994', 1, '2015-03-11 15:00:36.968994', '2015-03-11 15:00:36.968994', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1609, '{}', 3, 'MARIANELA BRAVO', 'marianela.kine@gmail.com', 'f842190b6c7d134d0fd944fa3861b925', '{}', '', '', '', NULL, '2015-03-11 14:53:21.05425', 1, '2015-03-11 14:53:21.05425', '2015-03-11 14:53:21.05425', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1611, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 15:01:04.550129', 1, '2015-03-11 15:01:04.550129', '2015-03-11 15:01:04.550129', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1612, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 15:02:18.348658', 1, '2015-03-11 15:02:18.348658', '2015-03-11 15:02:18.348658', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1613, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 15:22:14.063489', 1, '2015-03-11 15:22:14.063489', '2015-03-11 15:22:14.063489', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1614, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 15:31:35.514625', 1, '2015-03-11 15:31:35.514625', '2015-03-11 15:31:35.514625', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1615, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 15:38:02.947796', 1, '2015-03-11 15:38:02.947796', '2015-03-11 15:38:02.947796', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1616, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 15:45:47.914703', 1, '2015-03-11 15:45:47.914703', '2015-03-11 15:45:47.914703', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1617, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 15:47:58.111544', 1, '2015-03-11 15:47:58.111544', '2015-03-11 15:47:58.111544', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1618, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 16:18:59.090939', 1, '2015-03-11 16:18:59.090939', '2015-03-11 16:18:59.090939', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1619, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 16:45:40.947252', 1, '2015-03-11 16:45:40.947252', '2015-03-11 16:45:40.947252', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1620, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 17:16:53.182805', 1, '2015-03-11 17:16:53.182805', '2015-03-11 17:16:53.182805', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1621, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 17:17:24.464575', 1, '2015-03-11 17:17:24.464575', '2015-03-11 17:17:24.464575', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1622, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 17:43:23.232371', 1, '2015-03-11 17:43:23.232371', '2015-03-11 17:43:23.232371', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1623, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 17:44:49.576435', 1, '2015-03-11 17:44:49.576435', '2015-03-11 17:44:49.576435', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1624, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 17:58:37.946413', 1, '2015-03-11 17:58:37.946413', '2015-03-11 17:58:37.946413', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1625, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 18:00:53.780372', 1, '2015-03-11 18:00:53.780372', '2015-03-11 18:00:53.780372', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1626, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 18:15:18.067414', 1, '2015-03-11 18:15:18.067414', '2015-03-11 18:15:18.067414', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1627, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 18:17:42.539535', 1, '2015-03-11 18:17:42.539535', '2015-03-11 18:17:42.539535', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1628, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 18:31:38.263535', 1, '2015-03-11 18:31:38.263535', '2015-03-11 18:31:38.263535', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1629, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 18:32:56.882248', 1, '2015-03-11 18:32:56.882248', '2015-03-11 18:32:56.882248', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1630, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 18:35:21.971846', 1, '2015-03-11 18:35:21.971846', '2015-03-11 18:35:21.971846', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1631, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 18:55:48.890809', 1, '2015-03-11 18:55:48.890809', '2015-03-11 18:55:48.890809', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1632, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 19:10:25.205331', 1, '2015-03-11 19:10:25.205331', '2015-03-11 19:10:25.205331', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1633, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 20:15:20.034413', 1, '2015-03-11 20:15:20.034413', '2015-03-11 20:15:20.034413', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1634, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 20:43:58.258564', 1, '2015-03-11 20:43:58.258564', '2015-03-11 20:43:58.258564', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1635, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 20:50:56.284334', 1, '2015-03-11 20:50:56.284334', '2015-03-11 20:50:56.284334', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1637, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 20:55:08.690266', 1, '2015-03-11 20:55:08.690266', '2015-03-11 20:55:08.690266', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1636, '{}', 3, 'Carolina Salinas', 'carolasalinasc@gmail.com', '1bdccfa8e69ab215c7579028c85883ac', '{}', '', '', '', NULL, '2015-03-11 20:51:56.515844', 1, '2015-03-11 20:51:56.515844', '2015-03-11 20:51:56.515844', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1638, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 21:15:57.298783', 1, '2015-03-11 21:15:57.298783', '2015-03-11 21:15:57.298783', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1639, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 21:15:59.597273', 1, '2015-03-11 21:15:59.597273', '2015-03-11 21:15:59.597273', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1640, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 21:16:02.030703', 1, '2015-03-11 21:16:02.030703', '2015-03-11 21:16:02.030703', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1641, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 21:26:33.237013', 1, '2015-03-11 21:26:33.237013', '2015-03-11 21:26:33.237013', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1642, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 21:30:39.162192', 1, '2015-03-11 21:30:39.162192', '2015-03-11 21:30:39.162192', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1643, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 21:46:53.308781', 1, '2015-03-11 21:46:53.308781', '2015-03-11 21:46:53.308781', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1644, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-11 23:14:55.965428', 1, '2015-03-11 23:14:55.965428', '2015-03-11 23:14:55.965428', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1645, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 00:04:15.26202', 1, '2015-03-12 00:04:15.26202', '2015-03-12 00:04:15.26202', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1646, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 00:24:48.898751', 1, '2015-03-12 00:24:48.898751', '2015-03-12 00:24:48.898751', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1647, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 00:30:43.245322', 1, '2015-03-12 00:30:43.245322', '2015-03-12 00:30:43.245322', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1648, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 00:30:45.067071', 1, '2015-03-12 00:30:45.067071', '2015-03-12 00:30:45.067071', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1649, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 00:42:57.421118', 1, '2015-03-12 00:42:57.421118', '2015-03-12 00:42:57.421118', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1650, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 00:48:33.243975', 1, '2015-03-12 00:48:33.243975', '2015-03-12 00:48:33.243975', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1651, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 00:53:18.38313', 1, '2015-03-12 00:53:18.38313', '2015-03-12 00:53:18.38313', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1652, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 00:55:47.607389', 1, '2015-03-12 00:55:47.607389', '2015-03-12 00:55:47.607389', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1653, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 00:56:08.64703', 1, '2015-03-12 00:56:08.64703', '2015-03-12 00:56:08.64703', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1654, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 00:59:38.996144', 1, '2015-03-12 00:59:38.996144', '2015-03-12 00:59:38.996144', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1655, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 01:06:06.275002', 1, '2015-03-12 01:06:06.275002', '2015-03-12 01:06:06.275002', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1656, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 01:15:03.723922', 1, '2015-03-12 01:15:03.723922', '2015-03-12 01:15:03.723922', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1657, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 01:21:45.986152', 1, '2015-03-12 01:21:45.986152', '2015-03-12 01:21:45.986152', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1658, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 01:27:51.514486', 1, '2015-03-12 01:27:51.514486', '2015-03-12 01:27:51.514486', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1659, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 01:42:13.59082', 1, '2015-03-12 01:42:13.59082', '2015-03-12 01:42:13.59082', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1660, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 01:46:59.427913', 1, '2015-03-12 01:46:59.427913', '2015-03-12 01:46:59.427913', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1661, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 01:58:30.891411', 1, '2015-03-12 01:58:30.891411', '2015-03-12 01:58:30.891411', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1662, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 02:12:56.751632', 1, '2015-03-12 02:12:56.751632', '2015-03-12 02:12:56.751632', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1663, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 02:34:48.491918', 1, '2015-03-12 02:34:48.491918', '2015-03-12 02:34:48.491918', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1664, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 03:54:34.477332', 1, '2015-03-12 03:54:34.477332', '2015-03-12 03:54:34.477332', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1665, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 04:23:59.688465', 1, '2015-03-12 04:23:59.688465', '2015-03-12 04:23:59.688465', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1666, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 07:23:16.129156', 1, '2015-03-12 07:23:16.129156', '2015-03-12 07:23:16.129156', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1667, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 07:30:35.481148', 1, '2015-03-12 07:30:35.481148', '2015-03-12 07:30:35.481148', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1668, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 09:35:46.381807', 1, '2015-03-12 09:35:46.381807', '2015-03-12 09:35:46.381807', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1669, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 11:25:37.975683', 1, '2015-03-12 11:25:37.975683', '2015-03-12 11:25:37.975683', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1670, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 11:49:57.255136', 1, '2015-03-12 11:49:57.255136', '2015-03-12 11:49:57.255136', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1671, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 12:00:58.610213', 1, '2015-03-12 12:00:58.610213', '2015-03-12 12:00:58.610213', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1672, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 12:07:35.915289', 1, '2015-03-12 12:07:35.915289', '2015-03-12 12:07:35.915289', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1673, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 12:27:56.517436', 1, '2015-03-12 12:27:56.517436', '2015-03-12 12:27:56.517436', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1674, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 12:33:10.234795', 1, '2015-03-12 12:33:10.234795', '2015-03-12 12:33:10.234795', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1675, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 12:41:25.289054', 1, '2015-03-12 12:41:25.289054', '2015-03-12 12:41:25.289054', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1676, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 13:07:03.67733', 1, '2015-03-12 13:07:03.67733', '2015-03-12 13:07:03.67733', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1677, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 13:43:49.433539', 1, '2015-03-12 13:43:49.433539', '2015-03-12 13:43:49.433539', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1678, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 14:11:01.020784', 1, '2015-03-12 14:11:01.020784', '2015-03-12 14:11:01.020784', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1679, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 14:33:07.164403', 1, '2015-03-12 14:33:07.164403', '2015-03-12 14:33:07.164403', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1680, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 14:50:14.323267', 1, '2015-03-12 14:50:14.323267', '2015-03-12 14:50:14.323267', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1681, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 14:55:30.795644', 1, '2015-03-12 14:55:30.795644', '2015-03-12 14:55:30.795644', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1682, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 15:17:48.89427', 1, '2015-03-12 15:17:48.89427', '2015-03-12 15:17:48.89427', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1683, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 15:49:13.120494', 1, '2015-03-12 15:49:13.120494', '2015-03-12 15:49:13.120494', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1684, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 15:54:56.162871', 1, '2015-03-12 15:54:56.162871', '2015-03-12 15:54:56.162871', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1685, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 16:34:07.327203', 1, '2015-03-12 16:34:07.327203', '2015-03-12 16:34:07.327203', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1686, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 16:34:45.116251', 1, '2015-03-12 16:34:45.116251', '2015-03-12 16:34:45.116251', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1687, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 16:58:55.010717', 1, '2015-03-12 16:58:55.010717', '2015-03-12 16:58:55.010717', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1688, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 17:13:37.753238', 1, '2015-03-12 17:13:37.753238', '2015-03-12 17:13:37.753238', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1689, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 17:33:41.402868', 1, '2015-03-12 17:33:41.402868', '2015-03-12 17:33:41.402868', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1690, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 18:04:47.722207', 1, '2015-03-12 18:04:47.722207', '2015-03-12 18:04:47.722207', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1691, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 18:16:55.825874', 1, '2015-03-12 18:16:55.825874', '2015-03-12 18:16:55.825874', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1692, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 18:17:29.936022', 1, '2015-03-12 18:17:29.936022', '2015-03-12 18:17:29.936022', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1693, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 18:21:45.240203', 1, '2015-03-12 18:21:45.240203', '2015-03-12 18:21:45.240203', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1694, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 18:33:53.609188', 1, '2015-03-12 18:33:53.609188', '2015-03-12 18:33:53.609188', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1695, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 18:48:04.758794', 1, '2015-03-12 18:48:04.758794', '2015-03-12 18:48:04.758794', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1696, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 18:52:10.971839', 1, '2015-03-12 18:52:10.971839', '2015-03-12 18:52:10.971839', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1697, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 19:21:48.223285', 1, '2015-03-12 19:21:48.223285', '2015-03-12 19:21:48.223285', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1698, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 19:42:37.837162', 1, '2015-03-12 19:42:37.837162', '2015-03-12 19:42:37.837162', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1699, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 19:55:14.154743', 1, '2015-03-12 19:55:14.154743', '2015-03-12 19:55:14.154743', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1700, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 20:15:32.589375', 1, '2015-03-12 20:15:32.589375', '2015-03-12 20:15:32.589375', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1701, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 20:53:40.289482', 1, '2015-03-12 20:53:40.289482', '2015-03-12 20:53:40.289482', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1702, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 21:12:26.746667', 1, '2015-03-12 21:12:26.746667', '2015-03-12 21:12:26.746667', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1703, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 21:23:38.155796', 1, '2015-03-12 21:23:38.155796', '2015-03-12 21:23:38.155796', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1704, '{}', 3, 'Karin Hettich', 'kanksunamun_14@hotmail.com', '72a34244f1663e9ea90f3c2e81648022', '{}', '', '', '', NULL, '2015-03-12 21:35:10.137035', 1, '2015-03-12 21:35:10.137035', '2015-03-12 21:35:10.137035', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1705, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 21:42:32.985395', 1, '2015-03-12 21:42:32.985395', '2015-03-12 21:42:32.985395', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1706, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 22:00:04.433725', 1, '2015-03-12 22:00:04.433725', '2015-03-12 22:00:04.433725', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1707, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 22:02:37.648099', 1, '2015-03-12 22:02:37.648099', '2015-03-12 22:02:37.648099', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1708, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 22:05:39.580637', 1, '2015-03-12 22:05:39.580637', '2015-03-12 22:05:39.580637', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1709, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 23:16:07.936268', 1, '2015-03-12 23:16:07.936268', '2015-03-12 23:16:07.936268', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1710, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 23:20:03.129024', 1, '2015-03-12 23:20:03.129024', '2015-03-12 23:20:03.129024', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1711, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 23:42:20.855349', 1, '2015-03-12 23:42:20.855349', '2015-03-12 23:42:20.855349', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1712, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 23:45:20.440536', 1, '2015-03-12 23:45:20.440536', '2015-03-12 23:45:20.440536', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1713, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 23:55:08.366081', 1, '2015-03-12 23:55:08.366081', '2015-03-12 23:55:08.366081', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1714, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 23:55:53.950739', 1, '2015-03-12 23:55:53.950739', '2015-03-12 23:55:53.950739', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1715, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-12 23:59:21.165788', 1, '2015-03-12 23:59:21.165788', '2015-03-12 23:59:21.165788', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1716, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 00:06:59.40046', 1, '2015-03-13 00:06:59.40046', '2015-03-13 00:06:59.40046', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1717, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 00:12:09.32904', 1, '2015-03-13 00:12:09.32904', '2015-03-13 00:12:09.32904', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1718, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 00:14:08.305787', 1, '2015-03-13 00:14:08.305787', '2015-03-13 00:14:08.305787', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1719, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 00:21:00.946445', 1, '2015-03-13 00:21:00.946445', '2015-03-13 00:21:00.946445', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1720, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 00:27:49.694803', 1, '2015-03-13 00:27:49.694803', '2015-03-13 00:27:49.694803', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1721, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 00:31:56.3079', 1, '2015-03-13 00:31:56.3079', '2015-03-13 00:31:56.3079', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1564, '{}', 3, 'katia', 'kattia.barrera@hotmail.com', 'ea0b0d75e926c6bce4d3197187b2002f', '{}', '', '', '', NULL, '2015-03-10 18:30:00.167017', 1, '2015-03-10 18:30:00.167017', '2015-03-10 18:30:00.167017', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1722, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 00:55:18.787024', 1, '2015-03-13 00:55:18.787024', '2015-03-13 00:55:18.787024', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1723, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 01:14:52.538475', 1, '2015-03-13 01:14:52.538475', '2015-03-13 01:14:52.538475', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1724, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 01:36:43.44787', 1, '2015-03-13 01:36:43.44787', '2015-03-13 01:36:43.44787', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1725, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 01:44:14.486128', 1, '2015-03-13 01:44:14.486128', '2015-03-13 01:44:14.486128', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1726, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 02:03:52.597344', 1, '2015-03-13 02:03:52.597344', '2015-03-13 02:03:52.597344', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1727, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 02:10:37.218009', 1, '2015-03-13 02:10:37.218009', '2015-03-13 02:10:37.218009', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1728, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 02:32:35.930395', 1, '2015-03-13 02:32:35.930395', '2015-03-13 02:32:35.930395', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1729, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 02:44:26.661762', 1, '2015-03-13 02:44:26.661762', '2015-03-13 02:44:26.661762', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1730, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 02:47:43.852798', 1, '2015-03-13 02:47:43.852798', '2015-03-13 02:47:43.852798', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1731, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 03:12:35.711778', 1, '2015-03-13 03:12:35.711778', '2015-03-13 03:12:35.711778', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1732, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 03:26:59.398092', 1, '2015-03-13 03:26:59.398092', '2015-03-13 03:26:59.398092', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1733, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 03:54:18.842031', 1, '2015-03-13 03:54:18.842031', '2015-03-13 03:54:18.842031', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1734, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 04:56:23.080375', 1, '2015-03-13 04:56:23.080375', '2015-03-13 04:56:23.080375', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1735, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 10:34:23.175731', 1, '2015-03-13 10:34:23.175731', '2015-03-13 10:34:23.175731', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1736, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 11:17:31.905942', 1, '2015-03-13 11:17:31.905942', '2015-03-13 11:17:31.905942', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1737, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 13:12:34.002328', 1, '2015-03-13 13:12:34.002328', '2015-03-13 13:12:34.002328', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1738, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 13:17:36.384929', 1, '2015-03-13 13:17:36.384929', '2015-03-13 13:17:36.384929', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1739, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 13:25:13.111806', 1, '2015-03-13 13:25:13.111806', '2015-03-13 13:25:13.111806', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1740, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 14:05:53.586555', 1, '2015-03-13 14:05:53.586555', '2015-03-13 14:05:53.586555', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1741, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 15:10:39.770609', 1, '2015-03-13 15:10:39.770609', '2015-03-13 15:10:39.770609', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1742, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 15:14:59.871805', 1, '2015-03-13 15:14:59.871805', '2015-03-13 15:14:59.871805', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1743, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 15:15:49.345668', 1, '2015-03-13 15:15:49.345668', '2015-03-13 15:15:49.345668', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1744, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 15:23:09.961265', 1, '2015-03-13 15:23:09.961265', '2015-03-13 15:23:09.961265', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1745, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 15:23:16.569631', 1, '2015-03-13 15:23:16.569631', '2015-03-13 15:23:16.569631', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1746, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 15:24:12.640324', 1, '2015-03-13 15:24:12.640324', '2015-03-13 15:24:12.640324', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1747, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 15:29:28.512984', 1, '2015-03-13 15:29:28.512984', '2015-03-13 15:29:28.512984', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1748, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 16:01:14.346446', 1, '2015-03-13 16:01:14.346446', '2015-03-13 16:01:14.346446', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1749, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 16:21:46.676691', 1, '2015-03-13 16:21:46.676691', '2015-03-13 16:21:46.676691', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1750, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 16:35:09.886754', 1, '2015-03-13 16:35:09.886754', '2015-03-13 16:35:09.886754', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1751, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 16:41:07.930132', 1, '2015-03-13 16:41:07.930132', '2015-03-13 16:41:07.930132', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1752, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 16:50:32.062571', 1, '2015-03-13 16:50:32.062571', '2015-03-13 16:50:32.062571', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1753, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 16:52:49.86856', 1, '2015-03-13 16:52:49.86856', '2015-03-13 16:52:49.86856', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1754, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 18:12:05.978199', 1, '2015-03-13 18:12:05.978199', '2015-03-13 18:12:05.978199', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1755, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 18:35:07.68623', 1, '2015-03-13 18:35:07.68623', '2015-03-13 18:35:07.68623', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1756, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 18:49:06.089773', 1, '2015-03-13 18:49:06.089773', '2015-03-13 18:49:06.089773', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1757, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 19:36:17.066182', 1, '2015-03-13 19:36:17.066182', '2015-03-13 19:36:17.066182', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1758, '{}', 3, 'maria ester manriquez', 'maryester29@hotmail.com', 'b5ae1e3570329106d34f7e0f26b51fd3', '{}', '', '', '', NULL, '2015-03-13 19:54:28.558308', 1, '2015-03-13 19:54:28.558308', '2015-03-13 19:54:28.558308', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1759, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 20:06:54.848715', 1, '2015-03-13 20:06:54.848715', '2015-03-13 20:06:54.848715', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1760, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 20:42:32.601099', 1, '2015-03-13 20:42:32.601099', '2015-03-13 20:42:32.601099', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1761, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 20:58:30.39983', 1, '2015-03-13 20:58:30.39983', '2015-03-13 20:58:30.39983', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1762, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 21:58:35.089054', 1, '2015-03-13 21:58:35.089054', '2015-03-13 21:58:35.089054', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1763, '{}', 3, 'Marcela Villagran', 'marcelavillagran@hotmail.com', '7616fe08763bd1d6a533b8287117e2d5', '{}', '', '', '', NULL, '2015-03-13 22:36:47.291121', 1, '2015-03-13 22:36:47.291121', '2015-03-13 22:36:47.291121', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1764, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 22:54:55.850305', 1, '2015-03-13 22:54:55.850305', '2015-03-13 22:54:55.850305', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1765, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 23:01:58.670282', 1, '2015-03-13 23:01:58.670282', '2015-03-13 23:01:58.670282', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1766, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 23:03:39.721045', 1, '2015-03-13 23:03:39.721045', '2015-03-13 23:03:39.721045', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1767, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 23:13:34.533698', 1, '2015-03-13 23:13:34.533698', '2015-03-13 23:13:34.533698', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1768, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 23:51:55.054469', 1, '2015-03-13 23:51:55.054469', '2015-03-13 23:51:55.054469', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1769, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-13 23:56:04.417551', 1, '2015-03-13 23:56:04.417551', '2015-03-13 23:56:04.417551', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1770, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 00:01:52.992953', 1, '2015-03-14 00:01:52.992953', '2015-03-14 00:01:52.992953', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1771, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 00:22:43.962495', 1, '2015-03-14 00:22:43.962495', '2015-03-14 00:22:43.962495', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1772, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 00:39:35.978024', 1, '2015-03-14 00:39:35.978024', '2015-03-14 00:39:35.978024', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1774, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 01:22:24.053571', 1, '2015-03-14 01:22:24.053571', '2015-03-14 01:22:24.053571', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1775, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 02:03:56.86463', 1, '2015-03-14 02:03:56.86463', '2015-03-14 02:03:56.86463', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1776, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 02:27:25.710598', 1, '2015-03-14 02:27:25.710598', '2015-03-14 02:27:25.710598', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1777, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 02:32:23.554125', 1, '2015-03-14 02:32:23.554125', '2015-03-14 02:32:23.554125', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1778, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 02:36:46.574994', 1, '2015-03-14 02:36:46.574994', '2015-03-14 02:36:46.574994', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1779, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 02:38:44.188932', 1, '2015-03-14 02:38:44.188932', '2015-03-14 02:38:44.188932', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1780, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 02:39:57.85667', 1, '2015-03-14 02:39:57.85667', '2015-03-14 02:39:57.85667', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1773, '{}', 3, 'claudia valdes', 'claudiavaldes2@hotmail.com', '5a76b0da4579e66f19323991a90fc79f', '{}', '', '', '', NULL, '2015-03-14 01:02:58.790115', 1, '2015-03-14 01:02:58.790115', '2015-03-14 01:02:58.790115', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1781, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 02:50:42.50303', 1, '2015-03-14 02:50:42.50303', '2015-03-14 02:50:42.50303', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1782, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 03:01:15.702895', 1, '2015-03-14 03:01:15.702895', '2015-03-14 03:01:15.702895', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1783, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 03:38:07.591568', 1, '2015-03-14 03:38:07.591568', '2015-03-14 03:38:07.591568', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1784, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 04:27:20.189891', 1, '2015-03-14 04:27:20.189891', '2015-03-14 04:27:20.189891', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1785, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 05:16:09.74476', 1, '2015-03-14 05:16:09.74476', '2015-03-14 05:16:09.74476', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1786, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 11:37:07.356796', 1, '2015-03-14 11:37:07.356796', '2015-03-14 11:37:07.356796', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1787, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 12:18:43.083473', 1, '2015-03-14 12:18:43.083473', '2015-03-14 12:18:43.083473', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1788, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 12:26:07.728087', 1, '2015-03-14 12:26:07.728087', '2015-03-14 12:26:07.728087', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1789, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 12:47:19.859493', 1, '2015-03-14 12:47:19.859493', '2015-03-14 12:47:19.859493', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1793, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 13:55:56.262173', 1, '2015-03-14 13:55:56.262173', '2015-03-14 13:55:56.262173', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1794, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 14:57:11.475772', 1, '2015-03-14 14:57:11.475772', '2015-03-14 14:57:11.475772', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1790, '{}', 3, 'Florencia Alfaro Bächler', 'floalfaro@live.cl', 'f54f730e60063eb9053b6ac95cd87c2d', '{}', '', '', '', NULL, '2015-03-14 13:36:18.715765', 1, '2015-03-14 13:36:18.715765', '2015-03-14 13:36:18.715765', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1792, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 13:46:35.688385', 1, '2015-03-14 13:46:35.688385', '2015-03-14 13:46:35.688385', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1795, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 15:12:14.127365', 1, '2015-03-14 15:12:14.127365', '2015-03-14 15:12:14.127365', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1796, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 15:22:52.369754', 1, '2015-03-14 15:22:52.369754', '2015-03-14 15:22:52.369754', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1797, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 16:04:21.158999', 1, '2015-03-14 16:04:21.158999', '2015-03-14 16:04:21.158999', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1798, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 16:13:02.880968', 1, '2015-03-14 16:13:02.880968', '2015-03-14 16:13:02.880968', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1799, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 16:46:44.64945', 1, '2015-03-14 16:46:44.64945', '2015-03-14 16:46:44.64945', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1800, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 16:52:17.360974', 1, '2015-03-14 16:52:17.360974', '2015-03-14 16:52:17.360974', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1801, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 16:52:54.323504', 1, '2015-03-14 16:52:54.323504', '2015-03-14 16:52:54.323504', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1802, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 17:24:16.309593', 1, '2015-03-14 17:24:16.309593', '2015-03-14 17:24:16.309593', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1803, '{}', 3, 'yasna opazo', 'opazoyasna@gmai.com', 'e70651d3fab74c981007ac055f8ed247', '{}', '', '', '', NULL, '2015-03-14 17:46:43.923331', 1, '2015-03-14 17:46:43.923331', '2015-03-14 17:46:43.923331', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1804, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 18:05:13.89075', 1, '2015-03-14 18:05:13.89075', '2015-03-14 18:05:13.89075', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1805, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 18:40:57.542553', 1, '2015-03-14 18:40:57.542553', '2015-03-14 18:40:57.542553', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1806, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 18:49:34.696909', 1, '2015-03-14 18:49:34.696909', '2015-03-14 18:49:34.696909', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1807, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 18:54:17.073566', 1, '2015-03-14 18:54:17.073566', '2015-03-14 18:54:17.073566', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1808, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 18:59:41.601807', 1, '2015-03-14 18:59:41.601807', '2015-03-14 18:59:41.601807', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1809, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 19:14:55.569952', 1, '2015-03-14 19:14:55.569952', '2015-03-14 19:14:55.569952', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1810, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 19:53:12.350324', 1, '2015-03-14 19:53:12.350324', '2015-03-14 19:53:12.350324', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1811, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 19:57:52.803906', 1, '2015-03-14 19:57:52.803906', '2015-03-14 19:57:52.803906', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1812, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 20:12:12.322035', 1, '2015-03-14 20:12:12.322035', '2015-03-14 20:12:12.322035', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1813, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 20:31:00.386801', 1, '2015-03-14 20:31:00.386801', '2015-03-14 20:31:00.386801', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1814, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 20:31:16.284555', 1, '2015-03-14 20:31:16.284555', '2015-03-14 20:31:16.284555', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1815, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 21:07:12.097856', 1, '2015-03-14 21:07:12.097856', '2015-03-14 21:07:12.097856', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1816, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 21:14:49.638479', 1, '2015-03-14 21:14:49.638479', '2015-03-14 21:14:49.638479', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1817, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 21:44:07.038832', 1, '2015-03-14 21:44:07.038832', '2015-03-14 21:44:07.038832', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1818, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 21:46:53.984694', 1, '2015-03-14 21:46:53.984694', '2015-03-14 21:46:53.984694', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1819, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 21:51:33.673005', 1, '2015-03-14 21:51:33.673005', '2015-03-14 21:51:33.673005', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1820, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 23:20:03.36599', 1, '2015-03-14 23:20:03.36599', '2015-03-14 23:20:03.36599', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1821, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 23:25:38.64258', 1, '2015-03-14 23:25:38.64258', '2015-03-14 23:25:38.64258', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1822, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-14 23:53:47.761403', 1, '2015-03-14 23:53:47.761403', '2015-03-14 23:53:47.761403', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1823, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 00:06:23.102905', 1, '2015-03-15 00:06:23.102905', '2015-03-15 00:06:23.102905', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1824, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 01:08:27.801112', 1, '2015-03-15 01:08:27.801112', '2015-03-15 01:08:27.801112', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1825, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 01:16:01.473177', 1, '2015-03-15 01:16:01.473177', '2015-03-15 01:16:01.473177', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1826, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 01:21:01.763258', 1, '2015-03-15 01:21:01.763258', '2015-03-15 01:21:01.763258', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1827, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 01:24:41.669805', 1, '2015-03-15 01:24:41.669805', '2015-03-15 01:24:41.669805', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1214, '{}', 3, 'Natalia Teheran', 'natiih.-@live.cl', '34c498cc525047c679df218c8323293e', '{}', '', '', '', NULL, '2015-03-04 04:36:08.42244', 1, '2015-03-04 04:36:08.42244', '2015-03-04 04:36:08.42244', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1828, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 01:31:21.278063', 1, '2015-03-15 01:31:21.278063', '2015-03-15 01:31:21.278063', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1829, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 01:52:35.187366', 1, '2015-03-15 01:52:35.187366', '2015-03-15 01:52:35.187366', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1830, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 02:30:29.412982', 1, '2015-03-15 02:30:29.412982', '2015-03-15 02:30:29.412982', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1831, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 02:55:27.924324', 1, '2015-03-15 02:55:27.924324', '2015-03-15 02:55:27.924324', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1832, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 03:27:46.392839', 1, '2015-03-15 03:27:46.392839', '2015-03-15 03:27:46.392839', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1833, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 03:54:24.844794', 1, '2015-03-15 03:54:24.844794', '2015-03-15 03:54:24.844794', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1834, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 04:15:42.343265', 1, '2015-03-15 04:15:42.343265', '2015-03-15 04:15:42.343265', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1835, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 07:22:54.161821', 1, '2015-03-15 07:22:54.161821', '2015-03-15 07:22:54.161821', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1836, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 12:57:03.137991', 1, '2015-03-15 12:57:03.137991', '2015-03-15 12:57:03.137991', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1837, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 12:58:59.400621', 1, '2015-03-15 12:58:59.400621', '2015-03-15 12:58:59.400621', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1838, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 13:15:12.898787', 1, '2015-03-15 13:15:12.898787', '2015-03-15 13:15:12.898787', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1839, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 13:42:53.565319', 1, '2015-03-15 13:42:53.565319', '2015-03-15 13:42:53.565319', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1840, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 13:55:51.902812', 1, '2015-03-15 13:55:51.902812', '2015-03-15 13:55:51.902812', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1841, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 15:42:06.240355', 1, '2015-03-15 15:42:06.240355', '2015-03-15 15:42:06.240355', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1842, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 16:07:15.293368', 1, '2015-03-15 16:07:15.293368', '2015-03-15 16:07:15.293368', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1844, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 16:27:07.40145', 1, '2015-03-15 16:27:07.40145', '2015-03-15 16:27:07.40145', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1843, '{}', 3, 'nicole', 'nicolee.rios@gmail.com', 'd7e6596d3ac2708b35825529dfd385bf', '{}', '', '', '', NULL, '2015-03-15 16:17:39.109233', 1, '2015-03-15 16:17:39.109233', '2015-03-15 16:17:39.109233', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1845, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 17:10:07.649282', 1, '2015-03-15 17:10:07.649282', '2015-03-15 17:10:07.649282', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1846, '{}', 3, 'Fanny', 'fannymondaca@hotmail.com', '25f9e794323b453885f5181f1b624d0b', '{}', '', '', '', NULL, '2015-03-15 17:48:31.098219', 1, '2015-03-15 17:48:31.098219', '2015-03-15 17:48:31.098219', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1847, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 18:31:58.537492', 1, '2015-03-15 18:31:58.537492', '2015-03-15 18:31:58.537492', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1848, '{}', 3, 'kika', 'kikaescobar@gmail.com', '86fbd0371ac963c02057290a328b6864', '{}', '', '', '', NULL, '2015-03-15 18:35:36.270405', 1, '2015-03-15 18:35:36.270405', '2015-03-15 18:35:36.270405', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1850, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 19:24:50.571432', 1, '2015-03-15 19:24:50.571432', '2015-03-15 19:24:50.571432', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1851, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 19:27:58.005597', 1, '2015-03-15 19:27:58.005597', '2015-03-15 19:27:58.005597', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1852, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 19:41:50.691172', 1, '2015-03-15 19:41:50.691172', '2015-03-15 19:41:50.691172', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1853, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 20:26:20.068997', 1, '2015-03-15 20:26:20.068997', '2015-03-15 20:26:20.068997', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1854, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 20:56:02.505846', 1, '2015-03-15 20:56:02.505846', '2015-03-15 20:56:02.505846', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1855, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 21:32:48.609974', 1, '2015-03-15 21:32:48.609974', '2015-03-15 21:32:48.609974', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1856, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 22:09:08.257552', 1, '2015-03-15 22:09:08.257552', '2015-03-15 22:09:08.257552', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1857, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 22:49:46.528603', 1, '2015-03-15 22:49:46.528603', '2015-03-15 22:49:46.528603', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1858, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 23:16:27.24836', 1, '2015-03-15 23:16:27.24836', '2015-03-15 23:16:27.24836', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1859, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 23:20:51.876559', 1, '2015-03-15 23:20:51.876559', '2015-03-15 23:20:51.876559', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1860, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 23:26:54.823398', 1, '2015-03-15 23:26:54.823398', '2015-03-15 23:26:54.823398', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1861, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 23:30:45.320609', 1, '2015-03-15 23:30:45.320609', '2015-03-15 23:30:45.320609', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1862, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-15 23:48:40.304296', 1, '2015-03-15 23:48:40.304296', '2015-03-15 23:48:40.304296', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1863, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 00:48:53.564024', 1, '2015-03-16 00:48:53.564024', '2015-03-16 00:48:53.564024', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1864, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 01:07:37.469695', 1, '2015-03-16 01:07:37.469695', '2015-03-16 01:07:37.469695', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1865, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 02:05:38.932052', 1, '2015-03-16 02:05:38.932052', '2015-03-16 02:05:38.932052', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1866, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 02:16:43.848285', 1, '2015-03-16 02:16:43.848285', '2015-03-16 02:16:43.848285', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1867, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 02:17:45.470308', 1, '2015-03-16 02:17:45.470308', '2015-03-16 02:17:45.470308', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1868, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 02:22:38.465498', 1, '2015-03-16 02:22:38.465498', '2015-03-16 02:22:38.465498', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1869, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 02:35:37.135637', 1, '2015-03-16 02:35:37.135637', '2015-03-16 02:35:37.135637', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1870, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 03:02:35.602701', 1, '2015-03-16 03:02:35.602701', '2015-03-16 03:02:35.602701', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1871, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 03:37:01.519368', 1, '2015-03-16 03:37:01.519368', '2015-03-16 03:37:01.519368', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1872, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 04:24:33.83981', 1, '2015-03-16 04:24:33.83981', '2015-03-16 04:24:33.83981', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1873, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 04:27:35.92039', 1, '2015-03-16 04:27:35.92039', '2015-03-16 04:27:35.92039', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1874, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 04:40:31.724317', 1, '2015-03-16 04:40:31.724317', '2015-03-16 04:40:31.724317', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1875, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 05:03:02.945586', 1, '2015-03-16 05:03:02.945586', '2015-03-16 05:03:02.945586', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1876, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 05:12:59.680993', 1, '2015-03-16 05:12:59.680993', '2015-03-16 05:12:59.680993', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1877, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 07:09:28.447804', 1, '2015-03-16 07:09:28.447804', '2015-03-16 07:09:28.447804', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1878, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 10:02:24.963841', 1, '2015-03-16 10:02:24.963841', '2015-03-16 10:02:24.963841', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1879, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 11:30:55.176053', 1, '2015-03-16 11:30:55.176053', '2015-03-16 11:30:55.176053', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1880, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 12:34:54.548538', 1, '2015-03-16 12:34:54.548538', '2015-03-16 12:34:54.548538', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1881, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 12:44:52.161891', 1, '2015-03-16 12:44:52.161891', '2015-03-16 12:44:52.161891', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1882, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 13:10:31.739148', 1, '2015-03-16 13:10:31.739148', '2015-03-16 13:10:31.739148', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1883, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 13:12:30.50733', 1, '2015-03-16 13:12:30.50733', '2015-03-16 13:12:30.50733', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1884, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 13:18:57.889094', 1, '2015-03-16 13:18:57.889094', '2015-03-16 13:18:57.889094', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1885, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 13:22:02.545328', 1, '2015-03-16 13:22:02.545328', '2015-03-16 13:22:02.545328', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1888, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 14:09:41.565838', 1, '2015-03-16 14:09:41.565838', '2015-03-16 14:09:41.565838', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1890, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 15:21:36.536048', 1, '2015-03-16 15:21:36.536048', '2015-03-16 15:21:36.536048', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1891, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 15:21:43.973348', 1, '2015-03-16 15:21:43.973348', '2015-03-16 15:21:43.973348', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1892, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 15:50:06.154736', 1, '2015-03-16 15:50:06.154736', '2015-03-16 15:50:06.154736', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1893, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 16:43:01.439139', 1, '2015-03-16 16:43:01.439139', '2015-03-16 16:43:01.439139', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1894, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 16:56:42.503148', 1, '2015-03-16 16:56:42.503148', '2015-03-16 16:56:42.503148', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1895, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 17:02:17.110339', 1, '2015-03-16 17:02:17.110339', '2015-03-16 17:02:17.110339', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1896, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 17:19:53.956386', 1, '2015-03-16 17:19:53.956386', '2015-03-16 17:19:53.956386', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1897, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 17:19:54.094949', 1, '2015-03-16 17:19:54.094949', '2015-03-16 17:19:54.094949', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1898, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 17:32:06.148951', 1, '2015-03-16 17:32:06.148951', '2015-03-16 17:32:06.148951', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1899, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 18:17:29.343375', 1, '2015-03-16 18:17:29.343375', '2015-03-16 18:17:29.343375', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1887, '{}', 3, 'Andrea', 'suryn_6@hotmail.com', 'd03d0a1a124407a0ddec89a7d6b2dee2', '{}', '', '', '', NULL, '2015-03-16 13:50:56.792531', 1, '2015-03-16 13:50:56.792531', '2015-03-16 13:50:56.792531', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1900, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 19:14:47.285216', 1, '2015-03-16 19:14:47.285216', '2015-03-16 19:14:47.285216', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1901, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 19:42:56.053453', 1, '2015-03-16 19:42:56.053453', '2015-03-16 19:42:56.053453', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1902, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 19:43:16.288774', 1, '2015-03-16 19:43:16.288774', '2015-03-16 19:43:16.288774', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1903, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 19:53:56.58936', 1, '2015-03-16 19:53:56.58936', '2015-03-16 19:53:56.58936', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1904, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 20:12:04.04648', 1, '2015-03-16 20:12:04.04648', '2015-03-16 20:12:04.04648', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1905, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 20:15:07.176287', 1, '2015-03-16 20:15:07.176287', '2015-03-16 20:15:07.176287', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1906, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 20:23:19.911049', 1, '2015-03-16 20:23:19.911049', '2015-03-16 20:23:19.911049', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1907, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 21:42:33.073276', 1, '2015-03-16 21:42:33.073276', '2015-03-16 21:42:33.073276', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1908, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 21:56:51.880405', 1, '2015-03-16 21:56:51.880405', '2015-03-16 21:56:51.880405', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1909, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-16 22:03:22.140938', 1, '2015-03-16 22:03:22.140938', '2015-03-16 22:03:22.140938', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1910, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 00:27:59.609126', 1, '2015-03-17 00:27:59.609126', '2015-03-17 00:27:59.609126', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1911, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 00:42:45.09046', 1, '2015-03-17 00:42:45.09046', '2015-03-17 00:42:45.09046', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1912, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 00:45:24.562635', 1, '2015-03-17 00:45:24.562635', '2015-03-17 00:45:24.562635', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1914, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 01:31:01.520009', 1, '2015-03-17 01:31:01.520009', '2015-03-17 01:31:01.520009', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1915, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 01:36:08.564703', 1, '2015-03-17 01:36:08.564703', '2015-03-17 01:36:08.564703', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1916, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 01:38:49.607337', 1, '2015-03-17 01:38:49.607337', '2015-03-17 01:38:49.607337', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1917, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 01:43:44.242959', 1, '2015-03-17 01:43:44.242959', '2015-03-17 01:43:44.242959', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1918, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 02:08:20.484195', 1, '2015-03-17 02:08:20.484195', '2015-03-17 02:08:20.484195', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1919, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 02:17:49.177286', 1, '2015-03-17 02:17:49.177286', '2015-03-17 02:17:49.177286', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1920, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 02:29:25.969896', 1, '2015-03-17 02:29:25.969896', '2015-03-17 02:29:25.969896', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1921, '{}', 3, 'Fernanda Acuña Velásquez', 'fernanda.patagonia21@gmail.com', '63c04cc9b0d9412d08b6c573c54b57d2', '{}', '', '', '', NULL, '2015-03-17 02:49:56.2243', 1, '2015-03-17 02:49:56.2243', '2015-03-17 02:49:56.2243', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1922, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 02:57:25.582698', 1, '2015-03-17 02:57:25.582698', '2015-03-17 02:57:25.582698', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1923, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 03:00:27.530307', 1, '2015-03-17 03:00:27.530307', '2015-03-17 03:00:27.530307', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1924, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 03:02:17.290497', 1, '2015-03-17 03:02:17.290497', '2015-03-17 03:02:17.290497', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1925, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 04:04:58.746337', 1, '2015-03-17 04:04:58.746337', '2015-03-17 04:04:58.746337', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1926, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 04:44:25.497778', 1, '2015-03-17 04:44:25.497778', '2015-03-17 04:44:25.497778', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1927, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 10:49:37.359042', 1, '2015-03-17 10:49:37.359042', '2015-03-17 10:49:37.359042', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1928, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 12:36:09.925206', 1, '2015-03-17 12:36:09.925206', '2015-03-17 12:36:09.925206', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1929, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 12:51:48.021531', 1, '2015-03-17 12:51:48.021531', '2015-03-17 12:51:48.021531', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1930, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 13:36:30.868319', 1, '2015-03-17 13:36:30.868319', '2015-03-17 13:36:30.868319', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1886, '{}', 3, 'FERNANDA MONDACA', 'FERNI_DIARIO@HOTMAIL.COM', 'e6ecbab37b42256772482e63e92b3aa6', '{}', '', '', '', NULL, '2015-03-16 13:38:41.214985', 1, '2015-03-16 13:38:41.214985', '2015-03-16 13:38:41.214985', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1931, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 13:59:42.344352', 1, '2015-03-17 13:59:42.344352', '2015-03-17 13:59:42.344352', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1932, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 14:24:39.286892', 1, '2015-03-17 14:24:39.286892', '2015-03-17 14:24:39.286892', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1933, '{}', 3, 'estefany medina', 'fany.medina21@gmail.com', '8356a362e2ed3c5d84fd2845858b1442', '{}', '', '', '', NULL, '2015-03-17 14:29:17.71954', 1, '2015-03-17 14:29:17.71954', '2015-03-17 14:29:17.71954', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1934, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 14:34:56.444437', 1, '2015-03-17 14:34:56.444437', '2015-03-17 14:34:56.444437', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1935, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 14:43:20.631728', 1, '2015-03-17 14:43:20.631728', '2015-03-17 14:43:20.631728', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1936, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 15:12:57.523563', 1, '2015-03-17 15:12:57.523563', '2015-03-17 15:12:57.523563', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1937, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 15:19:05.181932', 1, '2015-03-17 15:19:05.181932', '2015-03-17 15:19:05.181932', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1938, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 15:24:32.730035', 1, '2015-03-17 15:24:32.730035', '2015-03-17 15:24:32.730035', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1939, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 15:36:49.414635', 1, '2015-03-17 15:36:49.414635', '2015-03-17 15:36:49.414635', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1940, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 15:43:41.625051', 1, '2015-03-17 15:43:41.625051', '2015-03-17 15:43:41.625051', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1941, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 15:45:37.963938', 1, '2015-03-17 15:45:37.963938', '2015-03-17 15:45:37.963938', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1942, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 15:51:21.832703', 1, '2015-03-17 15:51:21.832703', '2015-03-17 15:51:21.832703', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1943, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 16:00:40.519959', 1, '2015-03-17 16:00:40.519959', '2015-03-17 16:00:40.519959', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1944, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 16:15:23.892275', 1, '2015-03-17 16:15:23.892275', '2015-03-17 16:15:23.892275', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1945, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 17:08:24.920509', 1, '2015-03-17 17:08:24.920509', '2015-03-17 17:08:24.920509', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1946, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 18:01:14.625797', 1, '2015-03-17 18:01:14.625797', '2015-03-17 18:01:14.625797', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1947, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 18:12:18.4699', 1, '2015-03-17 18:12:18.4699', '2015-03-17 18:12:18.4699', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1948, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 18:18:49.626325', 1, '2015-03-17 18:18:49.626325', '2015-03-17 18:18:49.626325', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1949, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 19:01:04.528032', 1, '2015-03-17 19:01:04.528032', '2015-03-17 19:01:04.528032', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1950, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 19:11:34.252204', 1, '2015-03-17 19:11:34.252204', '2015-03-17 19:11:34.252204', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1951, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 19:12:09.146527', 1, '2015-03-17 19:12:09.146527', '2015-03-17 19:12:09.146527', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1952, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 19:17:51.00001', 1, '2015-03-17 19:17:51.00001', '2015-03-17 19:17:51.00001', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1953, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 19:48:41.916364', 1, '2015-03-17 19:48:41.916364', '2015-03-17 19:48:41.916364', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1954, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 19:52:27.708147', 1, '2015-03-17 19:52:27.708147', '2015-03-17 19:52:27.708147', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1955, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 20:11:44.948565', 1, '2015-03-17 20:11:44.948565', '2015-03-17 20:11:44.948565', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1956, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 20:19:22.29916', 1, '2015-03-17 20:19:22.29916', '2015-03-17 20:19:22.29916', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1957, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 20:22:28.272507', 1, '2015-03-17 20:22:28.272507', '2015-03-17 20:22:28.272507', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1958, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 21:10:08.383114', 1, '2015-03-17 21:10:08.383114', '2015-03-17 21:10:08.383114', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1959, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 21:23:30.641303', 1, '2015-03-17 21:23:30.641303', '2015-03-17 21:23:30.641303', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1960, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 21:48:09.895545', 1, '2015-03-17 21:48:09.895545', '2015-03-17 21:48:09.895545', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1961, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 21:52:05.537216', 1, '2015-03-17 21:52:05.537216', '2015-03-17 21:52:05.537216', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1962, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 21:53:18.333849', 1, '2015-03-17 21:53:18.333849', '2015-03-17 21:53:18.333849', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1963, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 22:19:41.490697', 1, '2015-03-17 22:19:41.490697', '2015-03-17 22:19:41.490697', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1964, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 22:21:28.29483', 1, '2015-03-17 22:21:28.29483', '2015-03-17 22:21:28.29483', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1965, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 22:24:22.391803', 1, '2015-03-17 22:24:22.391803', '2015-03-17 22:24:22.391803', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1966, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 22:32:51.128613', 1, '2015-03-17 22:32:51.128613', '2015-03-17 22:32:51.128613', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1967, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-17 23:53:36.465097', 1, '2015-03-17 23:53:36.465097', '2015-03-17 23:53:36.465097', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1968, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 00:24:50.858207', 1, '2015-03-18 00:24:50.858207', '2015-03-18 00:24:50.858207', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1969, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 00:54:37.155765', 1, '2015-03-18 00:54:37.155765', '2015-03-18 00:54:37.155765', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1970, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 00:56:32.7647', 1, '2015-03-18 00:56:32.7647', '2015-03-18 00:56:32.7647', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1971, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 01:16:42.180767', 1, '2015-03-18 01:16:42.180767', '2015-03-18 01:16:42.180767', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1972, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 01:22:27.632256', 1, '2015-03-18 01:22:27.632256', '2015-03-18 01:22:27.632256', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1973, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 01:33:06.438419', 1, '2015-03-18 01:33:06.438419', '2015-03-18 01:33:06.438419', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1974, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 01:47:30.385555', 1, '2015-03-18 01:47:30.385555', '2015-03-18 01:47:30.385555', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1975, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 02:16:38.102634', 1, '2015-03-18 02:16:38.102634', '2015-03-18 02:16:38.102634', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1976, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 03:00:02.928593', 1, '2015-03-18 03:00:02.928593', '2015-03-18 03:00:02.928593', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1977, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 07:18:49.566746', 1, '2015-03-18 07:18:49.566746', '2015-03-18 07:18:49.566746', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1978, '{}', 3, 'paola ferrufino n', 'paoaleferrufino@gmail.com', '85355cf6ed66c3cb379792b959f5bc3f', '{}', '', '', '', NULL, '2015-03-18 12:03:24.33236', 1, '2015-03-18 12:03:24.33236', '2015-03-18 12:03:24.33236', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1979, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 12:36:00.481939', 1, '2015-03-18 12:36:00.481939', '2015-03-18 12:36:00.481939', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1980, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 13:46:32.235151', 1, '2015-03-18 13:46:32.235151', '2015-03-18 13:46:32.235151', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1981, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 13:57:53.246269', 1, '2015-03-18 13:57:53.246269', '2015-03-18 13:57:53.246269', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1982, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 14:07:44.661656', 1, '2015-03-18 14:07:44.661656', '2015-03-18 14:07:44.661656', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1983, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 14:28:25.111511', 1, '2015-03-18 14:28:25.111511', '2015-03-18 14:28:25.111511', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1984, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 14:31:45.429833', 1, '2015-03-18 14:31:45.429833', '2015-03-18 14:31:45.429833', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1985, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 14:33:46.415907', 1, '2015-03-18 14:33:46.415907', '2015-03-18 14:33:46.415907', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1987, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 15:41:25.891625', 1, '2015-03-18 15:41:25.891625', '2015-03-18 15:41:25.891625', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1988, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 15:47:08.85078', 1, '2015-03-18 15:47:08.85078', '2015-03-18 15:47:08.85078', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1989, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 15:48:59.484544', 1, '2015-03-18 15:48:59.484544', '2015-03-18 15:48:59.484544', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1990, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 15:50:51.804018', 1, '2015-03-18 15:50:51.804018', '2015-03-18 15:50:51.804018', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1991, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 15:54:54.497012', 1, '2015-03-18 15:54:54.497012', '2015-03-18 15:54:54.497012', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1992, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 15:55:12.57424', 1, '2015-03-18 15:55:12.57424', '2015-03-18 15:55:12.57424', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1993, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 16:07:10.597083', 1, '2015-03-18 16:07:10.597083', '2015-03-18 16:07:10.597083', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1994, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 16:44:23.918832', 1, '2015-03-18 16:44:23.918832', '2015-03-18 16:44:23.918832', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1995, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 17:31:37.884593', 1, '2015-03-18 17:31:37.884593', '2015-03-18 17:31:37.884593', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1996, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 17:40:33.491978', 1, '2015-03-18 17:40:33.491978', '2015-03-18 17:40:33.491978', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1997, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 18:21:18.492298', 1, '2015-03-18 18:21:18.492298', '2015-03-18 18:21:18.492298', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1998, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 18:26:41.739022', 1, '2015-03-18 18:26:41.739022', '2015-03-18 18:26:41.739022', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1999, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 18:31:06.692877', 1, '2015-03-18 18:31:06.692877', '2015-03-18 18:31:06.692877', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2000, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 18:31:55.250595', 1, '2015-03-18 18:31:55.250595', '2015-03-18 18:31:55.250595', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2001, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 18:50:48.651821', 1, '2015-03-18 18:50:48.651821', '2015-03-18 18:50:48.651821', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2002, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 18:57:33.767051', 1, '2015-03-18 18:57:33.767051', '2015-03-18 18:57:33.767051', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2003, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 19:09:10.202799', 1, '2015-03-18 19:09:10.202799', '2015-03-18 19:09:10.202799', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2004, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 19:10:38.740406', 1, '2015-03-18 19:10:38.740406', '2015-03-18 19:10:38.740406', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2005, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 19:22:44.692786', 1, '2015-03-18 19:22:44.692786', '2015-03-18 19:22:44.692786', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2006, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 19:38:31.365231', 1, '2015-03-18 19:38:31.365231', '2015-03-18 19:38:31.365231', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2007, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 19:53:05.017213', 1, '2015-03-18 19:53:05.017213', '2015-03-18 19:53:05.017213', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2008, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 20:06:52.92748', 1, '2015-03-18 20:06:52.92748', '2015-03-18 20:06:52.92748', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2009, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 20:50:21.296476', 1, '2015-03-18 20:50:21.296476', '2015-03-18 20:50:21.296476', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2010, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 21:18:56.601552', 1, '2015-03-18 21:18:56.601552', '2015-03-18 21:18:56.601552', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2011, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 21:28:25.560633', 1, '2015-03-18 21:28:25.560633', '2015-03-18 21:28:25.560633', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2012, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 21:37:39.940221', 1, '2015-03-18 21:37:39.940221', '2015-03-18 21:37:39.940221', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2013, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 22:59:19.904704', 1, '2015-03-18 22:59:19.904704', '2015-03-18 22:59:19.904704', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2014, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 23:22:23.004893', 1, '2015-03-18 23:22:23.004893', '2015-03-18 23:22:23.004893', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2015, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 23:39:40.444309', 1, '2015-03-18 23:39:40.444309', '2015-03-18 23:39:40.444309', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2016, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-18 23:47:53.629055', 1, '2015-03-18 23:47:53.629055', '2015-03-18 23:47:53.629055', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2017, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 00:11:31.118782', 1, '2015-03-19 00:11:31.118782', '2015-03-19 00:11:31.118782', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2018, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 01:01:50.307032', 1, '2015-03-19 01:01:50.307032', '2015-03-19 01:01:50.307032', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1913, '{}', 3, 'Carmen Gonzalez Inostroza', 'yoyita_265@hotmail.com', '9511c4656bff852acac89250340abe07', '{}', '', '', '', NULL, '2015-03-17 00:57:38.419108', 1, '2015-03-17 00:57:38.419108', '2015-03-17 00:57:38.419108', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2019, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 01:22:21.602757', 1, '2015-03-19 01:22:21.602757', '2015-03-19 01:22:21.602757', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2020, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 01:22:47.167967', 1, '2015-03-19 01:22:47.167967', '2015-03-19 01:22:47.167967', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2021, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 01:34:49.313425', 1, '2015-03-19 01:34:49.313425', '2015-03-19 01:34:49.313425', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2022, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 02:16:09.946559', 1, '2015-03-19 02:16:09.946559', '2015-03-19 02:16:09.946559', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2023, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 02:17:16.770143', 1, '2015-03-19 02:17:16.770143', '2015-03-19 02:17:16.770143', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2024, '{}', 3, 'belen', 'belen.navarretes@gmail.com', '2260722d35bb8becf9192b4d4b11a184', '{}', '', '', '', NULL, '2015-03-19 02:28:08.560281', 1, '2015-03-19 02:28:08.560281', '2015-03-19 02:28:08.560281', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2025, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 02:32:21.667804', 1, '2015-03-19 02:32:21.667804', '2015-03-19 02:32:21.667804', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2026, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 03:18:46.249775', 1, '2015-03-19 03:18:46.249775', '2015-03-19 03:18:46.249775', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2027, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 03:43:26.011936', 1, '2015-03-19 03:43:26.011936', '2015-03-19 03:43:26.011936', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2028, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 03:58:56.553649', 1, '2015-03-19 03:58:56.553649', '2015-03-19 03:58:56.553649', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2029, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 04:14:44.006486', 1, '2015-03-19 04:14:44.006486', '2015-03-19 04:14:44.006486', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2030, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 04:25:38.943811', 1, '2015-03-19 04:25:38.943811', '2015-03-19 04:25:38.943811', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2031, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 04:48:18.518467', 1, '2015-03-19 04:48:18.518467', '2015-03-19 04:48:18.518467', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2032, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 04:48:42.79169', 1, '2015-03-19 04:48:42.79169', '2015-03-19 04:48:42.79169', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2033, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 12:24:44.54196', 1, '2015-03-19 12:24:44.54196', '2015-03-19 12:24:44.54196', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2034, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 12:40:42.049843', 1, '2015-03-19 12:40:42.049843', '2015-03-19 12:40:42.049843', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2035, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 13:05:13.897482', 1, '2015-03-19 13:05:13.897482', '2015-03-19 13:05:13.897482', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2036, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 13:36:56.781922', 1, '2015-03-19 13:36:56.781922', '2015-03-19 13:36:56.781922', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2037, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 13:41:21.686118', 1, '2015-03-19 13:41:21.686118', '2015-03-19 13:41:21.686118', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2038, '{}', 3, 'Daniela Alvarez Pardo', 'ddannitita@hotmail.com', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 13:52:14.52314', 1, '2015-03-19 13:52:14.52314', '2015-03-19 13:52:14.52314', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2039, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 14:02:13.442447', 1, '2015-03-19 14:02:13.442447', '2015-03-19 14:02:13.442447', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2040, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 15:10:57.953855', 1, '2015-03-19 15:10:57.953855', '2015-03-19 15:10:57.953855', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2041, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 16:12:19.136723', 1, '2015-03-19 16:12:19.136723', '2015-03-19 16:12:19.136723', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2042, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 16:55:12.825752', 1, '2015-03-19 16:55:12.825752', '2015-03-19 16:55:12.825752', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2043, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 17:14:52.294962', 1, '2015-03-19 17:14:52.294962', '2015-03-19 17:14:52.294962', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2044, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 17:41:30.020362', 1, '2015-03-19 17:41:30.020362', '2015-03-19 17:41:30.020362', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2045, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 17:48:43.707193', 1, '2015-03-19 17:48:43.707193', '2015-03-19 17:48:43.707193', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2046, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 17:53:27.716864', 1, '2015-03-19 17:53:27.716864', '2015-03-19 17:53:27.716864', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2047, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 18:17:16.294279', 1, '2015-03-19 18:17:16.294279', '2015-03-19 18:17:16.294279', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2048, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 18:38:59.735357', 1, '2015-03-19 18:38:59.735357', '2015-03-19 18:38:59.735357', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2049, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 19:14:54.347599', 1, '2015-03-19 19:14:54.347599', '2015-03-19 19:14:54.347599', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2050, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 20:09:33.884048', 1, '2015-03-19 20:09:33.884048', '2015-03-19 20:09:33.884048', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2051, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 21:01:29.079574', 1, '2015-03-19 21:01:29.079574', '2015-03-19 21:01:29.079574', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2052, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 21:38:22.043106', 1, '2015-03-19 21:38:22.043106', '2015-03-19 21:38:22.043106', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2053, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 21:57:43.339736', 1, '2015-03-19 21:57:43.339736', '2015-03-19 21:57:43.339736', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2054, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 22:16:19.186283', 1, '2015-03-19 22:16:19.186283', '2015-03-19 22:16:19.186283', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2055, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-19 23:48:39.692498', 1, '2015-03-19 23:48:39.692498', '2015-03-19 23:48:39.692498', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2056, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 00:02:21.916225', 1, '2015-03-20 00:02:21.916225', '2015-03-20 00:02:21.916225', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2057, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 00:04:49.455645', 1, '2015-03-20 00:04:49.455645', '2015-03-20 00:04:49.455645', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2058, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 00:11:47.164696', 1, '2015-03-20 00:11:47.164696', '2015-03-20 00:11:47.164696', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2059, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 00:32:06.451882', 1, '2015-03-20 00:32:06.451882', '2015-03-20 00:32:06.451882', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2060, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 01:20:55.359466', 1, '2015-03-20 01:20:55.359466', '2015-03-20 01:20:55.359466', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2061, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 01:36:08.919422', 1, '2015-03-20 01:36:08.919422', '2015-03-20 01:36:08.919422', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2062, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 02:06:59.11744', 1, '2015-03-20 02:06:59.11744', '2015-03-20 02:06:59.11744', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2063, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 04:30:06.811398', 1, '2015-03-20 04:30:06.811398', '2015-03-20 04:30:06.811398', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2064, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 05:31:00.615202', 1, '2015-03-20 05:31:00.615202', '2015-03-20 05:31:00.615202', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2065, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 07:26:14.762361', 1, '2015-03-20 07:26:14.762361', '2015-03-20 07:26:14.762361', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2066, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 10:21:51.957713', 1, '2015-03-20 10:21:51.957713', '2015-03-20 10:21:51.957713', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2067, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 12:15:54.010215', 1, '2015-03-20 12:15:54.010215', '2015-03-20 12:15:54.010215', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2068, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 12:39:59.519444', 1, '2015-03-20 12:39:59.519444', '2015-03-20 12:39:59.519444', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2069, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 13:11:43.943362', 1, '2015-03-20 13:11:43.943362', '2015-03-20 13:11:43.943362', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2070, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 13:17:10.316295', 1, '2015-03-20 13:17:10.316295', '2015-03-20 13:17:10.316295', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2071, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 13:24:35.827455', 1, '2015-03-20 13:24:35.827455', '2015-03-20 13:24:35.827455', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2072, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 14:05:22.803893', 1, '2015-03-20 14:05:22.803893', '2015-03-20 14:05:22.803893', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2073, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 15:12:29.115591', 1, '2015-03-20 15:12:29.115591', '2015-03-20 15:12:29.115591', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2074, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 15:32:28.369156', 1, '2015-03-20 15:32:28.369156', '2015-03-20 15:32:28.369156', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2075, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 15:34:46.548933', 1, '2015-03-20 15:34:46.548933', '2015-03-20 15:34:46.548933', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2076, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 15:49:48.834149', 1, '2015-03-20 15:49:48.834149', '2015-03-20 15:49:48.834149', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2077, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 15:55:51.20277', 1, '2015-03-20 15:55:51.20277', '2015-03-20 15:55:51.20277', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2078, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 16:14:42.081241', 1, '2015-03-20 16:14:42.081241', '2015-03-20 16:14:42.081241', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2079, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 16:15:26.792328', 1, '2015-03-20 16:15:26.792328', '2015-03-20 16:15:26.792328', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2080, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 16:38:31.595799', 1, '2015-03-20 16:38:31.595799', '2015-03-20 16:38:31.595799', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2081, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 16:39:54.378259', 1, '2015-03-20 16:39:54.378259', '2015-03-20 16:39:54.378259', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2082, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 16:51:08.04346', 1, '2015-03-20 16:51:08.04346', '2015-03-20 16:51:08.04346', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2083, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 17:53:02.692046', 1, '2015-03-20 17:53:02.692046', '2015-03-20 17:53:02.692046', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2084, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 18:35:38.879826', 1, '2015-03-20 18:35:38.879826', '2015-03-20 18:35:38.879826', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2085, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 18:40:42.678817', 1, '2015-03-20 18:40:42.678817', '2015-03-20 18:40:42.678817', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2086, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 19:01:49.361573', 1, '2015-03-20 19:01:49.361573', '2015-03-20 19:01:49.361573', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2087, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 19:08:59.206058', 1, '2015-03-20 19:08:59.206058', '2015-03-20 19:08:59.206058', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2088, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 19:53:12.210423', 1, '2015-03-20 19:53:12.210423', '2015-03-20 19:53:12.210423', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2089, '{}', 3, 'carolina raggi', 'carolaraggi@gmail.com', '53c6de78244e9f528eb3e1cda69699bb', '{}', '', '', '', NULL, '2015-03-20 20:01:35.544685', 1, '2015-03-20 20:01:35.544685', '2015-03-20 20:01:35.544685', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2090, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 20:22:41.158778', 1, '2015-03-20 20:22:41.158778', '2015-03-20 20:22:41.158778', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2091, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 20:25:17.193925', 1, '2015-03-20 20:25:17.193925', '2015-03-20 20:25:17.193925', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2092, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 21:40:46.31306', 1, '2015-03-20 21:40:46.31306', '2015-03-20 21:40:46.31306', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2093, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 22:27:00.387141', 1, '2015-03-20 22:27:00.387141', '2015-03-20 22:27:00.387141', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2094, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 23:08:44.008679', 1, '2015-03-20 23:08:44.008679', '2015-03-20 23:08:44.008679', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2095, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-20 23:34:20.653914', 1, '2015-03-20 23:34:20.653914', '2015-03-20 23:34:20.653914', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2096, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 00:58:43.685888', 1, '2015-03-21 00:58:43.685888', '2015-03-21 00:58:43.685888', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2097, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 01:01:35.799645', 1, '2015-03-21 01:01:35.799645', '2015-03-21 01:01:35.799645', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2098, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 01:05:09.027615', 1, '2015-03-21 01:05:09.027615', '2015-03-21 01:05:09.027615', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2099, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 01:24:03.49626', 1, '2015-03-21 01:24:03.49626', '2015-03-21 01:24:03.49626', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2100, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 01:46:06.999667', 1, '2015-03-21 01:46:06.999667', '2015-03-21 01:46:06.999667', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2101, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 02:02:18.283715', 1, '2015-03-21 02:02:18.283715', '2015-03-21 02:02:18.283715', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2102, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 02:06:28.072342', 1, '2015-03-21 02:06:28.072342', '2015-03-21 02:06:28.072342', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2103, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 02:18:55.540518', 1, '2015-03-21 02:18:55.540518', '2015-03-21 02:18:55.540518', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2104, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 02:53:14.839372', 1, '2015-03-21 02:53:14.839372', '2015-03-21 02:53:14.839372', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2105, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 03:02:47.313813', 1, '2015-03-21 03:02:47.313813', '2015-03-21 03:02:47.313813', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2106, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 03:24:43.837995', 1, '2015-03-21 03:24:43.837995', '2015-03-21 03:24:43.837995', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2107, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 04:16:38.2119', 1, '2015-03-21 04:16:38.2119', '2015-03-21 04:16:38.2119', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2108, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 04:26:24.989629', 1, '2015-03-21 04:26:24.989629', '2015-03-21 04:26:24.989629', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2109, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 10:21:43.774473', 1, '2015-03-21 10:21:43.774473', '2015-03-21 10:21:43.774473', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2110, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 11:04:40.403566', 1, '2015-03-21 11:04:40.403566', '2015-03-21 11:04:40.403566', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2111, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 11:21:00.543891', 1, '2015-03-21 11:21:00.543891', '2015-03-21 11:21:00.543891', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2112, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 12:27:57.138291', 1, '2015-03-21 12:27:57.138291', '2015-03-21 12:27:57.138291', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2113, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 13:40:53.330842', 1, '2015-03-21 13:40:53.330842', '2015-03-21 13:40:53.330842', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2114, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 13:50:31.828898', 1, '2015-03-21 13:50:31.828898', '2015-03-21 13:50:31.828898', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2115, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 13:59:56.756173', 1, '2015-03-21 13:59:56.756173', '2015-03-21 13:59:56.756173', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2116, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 15:36:28.049554', 1, '2015-03-21 15:36:28.049554', '2015-03-21 15:36:28.049554', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2117, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 16:52:34.585661', 1, '2015-03-21 16:52:34.585661', '2015-03-21 16:52:34.585661', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2118, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 17:00:20.489416', 1, '2015-03-21 17:00:20.489416', '2015-03-21 17:00:20.489416', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2119, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 17:09:44.314492', 1, '2015-03-21 17:09:44.314492', '2015-03-21 17:09:44.314492', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2120, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 17:32:25.182238', 1, '2015-03-21 17:32:25.182238', '2015-03-21 17:32:25.182238', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2121, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 18:24:47.445963', 1, '2015-03-21 18:24:47.445963', '2015-03-21 18:24:47.445963', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2122, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 18:26:59.413263', 1, '2015-03-21 18:26:59.413263', '2015-03-21 18:26:59.413263', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2123, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 18:35:44.998959', 1, '2015-03-21 18:35:44.998959', '2015-03-21 18:35:44.998959', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2124, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 18:45:51.713736', 1, '2015-03-21 18:45:51.713736', '2015-03-21 18:45:51.713736', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2125, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 19:22:13.573398', 1, '2015-03-21 19:22:13.573398', '2015-03-21 19:22:13.573398', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2126, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 19:26:23.760119', 1, '2015-03-21 19:26:23.760119', '2015-03-21 19:26:23.760119', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2127, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 19:34:54.683622', 1, '2015-03-21 19:34:54.683622', '2015-03-21 19:34:54.683622', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2128, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 20:03:45.806218', 1, '2015-03-21 20:03:45.806218', '2015-03-21 20:03:45.806218', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2129, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 20:32:26.283162', 1, '2015-03-21 20:32:26.283162', '2015-03-21 20:32:26.283162', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2130, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 20:38:14.294378', 1, '2015-03-21 20:38:14.294378', '2015-03-21 20:38:14.294378', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2131, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 22:10:12.725212', 1, '2015-03-21 22:10:12.725212', '2015-03-21 22:10:12.725212', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2132, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 22:23:36.005651', 1, '2015-03-21 22:23:36.005651', '2015-03-21 22:23:36.005651', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2133, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 22:45:35.784526', 1, '2015-03-21 22:45:35.784526', '2015-03-21 22:45:35.784526', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2134, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 23:30:06.914377', 1, '2015-03-21 23:30:06.914377', '2015-03-21 23:30:06.914377', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2136, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-21 23:53:59.231221', 1, '2015-03-21 23:53:59.231221', '2015-03-21 23:53:59.231221', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2137, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 00:39:25.858938', 1, '2015-03-22 00:39:25.858938', '2015-03-22 00:39:25.858938', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2138, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 00:39:38.890149', 1, '2015-03-22 00:39:38.890149', '2015-03-22 00:39:38.890149', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2139, '{}', 3, 'Maria Jesus Cruz', 'maje77@gmail.com', 'de6c136a2b46c61dce65de130a3ae84d', '{}', '', '', '', NULL, '2015-03-22 00:45:25.819667', 1, '2015-03-22 00:45:25.819667', '2015-03-22 00:45:25.819667', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2140, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 00:56:36.799748', 1, '2015-03-22 00:56:36.799748', '2015-03-22 00:56:36.799748', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2141, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 01:02:19.865839', 1, '2015-03-22 01:02:19.865839', '2015-03-22 01:02:19.865839', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2142, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 01:02:28.683552', 1, '2015-03-22 01:02:28.683552', '2015-03-22 01:02:28.683552', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2143, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 01:47:27.604239', 1, '2015-03-22 01:47:27.604239', '2015-03-22 01:47:27.604239', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (1986, '{}', 3, 'Yosseline Ortega', 'yoss.ortega.g@gmail.com', 'f91c698b75ba1441ec54d58a8904923a', '{}', '', '', '', NULL, '2015-03-18 15:39:18.899878', 1, '2015-03-18 15:39:18.899878', '2015-03-18 15:39:18.899878', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2144, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 01:55:28.715408', 1, '2015-03-22 01:55:28.715408', '2015-03-22 01:55:28.715408', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2145, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 02:13:23.8597', 1, '2015-03-22 02:13:23.8597', '2015-03-22 02:13:23.8597', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2146, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 02:25:42.053386', 1, '2015-03-22 02:25:42.053386', '2015-03-22 02:25:42.053386', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2147, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 03:06:50.008084', 1, '2015-03-22 03:06:50.008084', '2015-03-22 03:06:50.008084', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2148, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 03:38:55.764648', 1, '2015-03-22 03:38:55.764648', '2015-03-22 03:38:55.764648', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2149, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 03:54:49.803522', 1, '2015-03-22 03:54:49.803522', '2015-03-22 03:54:49.803522', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2150, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 03:56:52.607514', 1, '2015-03-22 03:56:52.607514', '2015-03-22 03:56:52.607514', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2151, '{}', 3, 'Andrea Araya', 'debyaraya@hotmail.com', 'c6527de88fbee86c65113069261a2687', '{}', '', '', '', NULL, '2015-03-22 05:03:39.026374', 1, '2015-03-22 05:03:39.026374', '2015-03-22 05:03:39.026374', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2153, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 05:34:18.241323', 1, '2015-03-22 05:34:18.241323', '2015-03-22 05:34:18.241323', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2152, '{}', 3, 'Elizabeth Gutierrez', 'elygutleon@gmail.com', '1812c2be1b7978f540f3a758646b3f44', '{}', '', '', '', NULL, '2015-03-22 05:31:57.106892', 1, '2015-03-22 05:31:57.106892', '2015-03-22 05:31:57.106892', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2154, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 07:56:16.196055', 1, '2015-03-22 07:56:16.196055', '2015-03-22 07:56:16.196055', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2155, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 08:58:35.564433', 1, '2015-03-22 08:58:35.564433', '2015-03-22 08:58:35.564433', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2156, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 09:08:52.795184', 1, '2015-03-22 09:08:52.795184', '2015-03-22 09:08:52.795184', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2157, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 09:24:21.026181', 1, '2015-03-22 09:24:21.026181', '2015-03-22 09:24:21.026181', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2158, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 12:31:42.097154', 1, '2015-03-22 12:31:42.097154', '2015-03-22 12:31:42.097154', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2159, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 13:19:45.982217', 1, '2015-03-22 13:19:45.982217', '2015-03-22 13:19:45.982217', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2160, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 13:21:44.261812', 1, '2015-03-22 13:21:44.261812', '2015-03-22 13:21:44.261812', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2161, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 14:28:04.724903', 1, '2015-03-22 14:28:04.724903', '2015-03-22 14:28:04.724903', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2162, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 16:35:25.715132', 1, '2015-03-22 16:35:25.715132', '2015-03-22 16:35:25.715132', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2163, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 16:52:00.114469', 1, '2015-03-22 16:52:00.114469', '2015-03-22 16:52:00.114469', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2164, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 17:43:33.382936', 1, '2015-03-22 17:43:33.382936', '2015-03-22 17:43:33.382936', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2165, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 17:54:21.618557', 1, '2015-03-22 17:54:21.618557', '2015-03-22 17:54:21.618557', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2166, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 18:26:37.189629', 1, '2015-03-22 18:26:37.189629', '2015-03-22 18:26:37.189629', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2167, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 18:33:30.982163', 1, '2015-03-22 18:33:30.982163', '2015-03-22 18:33:30.982163', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2168, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 19:01:44.530681', 1, '2015-03-22 19:01:44.530681', '2015-03-22 19:01:44.530681', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2169, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 19:17:20.781224', 1, '2015-03-22 19:17:20.781224', '2015-03-22 19:17:20.781224', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2170, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 19:20:33.994848', 1, '2015-03-22 19:20:33.994848', '2015-03-22 19:20:33.994848', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2171, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 19:22:35.327818', 1, '2015-03-22 19:22:35.327818', '2015-03-22 19:22:35.327818', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2172, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 19:25:07.595889', 1, '2015-03-22 19:25:07.595889', '2015-03-22 19:25:07.595889', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2173, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 19:35:26.69374', 1, '2015-03-22 19:35:26.69374', '2015-03-22 19:35:26.69374', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2174, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 19:37:58.340567', 1, '2015-03-22 19:37:58.340567', '2015-03-22 19:37:58.340567', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2175, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 19:52:07.229946', 1, '2015-03-22 19:52:07.229946', '2015-03-22 19:52:07.229946', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2176, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 22:09:47.308511', 1, '2015-03-22 22:09:47.308511', '2015-03-22 22:09:47.308511', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2177, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 22:30:11.294003', 1, '2015-03-22 22:30:11.294003', '2015-03-22 22:30:11.294003', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2178, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 22:42:37.740023', 1, '2015-03-22 22:42:37.740023', '2015-03-22 22:42:37.740023', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2179, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-22 23:38:57.931925', 1, '2015-03-22 23:38:57.931925', '2015-03-22 23:38:57.931925', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2180, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 00:06:53.414599', 1, '2015-03-23 00:06:53.414599', '2015-03-23 00:06:53.414599', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2182, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 00:28:35.981205', 1, '2015-03-23 00:28:35.981205', '2015-03-23 00:28:35.981205', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2181, '{}', 3, 'Jimena Gonzalez', 'Jimenagonzalezg@gmail.com', 'a037804e7e57a6b4a29fbce4a1cf9ca3', '{}', '', '', '', NULL, '2015-03-23 00:25:23.627142', 1, '2015-03-23 00:25:23.627142', '2015-03-23 00:25:23.627142', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2183, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 00:40:28.937623', 1, '2015-03-23 00:40:28.937623', '2015-03-23 00:40:28.937623', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2184, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 01:14:44.269632', 1, '2015-03-23 01:14:44.269632', '2015-03-23 01:14:44.269632', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2185, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 01:26:56.972916', 1, '2015-03-23 01:26:56.972916', '2015-03-23 01:26:56.972916', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2186, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 02:01:25.117888', 1, '2015-03-23 02:01:25.117888', '2015-03-23 02:01:25.117888', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2187, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 02:21:51.758947', 1, '2015-03-23 02:21:51.758947', '2015-03-23 02:21:51.758947', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2188, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 02:43:14.851034', 1, '2015-03-23 02:43:14.851034', '2015-03-23 02:43:14.851034', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2189, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 02:44:59.395322', 1, '2015-03-23 02:44:59.395322', '2015-03-23 02:44:59.395322', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2190, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 02:57:08.131458', 1, '2015-03-23 02:57:08.131458', '2015-03-23 02:57:08.131458', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2191, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 02:59:50.570928', 1, '2015-03-23 02:59:50.570928', '2015-03-23 02:59:50.570928', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2192, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 03:05:25.757376', 1, '2015-03-23 03:05:25.757376', '2015-03-23 03:05:25.757376', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2193, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 03:07:24.60969', 1, '2015-03-23 03:07:24.60969', '2015-03-23 03:07:24.60969', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2194, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 03:27:32.565366', 1, '2015-03-23 03:27:32.565366', '2015-03-23 03:27:32.565366', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2195, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 03:43:25.460573', 1, '2015-03-23 03:43:25.460573', '2015-03-23 03:43:25.460573', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2196, '{}', 3, 'Noemy Matamala', 'be_besa@hotmail.es', '7313d9ec022af2eef583f3430aa3f683', '{}', '', '', '', NULL, '2015-03-23 04:10:53.686451', 1, '2015-03-23 04:10:53.686451', '2015-03-23 04:10:53.686451', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2197, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 12:21:33.612246', 1, '2015-03-23 12:21:33.612246', '2015-03-23 12:21:33.612246', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2198, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 13:10:04.80118', 1, '2015-03-23 13:10:04.80118', '2015-03-23 13:10:04.80118', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2199, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 13:12:23.087625', 1, '2015-03-23 13:12:23.087625', '2015-03-23 13:12:23.087625', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2200, '{}', 3, 'alejandra', 'aleezacarias@hotmail.com', '0fb4bd4d4e3650a60c5e03fcedc196e0', '{}', '', '', '', NULL, '2015-03-23 13:14:09.814689', 1, '2015-03-23 13:14:09.814689', '2015-03-23 13:14:09.814689', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2203, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 14:22:51.854773', 1, '2015-03-23 14:22:51.854773', '2015-03-23 14:22:51.854773', 0);
INSERT INTO "User" (id, permissions, type_id, name, email, password, cellar_permissions, lastname, rut, bussiness, approval_date, registration_date, status, first_view, last_view, deleted) VALUES (2204, '{}', 5, '', '', 'd41d8cd98f00b204e9800998ecf8427e', '{}', '', '', '', NULL, '2015-03-23 15:40:47.824051', 1, '2015-03-23 15:40:47.824051', '2015-03-23 15:40:47.824051', 0);


--
-- Data for Name: User_Types; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "User_Types" (id, name) VALUES (1, 'Vendedor');
INSERT INTO "User_Types" (id, name) VALUES (2, 'Administrador');
INSERT INTO "User_Types" (id, name) VALUES (3, 'Cliente');
INSERT INTO "User_Types" (id, name) VALUES (4, 'Cliente Mayorista');
INSERT INTO "User_Types" (id, name) VALUES (5, 'Visita');


--
-- Name: User_Types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"User_Types_id_seq"', 4, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"User_id_seq"', 2204, true);


--
-- Data for Name: Voto; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Voto" (id, user_id, product_id) VALUES (1, 6, 1);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (2, 13, 1);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (3, 1, 13);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (4, 253, 6);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (5, 282, 6);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (6, 312, 6);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (7, 22, 22);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (8, 412, 20);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (9, 422, 11);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (10, 22, 6);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (11, 16, 24);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (12, 436, 10);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (13, 16, 11);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (14, 16, 16);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (15, 22, 18);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (16, 450, 16);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (17, 458, 8);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (18, 22, 8);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (19, 469, 12);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (20, 28, 32);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (21, 28, 27);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (22, 28, 28);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (23, 0, 116);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (24, 769, 116);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (25, 816, 124);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (26, 974, 124);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (27, 1033, 122);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (28, 1042, 137);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (29, 1047, 137);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (30, 1142, 121);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (31, 1176, 114);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (32, 1209, 117);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (33, 1077, 127);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (34, 1326, 116);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (35, 1339, 121);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (36, 1394, 126);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (37, 1423, 126);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (38, 1451, 121);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (39, 1161, 125);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (40, 1521, 118);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (41, 1682, 147);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (42, 1534, 121);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (43, 1564, 128);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (44, 1384, 137);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (45, 1773, 137);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (46, 2038, 131);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (47, 829, 119);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (48, 829, 118);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (49, 829, 116);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (50, 829, 126);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (51, 829, 125);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (52, 829, 123);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (53, 829, 135);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (54, 829, 137);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (55, 829, 134);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (56, 829, 138);
INSERT INTO "Voto" (id, user_id, product_id) VALUES (57, 2157, 122);


--
-- Name: Votos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Votos_id_seq"', 57, true);


--
-- Data for Name: Webpay; Type: TABLE DATA; Schema: public; Owner: yichun
--

INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (1, 3140000, 116333, 6623, 1109, 1109, 13327, 550763457, 'VN', 0, '20141109043347', 189, 189);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (2, 3140000, 202944, 6623, 1109, 1109, 14201, 550814847, 'VN', 0, '20141109044221', 190, 190);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (3, 5290000, 143015, 6623, 1109, 1109, 14703, 550844976, 'VN', 0, '20141109044723', 192, 192);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (4, 10730000, 101933, 6623, 1123, 1123, 71502, 673771019, 'VD', 0, '20141123101501', 194, 194);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (5, 9570000, 154569, 6623, 1123, 1123, 73233, 673876144, 'SI', 3, '20141123103234', 197, 197);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (6, 3140000, 957013, 6623, 1123, 1123, 73748, 673907631, 'VC', 40, '20141123103749', 198, 198);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (7, 3190000, 207100, 6623, 1123, 1123, 73947, 673919565, 'VN', 0, '20141123103950', 199, 199);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (8, 5760000, 155856, 6623, 1123, 1123, 74334, 673942264, 'VN', 0, '20141123104336', 201, 201);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (9, 8720000, 570745, 6623, 1128, 1128, 231859, 722754960, 'VD', 0, '20141129021902', 203, 203);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (10, 5630000, 634928, 6623, 1128, 1128, 232142, 722771553, 'VN', 0, '20141129022150', 205, 205);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (11, 2940000, 154008, 6623, 1128, 1128, 232357, 722785026, 'SI', 3, '20141129022352', 206, 206);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (12, 8320000, 188532, 6623, 1128, 1128, 233554, 722856745, 'VC', 40, '20141129023600', 210, 210);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (13, 9450000, 114413, 6623, 1202, 1202, 141140, 754031556, 'VN', 0, '20141202171148', 211, 211);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (14, 6030000, 953715, 6623, 1205, 1205, 172020, 781083350, 'SI', 3, '20141205202021', 212, 212);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (15, 4950000, 111446, 6623, 1206, 1206, 81058, 786427100, 'VN', 0, '20141206110957', 215, 215);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (16, 4950000, 639264, 6623, 1206, 1206, 82234, 786497030, 'SI', 3, '20141206112243', 216, 216);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (17, 4950000, 174390, 6623, 1206, 1206, 82842, 786533863, 'VC', 40, '20141206112824', 217, 217);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (18, 4950000, 173608, 6623, 1206, 1206, 91203, 786794142, 'VD', 0, '20141206121209', 218, 218);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (19, 100, 408091, 27, 204, 204, 154848, 307575102, 'VD', 0, '20150204184905', 261, 261);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (20, 100, 597203, 8214, 204, 204, 213101, 309631139, 'VN', 0, '20150205003143', 264, 264);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (21, 100, 127387, 8214, 219, 219, 174925, 437897015, 'VN', 0, '20150219204917', 274, 274);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (22, 100, 336015, 8214, 219, 219, 184204, 438277851, 'VN', 0, '20150219215240', 278, 278);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (23, 100, 811174, 8214, 219, 219, 193211, 438513692, 'VN', 0, '20150219223151', 280, 280);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (24, 100, 614883, 27, 224, 224, 101327, 478421724, 'VD', 0, '20150224132333', 288, 288);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (25, 19113000, 790128, 570, 224, 224, 173434, 481003448, 'VC', 3, '20150224203346', 296, 296);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (26, 5999000, 40875, 9436, 307, 307, 144408, 575024414, 'VN', 0, '20150307174347', 331, 331);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (27, 5999000, 803471, 9012, 308, 308, 161935, 584236951, 'VD', 0, '20150308191923', 337, 337);
INSERT INTO "Webpay" (id, "TBK_MONTO", "TBK_CODIGO_AUTORIZACION", "TBK_FINAL_NUMERO_TARJETA", "TBK_FECHA_CONTABLE", "TBK_FECHA_TRANSACCION", "TBK_HORA_TRANSACCION", "TBK_ID_TRANSACCION", "TBK_TIPO_PAGO", "TBK_NUMERO_CUOTAS", "TBK_ID_SESION", "TBK_ORDEN_COMPRA", "ORDER_ID") VALUES (28, 6371000, 662730, 9016, 315, 315, 155123, 644546864, 'VD', 0, '20150315185055', 343, 343);


--
-- Name: Webpay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yichun
--

SELECT pg_catalog.setval('"Webpay_id_seq"', 28, true);


--
-- Name: Access_Token_pkey; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Access_Token"
    ADD CONSTRAINT "Access_Token_pkey" PRIMARY KEY (id);


--
-- Name: Brand_pkey; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Brand"
    ADD CONSTRAINT "Brand_pkey" PRIMARY KEY (id);


--
-- Name: City_pkey; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "City"
    ADD CONSTRAINT "City_pkey" PRIMARY KEY (id);


--
-- Name: Contact_Types_pkey; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Contact_Types"
    ADD CONSTRAINT "Contact_Types_pkey" PRIMARY KEY (id);


--
-- Name: Payment_Types_pkey; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Payment_Types"
    ADD CONSTRAINT "Payment_Types_pkey" PRIMARY KEY (id);


--
-- Name: Shipping_Provider_name_key; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Shipping_Provider"
    ADD CONSTRAINT "Shipping_Provider_name_key" UNIQUE (name);


--
-- Name: Shipping_Provider_pkey; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Shipping_Provider"
    ADD CONSTRAINT "Shipping_Provider_pkey" PRIMARY KEY (id);


--
-- Name: Shipping_pkey; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Shipping"
    ADD CONSTRAINT "Shipping_pkey" PRIMARY KEY (id);


--
-- Name: State_pkey; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "State"
    ADD CONSTRAINT "State_pkey" PRIMARY KEY (id);


--
-- Name: Tag_Product_pkey; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Tag_Product"
    ADD CONSTRAINT "Tag_Product_pkey" PRIMARY KEY (id);


--
-- Name: Tag_pkey; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Tag"
    ADD CONSTRAINT "Tag_pkey" PRIMARY KEY (id);


--
-- Name: Temp_Cart_pkey; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Temp_Cart"
    ADD CONSTRAINT "Temp_Cart_pkey" PRIMARY KEY (id);


--
-- Name: Votos_pkey; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Voto"
    ADD CONSTRAINT "Votos_pkey" PRIMARY KEY (id);


--
-- Name: Webpay_pkey; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Webpay"
    ADD CONSTRAINT "Webpay_pkey" PRIMARY KEY (id);


--
-- Name: category_pk; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Category"
    ADD CONSTRAINT category_pk PRIMARY KEY (id);


--
-- Name: cellar_pk; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Cellar"
    ADD CONSTRAINT cellar_pk PRIMARY KEY (id);


--
-- Name: contact_pk; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Contact"
    ADD CONSTRAINT contact_pk PRIMARY KEY (id);


--
-- Name: kardex_pk; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Kardex"
    ADD CONSTRAINT kardex_pk PRIMARY KEY (id);


--
-- Name: order_detail_pk; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Order_Detail"
    ADD CONSTRAINT order_detail_pk PRIMARY KEY (id);


--
-- Name: order_pk; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Order"
    ADD CONSTRAINT order_pk PRIMARY KEY (id);


--
-- Name: permission_pk; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Permission"
    ADD CONSTRAINT permission_pk PRIMARY KEY (id);


--
-- Name: product_pk; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "Product"
    ADD CONSTRAINT product_pk PRIMARY KEY (id);


--
-- Name: user_pk; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "User"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- Name: user_types_pk; Type: CONSTRAINT; Schema: public; Owner: yichun; Tablespace: 
--

ALTER TABLE ONLY "User_Types"
    ADD CONSTRAINT user_types_pk PRIMARY KEY (id);


--
-- Name: Order_billing_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Order"
    ADD CONSTRAINT "Order_billing_id_fkey" FOREIGN KEY (billing_id) REFERENCES "Contact"(id);


--
-- Name: Order_shipping_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Order"
    ADD CONSTRAINT "Order_shipping_id_fkey" FOREIGN KEY (shipping_id) REFERENCES "Contact"(id);


--
-- Name: Order_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Order"
    ADD CONSTRAINT "Order_user_id_fkey" FOREIGN KEY (user_id) REFERENCES "User"(id);


--
-- Name: TempCart_User; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Temp_Cart"
    ADD CONSTRAINT "TempCart_User" FOREIGN KEY (user_id) REFERENCES "User"(id) ON DELETE CASCADE;


--
-- Name: Temp_Cart_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Temp_Cart"
    ADD CONSTRAINT "Temp_Cart_product_id_fkey" FOREIGN KEY (product_id) REFERENCES "Product"(id);


--
-- Name: category_category; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Category"
    ADD CONSTRAINT category_category FOREIGN KEY (parent_id) REFERENCES "Category"(id);


--
-- Name: cellar_city; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Cellar"
    ADD CONSTRAINT cellar_city FOREIGN KEY (city_id) REFERENCES "City"(id);


--
-- Name: contact_contact_type; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Contact"
    ADD CONSTRAINT contact_contact_type FOREIGN KEY (type_id) REFERENCES "Contact_Types"(id);


--
-- Name: contact_user; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Contact"
    ADD CONSTRAINT contact_user FOREIGN KEY (user_id) REFERENCES "User"(id);


--
-- Name: kardex_cellar; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Kardex"
    ADD CONSTRAINT kardex_cellar FOREIGN KEY (cellar_id) REFERENCES "Cellar"(id);


--
-- Name: order_detail_order; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Order_Detail"
    ADD CONSTRAINT order_detail_order FOREIGN KEY (order_id) REFERENCES "Order"(id);


--
-- Name: order_detail_product; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Order_Detail"
    ADD CONSTRAINT order_detail_product FOREIGN KEY (product_id) REFERENCES "Product"(id);


--
-- Name: product_category; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "Product"
    ADD CONSTRAINT product_category FOREIGN KEY (category_id) REFERENCES "Category"(id);


--
-- Name: user_user_types; Type: FK CONSTRAINT; Schema: public; Owner: yichun
--

ALTER TABLE ONLY "User"
    ADD CONSTRAINT user_user_types FOREIGN KEY (type_id) REFERENCES "User_Types"(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

