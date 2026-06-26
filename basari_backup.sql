--
-- PostgreSQL database dump
--

\restrict WHr1cZxaVmwI8z9ZAPVCB9m5Cnx9JYlavC2Is1IRmttQ3COWPfVmJxAGxadwDqg

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admins_id_seq OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- Name: banners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.banners (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    image character varying(255) NOT NULL,
    link_url character varying(255),
    is_active boolean DEFAULT true NOT NULL,
    order_position integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    hero_video character varying(255)
);


ALTER TABLE public.banners OWNER TO postgres;

--
-- Name: banners_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.banners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.banners_id_seq OWNER TO postgres;

--
-- Name: banners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.banners_id_seq OWNED BY public.banners.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration bigint NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration bigint NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_items (
    id bigint NOT NULL,
    cart_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    price_at_time numeric(12,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    size character varying(255),
    color character varying(255)
);


ALTER TABLE public.cart_items OWNER TO postgres;

--
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_items_id_seq OWNER TO postgres;

--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carts_id_seq OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    image character varying(255),
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    name_en character varying(255)
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    product_id bigint,
    last_message_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    order_id bigint
);


ALTER TABLE public.conversations OWNER TO postgres;

--
-- Name: conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversations_id_seq OWNER TO postgres;

--
-- Name: conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversations_id_seq OWNED BY public.conversations.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id bigint NOT NULL,
    conversation_id bigint NOT NULL,
    body text NOT NULL,
    sender character varying(255) NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT messages_sender_check CHECK (((sender)::text = ANY ((ARRAY['user'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    type character varying(255) NOT NULL,
    user_id bigint,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    url character varying(255),
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT notifications_type_check CHECK (((type)::text = ANY ((ARRAY['user'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    product_name character varying(255) NOT NULL,
    product_price numeric(12,2) NOT NULL,
    quantity integer NOT NULL,
    subtotal numeric(12,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    size character varying(255),
    color character varying(255)
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    invoice_number character varying(255) NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    total_amount numeric(12,2) NOT NULL,
    shipping_name character varying(255) NOT NULL,
    shipping_address text NOT NULL,
    shipping_city character varying(255) NOT NULL,
    shipping_postal character varying(255) NOT NULL,
    phone character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    notes text,
    paid_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    courier character varying(255),
    courier_service character varying(255),
    shipping_cost integer DEFAULT 0 NOT NULL,
    tracking_number character varying(255),
    origin_city_id character varying(255),
    destination_city_id character varying(255),
    destination_district_id character varying(255),
    shipping_district character varying(255),
    biteship_order_id character varying(255),
    origin_postal_code character varying(255),
    destination_postal_code character varying(255),
    biteship_tracking_id character varying(255),
    shipping_type character varying(255) DEFAULT 'domestic'::character varying NOT NULL,
    destination_country character varying(255),
    destination_country_code character varying(5),
    intl_shipping_cost integer DEFAULT 0 NOT NULL,
    intl_tracking_number character varying(255),
    intl_courier character varying(255),
    preferred_currency character varying(3) DEFAULT 'IDR'::character varying NOT NULL,
    payment_ref character varying(255),
    payment_deadline timestamp(0) without time zone,
    CONSTRAINT orders_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'paid'::character varying, 'processing'::character varying, 'shipped'::character varying, 'done'::character varying, 'cancelled'::character varying, 'waiting_shipping_cost'::character varying])::text[])))
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: page_visits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.page_visits (
    id bigint NOT NULL,
    ip_address character varying(45),
    user_agent character varying(255),
    page character varying(255),
    user_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.page_visits OWNER TO postgres;

--
-- Name: page_visits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.page_visits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.page_visits_id_seq OWNER TO postgres;

--
-- Name: page_visits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.page_visits_id_seq OWNED BY public.page_visits.id;


--
-- Name: product_colors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_colors (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    hex_code character varying(7),
    image_index integer DEFAULT 0 NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    stock integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.product_colors OWNER TO postgres;

--
-- Name: product_colors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_colors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_colors_id_seq OWNER TO postgres;

--
-- Name: product_colors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_colors_id_seq OWNED BY public.product_colors.id;


--
-- Name: product_sizes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_sizes (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    size character varying(255) NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.product_sizes OWNER TO postgres;

--
-- Name: product_sizes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_sizes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_sizes_id_seq OWNER TO postgres;

--
-- Name: product_sizes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_sizes_id_seq OWNED BY public.product_sizes.id;


--
-- Name: product_views; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_views (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    ip_address character varying(45),
    user_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.product_views OWNER TO postgres;

--
-- Name: product_views_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_views_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_views_id_seq OWNER TO postgres;

--
-- Name: product_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_views_id_seq OWNED BY public.product_views.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    category_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    description text,
    price numeric(12,2) NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    images jsonb,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    thumbnail_index integer DEFAULT 0 NOT NULL,
    video character varying(255),
    length integer DEFAULT 30 NOT NULL,
    width integer DEFAULT 25 NOT NULL,
    height integer DEFAULT 5 NOT NULL,
    name_en character varying(255),
    description_en text,
    price_usd numeric(10,2),
    price_myr numeric(10,2)
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: COLUMN products.weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.products.weight IS 'dalam gram';


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    product_id bigint NOT NULL,
    order_id bigint NOT NULL,
    order_item_id bigint NOT NULL,
    rating smallint NOT NULL,
    comment text,
    admin_reply text,
    admin_replied_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_id_seq OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    id bigint NOT NULL,
    key character varying(255) NOT NULL,
    value text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.settings_id_seq OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    phone character varying(255),
    address text,
    city character varying(255),
    postal_code character varying(255),
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    locale character varying(5) DEFAULT 'id'::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- Name: banners id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banners ALTER COLUMN id SET DEFAULT nextval('public.banners_id_seq'::regclass);


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: conversations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations ALTER COLUMN id SET DEFAULT nextval('public.conversations_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: page_visits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page_visits ALTER COLUMN id SET DEFAULT nextval('public.page_visits_id_seq'::regclass);


--
-- Name: product_colors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_colors ALTER COLUMN id SET DEFAULT nextval('public.product_colors_id_seq'::regclass);


--
-- Name: product_sizes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_sizes ALTER COLUMN id SET DEFAULT nextval('public.product_sizes_id_seq'::regclass);


--
-- Name: product_views id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_views ALTER COLUMN id SET DEFAULT nextval('public.product_views_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admins (id, name, email, password, remember_token, created_at, updated_at) FROM stdin;
1	Super Admin	admin@basari.com	$2y$12$pTQ5U1kF.OgXB78dBZ2.oe557D7ek/WGy9oVfDb5WRHqVCZxeyUhO	\N	2026-05-29 11:10:36	2026-06-23 06:22:17
\.


--
-- Data for Name: banners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.banners (id, title, image, link_url, is_active, order_position, created_at, updated_at, hero_video) FROM stdin;
8	Basari.Id - Kelly Blouse	banners/hCpcVtFOuJTuO3e3OrOqCPnGI0HTkA4o1ARJo1yU.webp	\N	t	2	2026-06-08 13:35:02	2026-06-14 04:25:52	\N
9	Basari.id - Hara Tunik	banners/5eWTSTpIqFozSAE4GvDEmw7AZR5kNH1ENj1ncBUO.webp	\N	t	3	2026-06-08 13:35:36	2026-06-14 04:26:06	\N
6	Basari.id - Milly Blouse	banners/hV8E4Mx2QXyXEKwV7XFawndt0zePuxko8Jdwdjvx.png	\N	t	0	2026-06-08 13:33:08	2026-06-14 04:26:25	\N
7	Basari.id - Lumi Blouse	banners/LTk9ozxKkHBmLnP8xU3eXNVbLLQDCyn1xXmUd2vL.webp	\N	t	1	2026-06-08 13:34:15	2026-06-14 04:26:57	\N
11	Fashion Week	banners/KUJNyHB5gcXhMVH0pETevxov8prbI4s9Tcpgh05k.png	https://pin.it/rUwyxsTSx	t	0	2026-06-16 08:16:18	2026-06-19 06:14:40	\N
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
basari-cache-ac3478d69a3c81fa62e60f5c3696165a4e5e6ac4:timer	i:1782405315;	1782405315
basari-cache-ac3478d69a3c81fa62e60f5c3696165a4e5e6ac4	i:2;	1782405315
basari-cache-902ba3cda1883801594b6e1b452790cc53948fda:timer	i:1782405494;	1782405494
basari-cache-902ba3cda1883801594b6e1b452790cc53948fda	i:1;	1782405494
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_items (id, cart_id, product_id, quantity, price_at_time, created_at, updated_at, size, color) FROM stdin;
77	1	18	1	97000.00	2026-06-23 12:48:50	2026-06-23 12:48:50	ALL SIZE	\N
78	4	19	1	104000.00	2026-06-25 16:30:45	2026-06-25 16:32:06	ALL SIZE	Black
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (id, user_id, created_at, updated_at) FROM stdin;
1	1	2026-05-29 12:02:32	2026-05-29 12:02:32
4	7	2026-06-25 16:30:45	2026-06-25 16:30:45
5	5	2026-06-25 16:34:02	2026-06-25 16:34:02
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, slug, image, is_active, created_at, updated_at, name_en) FROM stdin;
7	Atasan Muslim Wanita	atasan-muslim-wanita	categories/lDtexqGnSS9wJp5p89HIAoTjD065L7BTrl92zZuE.webp	t	2026-06-09 07:59:41	2026-06-21 12:02:52	Muslim Women's Tops
1	Pakaian Luar	pakaian-luar	categories/IzOHHT8aTx6T8LrKRUwPZPCtgsHNTNKgXpleG40q.webp	t	2026-05-29 11:32:12	2026-06-21 12:03:32	Outwear
6	Sweater & Cardigan	sweater-cardigan	categories/EoEpobx94h0f3F2UbTUj79DXLocc6aKmCFZxLhFp.webp	t	2026-06-09 07:58:50	2026-06-21 12:04:01	Sweater & Cardigan
2	Atasan	atasan	categories/12O8VPRmP70MKfAUkXyMMkTMnlcpW1tuzHAV1D9P.png	t	2026-05-29 11:32:12	2026-06-21 12:04:10	Top
3	Celana	celana	categories/5qVn8z3YOF8x86P6wQ912i8Y0vy6x6RYQuIVCKB7.webp	t	2026-05-29 11:32:12	2026-06-21 12:04:20	Pants
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations (id, user_id, product_id, last_message_at, created_at, updated_at, order_id) FROM stdin;
12	5	19	2026-06-24 07:35:08	2026-06-24 07:34:44	2026-06-24 07:35:08	\N
13	7	21	2026-06-24 09:40:22	2026-06-24 09:39:04	2026-06-24 09:40:22	\N
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, conversation_id, body, sender, is_read, created_at, updated_at) FROM stdin;
22	12	test	user	t	2026-06-24 07:34:53	2026-06-24 07:34:59
23	12	test	admin	t	2026-06-24 07:35:08	2026-06-24 07:35:27
24	13	Halo mas	user	t	2026-06-24 09:39:10	2026-06-24 09:39:44
25	13	halo	admin	t	2026-06-24 09:39:49	2026-06-24 09:40:15
26	13	Nice mas	user	t	2026-06-24 09:40:22	2026-06-26 00:46:52
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	2026_05_29_105005_create_admins_table	1
2	2026_05_29_105006_create_users_table	1
3	2026_05_29_105007_create_banners_table	1
4	2026_05_29_105007_create_categories_table	1
5	2026_05_29_105007_create_products_table	1
6	2026_05_29_105008_create_carts_table	1
7	2026_05_29_105009_create_orders_table	1
8	2026_05_29_105010_create_cart_items_table	1
9	2026_05_29_105011_create_order_items_table	1
10	2026_05_29_111838_create_sessions_table	2
11	2026_05_30_044742_create_conversations_table	3
12	2026_05_30_044747_create_messages_table	3
13	2026_05_30_085731_create_product_sizes_table	4
14	2026_05_30_090535_add_size_to_cart_items_table	5
15	2026_06_01_133756_add_size_to_order_items_table	6
16	2026_06_01_160629_create_notifications_table	7
17	2026_06_02_030155_add_shipping_fields_to_orders_table	8
18	2026_06_02_041843_add_district_to_orders_table	9
19	2026_06_03_021251_add_biteship_fields_to_orders_table	10
20	2026_06_03_080528_add_biteship_tracking_id_to_orders_table	11
21	2026_06_04_140249_create_page_visits_table	12
22	2026_06_04_140251_create_product_views_table	12
23	2026_06_06_071654_create_reviews_table	13
24	2026_06_07_081941_create_product_colors_table	14
25	2026_06_08_083751_add_stock_to_product_colors_table	15
26	2026_06_08_115740_add_thumbnail_index_to_products_table	16
27	2026_06_09_054637_add_video_to_banners_table	17
28	2026_06_09_054857_create_settings_table	18
29	2026_06_09_103927_add_video_to_products_table	19
30	2026_06_10_095220_add_international_shipping_to_orders_table	20
31	2026_06_11_023506_add_intl_shipping_to_orders_table	21
32	2026_06_11_034654_add_waiting_shipping_cost_to_orders_status	22
33	2026_06_11_052245_add_dimensions_to_products_table	23
34	2026_06_15_064948_add_order_id_to_conversations_table	24
35	2026_06_15_070927_add_color_to_cart_items_table	25
36	2026_06_16_110258_add_translations_to_products_table	26
37	2026_06_19_034635_add_color_to_order_items_table	27
38	2026_06_19_040124_add_multi_currency_to_products_table	28
39	2026_06_19_074025_add_preferred_currency_to_orders_table	29
40	2026_06_19_094820_create_cache_table	30
41	2026_06_21_063657_add_xendit_invoice_id_to_orders_table	31
42	2026_06_21_115756_add_name_en_to_categories_table	32
43	2026_06_21_150208_rename_xendit_invoice_id_to_payment_ref_in_orders_table	33
44	2026_06_23_054744_add_payment_deadline_to_orders_table	34
45	2026_06_24_102643_add_locale_to_users_table	35
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, type, user_id, title, message, url, is_read, created_at, updated_at) FROM stdin;
271	user	5	Pesan dari Admin	test	http://localhost:8000/chat/12	f	2026-06-24 07:35:08	2026-06-24 07:35:08
272	user	7	Pesan dari Admin	halo	http://unstirred-speak-flammable.ngrok-free.dev/chat/13	t	2026-06-24 09:39:49	2026-06-24 09:46:31
273	user	5	Pesanan Berhasil Dibuat	Pesanan BSR-6VHNKQRV senilai Rp 112.000 berhasil dibuat.	http://localhost:8000/orders/61	f	2026-06-26 00:35:22	2026-06-26 00:35:22
274	admin	\N	Pesanan Baru Masuk	Pesanan baru BSR-6VHNKQRV dari Fahri senilai Rp 112.000.	http://localhost:8000/admin/orders/61	f	2026-06-26 00:35:22	2026-06-26 00:35:22
275	user	5	Pembayaran Dikonfirmasi	Pembayaran pesanan BSR-6VHNKQRV telah dikonfirmasi. Pesanan kamu sedang diproses.	http://unstirred-speak-flammable.ngrok-free.dev/orders/61	f	2026-06-26 00:45:35	2026-06-26 00:45:35
276	admin	\N	Pembayaran Diterima	Pembayaran pesanan BSR-6VHNKQRV dari Fahri telah berhasil.	http://unstirred-speak-flammable.ngrok-free.dev/admin/orders/61	f	2026-06-26 00:45:35	2026-06-26 00:45:35
277	user	5	Pesanan Diproses	Pesanan BSR-6VHNKQRV sedang diproses dan akan segera dikirim.	http://localhost:8000/orders/61	f	2026-06-26 00:47:14	2026-06-26 00:47:14
278	user	5	Status Pesanan Diperbarui	Pesanan kamu sedang diproses oleh penjual.	http://localhost:8000/orders/61	f	2026-06-26 01:36:33	2026-06-26 01:36:33
270	user	1	Status Pesanan Diperbarui	Pesanan kamu telah selesai. Terima kasih sudah berbelanja di Basari!	http://localhost:8000/orders/51	f	2026-06-24 04:04:59	2026-06-24 04:04:59
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, product_name, product_price, quantity, subtotal, created_at, updated_at, size, color) FROM stdin;
54	54	19	BASARI.ID - Atasan Blouse Cream,Coklat muda- Bahan Crinkle (2202) - Kanaya Blouse	104000.00	1	104000.00	2026-06-21 13:57:23	2026-06-21 13:57:23	ALL SIZE	Black
56	56	17	Basari.Id - Kelly Blouse - Atasan Wanita bahan Polo Linen - Blouse Putih - Blouse Lengan Karet	129000.00	1	129000.00	2026-06-21 14:13:03	2026-06-21 14:13:03	ALL SIZE	Mocca
58	58	19	BASARI.ID - Atasan Blouse Cream,Coklat muda- Bahan Crinkle (2202) - Kanaya Blouse	104000.00	1	104000.00	2026-06-21 15:12:56	2026-06-21 15:12:56	ALL SIZE	Black
59	59	19	BASARI.ID - Atasan Blouse Cream,Coklat muda- Bahan Crinkle (2202) - Kanaya Blouse	104000.00	1	104000.00	2026-06-23 05:55:30	2026-06-23 05:55:30	ALL SIZE	Black
60	60	14	BASARI.ID - Atasan Polos Wanita - Atasan Bahan Knit Halus - Sweater Rajut - Sweater Polos Rajut	174000.00	1	174000.00	2026-06-23 09:17:32	2026-06-23 09:17:32	S	Hitam
61	61	19	BASARI.ID - Atasan Blouse Cream,Coklat muda- Bahan Crinkle (2202) - Kanaya Blouse	104000.00	1	104000.00	2026-06-26 00:35:22	2026-06-26 00:35:22	ALL SIZE	Black
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, user_id, invoice_number, status, total_amount, shipping_name, shipping_address, shipping_city, shipping_postal, phone, email, notes, paid_at, created_at, updated_at, courier, courier_service, shipping_cost, tracking_number, origin_city_id, destination_city_id, destination_district_id, shipping_district, biteship_order_id, origin_postal_code, destination_postal_code, biteship_tracking_id, shipping_type, destination_country, destination_country_code, intl_shipping_cost, intl_tracking_number, intl_courier, preferred_currency, payment_ref, payment_deadline) FROM stdin;
59	1	BSR-SDRCDHCJ	cancelled	112000.00	payy	Jl ABC no 1	Bojongloa Kidul, Bandung, Jawa Barat. 40239	40239	086637886711	pay@gmail.com	\N	\N	2026-06-23 05:55:30	2026-06-23 06:02:01	jne	reg	8000	\N	\N	\N	\N	\N	\N	40234	40239	\N	domestic	\N	\N	0	\N	\N	IDR	\N	2026-06-23 05:56:42
56	1	BSR-1UBZLPMJ	paid	329000.00	payy	Jl ABC no 1	Malaysia	50200	086637886711	pay@gmail.com	\N	2026-06-21 15:10:04	2026-06-21 14:13:03	2026-06-21 15:10:04	\N	\N	200000	\N	\N	\N	\N	\N	\N	40234	50200	\N	international	Malaysia	MY	200000	\N	Lion Parcel	MYR	2X794573A5871723M	\N
61	5	BSR-6VHNKQRV	processing	112000.00	Fahri	jl mawar 123	Bojongloa Kidul, Bandung, Jawa Barat. 40237	40237	086637886711	fahri.fazariadi@gmail.com	\N	2026-06-26 00:45:35	2026-06-26 00:35:22	2026-06-26 01:36:33	jne	reg	8000	WYB-1782434833923	\N	\N	\N	\N	6a3dcc118b572171413566c9	40234	40237	oMB8Zn36j0JnAIXVZyuh0tgG	domestic	\N	\N	0	\N	\N	IDR	1515937d-ea63-4a96-9060-a072cc601663	2026-06-26 01:35:22
54	1	BSR-OHGTN1EK	paid	604000.00	payy	Jl ABC no 1	Inggris	50200	086637886711	pay@gmail.com	\N	2026-06-21 14:04:23	2026-06-21 13:57:23	2026-06-21 14:04:23	\N	\N	500000	\N	\N	\N	\N	\N	\N	40234	50200	\N	international	Inggris	GB	500000	\N	Lion Parcel	USD	4R23007775284630D	\N
60	1	BSR-CRECIMO1	done	181000.00	payy	Jl ABC no 1	Bojongloa Kidul, Bandung, Jawa Barat. 40234	40234	086637886711	fahri.fazariadi@gmail.com	\N	2026-06-23 09:18:23	2026-06-23 09:17:32	2026-06-23 09:25:59	jnt	ez	7000	WYB-1782206391785	\N	\N	\N	\N	6a3a4fb7d10bc93b2aee158c	40234	40234	zS3kJcU0YWN8VxUdHh0k8VXD	domestic	\N	\N	0	\N	\N	IDR	\N	2026-06-23 10:17:32
58	1	BSR-VWAGOJN9	done	604000.00	payy	Jl ABC no 1	Inggris	50200	086637886711	pay@gmail.com	\N	2026-06-21 15:14:05	2026-06-21 15:12:56	2026-06-23 05:42:52	\N	\N	500000	\N	\N	\N	\N	\N	\N	40234	50200	\N	international	Inggris	GB	500000	\N	Lion Parcel	USD	\N	\N
\.


--
-- Data for Name: page_visits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.page_visits (id, ip_address, user_agent, page, user_id, created_at, updated_at) FROM stdin;
1	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:07:55	2026-06-04 14:07:55
2	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:11:17	2026-06-04 14:11:17
3	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:11:22	2026-06-04 14:11:22
4	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:11:29	2026-06-04 14:11:29
5	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:12:25	2026-06-04 14:12:25
6	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:13:44	2026-06-04 14:13:44
7	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:13:48	2026-06-04 14:13:48
8	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:14:25	2026-06-04 14:14:25
9	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:14:32	2026-06-04 14:14:32
10	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:16:49	2026-06-04 14:16:49
11	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:17:02	2026-06-04 14:17:02
12	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:50:28	2026-06-04 14:50:28
13	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:51:01	2026-06-04 14:51:01
14	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-04 14:52:22	2026-06-04 14:52:22
15	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-06 06:57:32	2026-06-06 06:57:32
16	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-06 06:57:39	2026-06-06 06:57:39
17	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-06 06:57:39	2026-06-06 06:57:39
18	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-06 06:59:02	2026-06-06 06:59:02
19	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	register	\N	2026-06-06 06:59:14	2026-06-06 06:59:14
20	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 06:59:32	2026-06-06 06:59:32
21	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:18:03	2026-06-06 07:18:03
22	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:18:09	2026-06-06 07:18:09
23	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:18:40	2026-06-06 07:18:40
24	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:18:49	2026-06-06 07:18:49
25	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:19:01	2026-06-06 07:19:01
26	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:19:05	2026-06-06 07:19:05
27	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:21:11	2026-06-06 07:21:11
28	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:21:53	2026-06-06 07:21:53
29	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:22:17	2026-06-06 07:22:17
30	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:22:28	2026-06-06 07:22:28
31	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:24:38	2026-06-06 07:24:38
32	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:25:35	2026-06-06 07:25:35
33	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:25:39	2026-06-06 07:25:39
34	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:26:03	2026-06-06 07:26:03
35	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:26:11	2026-06-06 07:26:11
36	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:27:15	2026-06-06 07:27:15
37	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:27:25	2026-06-06 07:27:25
38	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:28:01	2026-06-06 07:28:01
39	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:28:08	2026-06-06 07:28:08
40	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:29:32	2026-06-06 07:29:32
41	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	2	2026-06-06 07:29:56	2026-06-06 07:29:56
42	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	2	2026-06-06 07:30:00	2026-06-06 07:30:00
43	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 07:30:01	2026-06-06 07:30:01
44	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	2	2026-06-06 07:30:04	2026-06-06 07:30:04
45	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 07:30:09	2026-06-06 07:30:09
46	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	2	2026-06-06 07:30:11	2026-06-06 07:30:11
47	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 07:30:28	2026-06-06 07:30:28
48	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 07:30:31	2026-06-06 07:30:31
49	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 07:30:32	2026-06-06 07:30:32
50	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:31:06	2026-06-06 07:31:06
51	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	payment/27	2	2026-06-06 07:31:14	2026-06-06 07:31:14
52	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	2	2026-06-06 07:32:11	2026-06-06 07:32:11
53	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	2	2026-06-06 07:32:14	2026-06-06 07:32:14
54	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:32:30	2026-06-06 07:32:30
55	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:34:24	2026-06-06 07:34:24
56	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:34:29	2026-06-06 07:34:29
57	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:34:36	2026-06-06 07:34:36
58	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:34:51	2026-06-06 07:34:51
59	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:35:08	2026-06-06 07:35:08
60	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:35:12	2026-06-06 07:35:12
61	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	2	2026-06-06 07:35:15	2026-06-06 07:35:15
62	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:35:17	2026-06-06 07:35:17
63	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:35:54	2026-06-06 07:35:54
64	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:36:04	2026-06-06 07:36:04
65	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:36:35	2026-06-06 07:36:35
66	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:36:41	2026-06-06 07:36:41
67	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:37:22	2026-06-06 07:37:22
68	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	login	\N	2026-06-06 07:38:30	2026-06-06 07:38:30
69	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-06 07:38:38	2026-06-06 07:38:38
70	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	1	2026-06-06 07:38:40	2026-06-06 07:38:40
71	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/26	1	2026-06-06 07:38:42	2026-06-06 07:38:42
72	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/s06CZ0cRhs0Gje9ofViTNfI0	1	2026-06-06 07:38:42	2026-06-06 07:38:42
73	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/26	1	2026-06-06 07:38:57	2026-06-06 07:38:57
74	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/s06CZ0cRhs0Gje9ofViTNfI0	1	2026-06-06 07:38:57	2026-06-06 07:38:57
75	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-06 07:39:38	2026-06-06 07:39:38
76	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	1	2026-06-06 07:39:41	2026-06-06 07:39:41
77	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/outer-blazer-hitam-fofG	1	2026-06-06 07:39:57	2026-06-06 07:39:57
78	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-06 07:40:22	2026-06-06 07:40:22
79	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/outer-blazer-hitam-fofG	1	2026-06-06 07:41:02	2026-06-06 07:41:02
80	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/outer-blazer-hitam-fofG	1	2026-06-06 07:41:05	2026-06-06 07:41:05
81	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/outer-blazer-hitam-fofG	1	2026-06-06 07:41:24	2026-06-06 07:41:24
82	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/outer-blazer-hitam-fofG	1	2026-06-06 07:41:28	2026-06-06 07:41:28
83	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/outer-blazer-hitam-fofG	1	2026-06-06 07:41:30	2026-06-06 07:41:30
84	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/outer-blazer-hitam-fofG	1	2026-06-06 07:42:20	2026-06-06 07:42:20
85	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	1	2026-06-06 07:42:22	2026-06-06 07:42:22
86	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	1	2026-06-06 07:42:43	2026-06-06 07:42:43
87	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	1	2026-06-06 07:42:51	2026-06-06 07:42:51
88	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/24	1	2026-06-06 07:42:54	2026-06-06 07:42:54
89	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/24	1	2026-06-06 07:43:03	2026-06-06 07:43:03
90	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/24	1	2026-06-06 07:43:12	2026-06-06 07:43:12
91	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/24	1	2026-06-06 07:43:26	2026-06-06 07:43:26
92	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/23	1	2026-06-06 07:43:28	2026-06-06 07:43:28
93	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/26	1	2026-06-06 07:43:32	2026-06-06 07:43:32
94	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/s06CZ0cRhs0Gje9ofViTNfI0	1	2026-06-06 07:43:32	2026-06-06 07:43:32
95	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/22	1	2026-06-06 07:43:36	2026-06-06 07:43:36
96	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	1	2026-06-06 07:44:05	2026-06-06 07:44:05
97	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/24	1	2026-06-06 07:44:07	2026-06-06 07:44:07
98	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/24	1	2026-06-06 07:46:16	2026-06-06 07:46:16
99	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/24	1	2026-06-06 07:46:20	2026-06-06 07:46:20
100	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/26	1	2026-06-06 07:46:23	2026-06-06 07:46:23
101	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/s06CZ0cRhs0Gje9ofViTNfI0	1	2026-06-06 07:46:24	2026-06-06 07:46:24
102	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/24	1	2026-06-06 07:46:31	2026-06-06 07:46:31
103	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/24	1	2026-06-06 07:46:47	2026-06-06 07:46:47
104	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	1	2026-06-06 07:47:03	2026-06-06 07:47:03
105	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/23	1	2026-06-06 07:47:06	2026-06-06 07:47:06
106	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/23	1	2026-06-06 07:47:13	2026-06-06 07:47:13
107	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/23	1	2026-06-06 07:49:59	2026-06-06 07:49:59
108	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	1	2026-06-06 07:50:05	2026-06-06 07:50:05
109	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/22	1	2026-06-06 07:50:08	2026-06-06 07:50:08
110	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/22	1	2026-06-06 07:51:08	2026-06-06 07:51:08
111	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/22	1	2026-06-06 07:51:31	2026-06-06 07:51:31
112	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-06 07:51:36	2026-06-06 07:51:36
113	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	1	2026-06-06 07:51:39	2026-06-06 07:51:39
114	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/baju-kaos-basic-putih-1BTD	1	2026-06-06 07:51:51	2026-06-06 07:51:51
115	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/baju-kaos-basic-putih-1BTD	1	2026-06-06 07:52:24	2026-06-06 07:52:24
116	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	1	2026-06-06 07:52:29	2026-06-06 07:52:29
117	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	1	2026-06-06 07:52:31	2026-06-06 07:52:31
118	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	1	2026-06-06 07:52:33	2026-06-06 07:52:33
119	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-06 07:52:45	2026-06-06 07:52:45
120	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/outer	1	2026-06-06 07:52:56	2026-06-06 07:52:56
121	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	login	\N	2026-06-06 07:53:34	2026-06-06 07:53:34
122	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 07:53:42	2026-06-06 07:53:42
123	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	2	2026-06-06 07:56:26	2026-06-06 07:56:26
124	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:56:28	2026-06-06 07:56:28
125	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 07:59:27	2026-06-06 07:59:27
126	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 07:59:28	2026-06-06 07:59:28
127	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:01:29	2026-06-06 08:01:29
128	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:01:29	2026-06-06 08:01:29
129	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:06:34	2026-06-06 08:06:34
130	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:06:35	2026-06-06 08:06:35
131	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:07:20	2026-06-06 08:07:20
132	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:07:21	2026-06-06 08:07:21
133	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:07:34	2026-06-06 08:07:34
134	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:07:35	2026-06-06 08:07:35
135	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:08:11	2026-06-06 08:08:11
136	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:08:24	2026-06-06 08:08:24
137	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:08:26	2026-06-06 08:08:26
138	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:08:27	2026-06-06 08:08:27
139	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:10:32	2026-06-06 08:10:32
140	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:10:33	2026-06-06 08:10:33
141	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:11:41	2026-06-06 08:11:41
142	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:11:42	2026-06-06 08:11:42
143	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:12:18	2026-06-06 08:12:18
144	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:12:20	2026-06-06 08:12:20
145	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:12:35	2026-06-06 08:12:35
146	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:12:36	2026-06-06 08:12:36
147	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:12:48	2026-06-06 08:12:48
148	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:12:48	2026-06-06 08:12:48
149	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:14:04	2026-06-06 08:14:04
150	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:14:06	2026-06-06 08:14:06
151	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:14:07	2026-06-06 08:14:07
152	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:21:35	2026-06-06 08:21:35
153	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:21:37	2026-06-06 08:21:37
154	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:21:41	2026-06-06 08:21:41
155	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:21:42	2026-06-06 08:21:42
156	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:21:49	2026-06-06 08:21:49
157	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:21:51	2026-06-06 08:21:51
158	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:22:04	2026-06-06 08:22:04
159	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:22:06	2026-06-06 08:22:06
160	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:22:09	2026-06-06 08:22:09
161	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:22:10	2026-06-06 08:22:10
162	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:22:16	2026-06-06 08:22:16
163	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:22:17	2026-06-06 08:22:17
164	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:22:40	2026-06-06 08:22:40
165	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	2	2026-06-06 08:22:48	2026-06-06 08:22:48
166	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	chat	2	2026-06-06 08:22:53	2026-06-06 08:22:53
167	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	2	2026-06-06 08:22:53	2026-06-06 08:22:53
168	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:22:55	2026-06-06 08:22:55
169	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:22:58	2026-06-06 08:22:58
170	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:24:19	2026-06-06 08:24:19
171	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:24:21	2026-06-06 08:24:21
172	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:25:19	2026-06-06 08:25:19
173	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:25:20	2026-06-06 08:25:20
174	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:25:21	2026-06-06 08:25:21
175	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:26:50	2026-06-06 08:26:50
176	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:26:51	2026-06-06 08:26:51
177	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:26:52	2026-06-06 08:26:52
178	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:26:58	2026-06-06 08:26:58
179	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:27:05	2026-06-06 08:27:05
180	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:27:12	2026-06-06 08:27:12
181	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/27	2	2026-06-06 08:27:35	2026-06-06 08:27:35
182	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/sAYMoGblsj24ahaMjaa0FgfC	2	2026-06-06 08:27:35	2026-06-06 08:27:35
183	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	2	2026-06-06 08:27:38	2026-06-06 08:27:38
184	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 08:27:39	2026-06-06 08:27:39
185	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/celana-kulot-abu-x0zS	2	2026-06-06 08:27:44	2026-06-06 08:27:44
186	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/celana-kulot-abu-x0zS	2	2026-06-06 08:27:47	2026-06-06 08:27:47
187	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 08:27:50	2026-06-06 08:27:50
188	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	2	2026-06-06 08:27:52	2026-06-06 08:27:52
189	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	profile	2	2026-06-06 08:27:57	2026-06-06 08:27:57
190	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	profile	2	2026-06-06 08:28:31	2026-06-06 08:28:31
191	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 08:28:41	2026-06-06 08:28:41
192	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 08:28:42	2026-06-06 08:28:42
193	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	2	2026-06-06 08:28:44	2026-06-06 08:28:44
194	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 08:29:02	2026-06-06 08:29:02
195	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 08:29:03	2026-06-06 08:29:03
196	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 08:29:06	2026-06-06 08:29:06
197	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 08:29:07	2026-06-06 08:29:07
198	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 08:29:09	2026-06-06 08:29:09
199	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 08:29:10	2026-06-06 08:29:10
200	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 08:29:11	2026-06-06 08:29:11
201	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 08:29:11	2026-06-06 08:29:11
202	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/28	2	2026-06-06 08:29:23	2026-06-06 08:29:23
203	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	payment/28	2	2026-06-06 08:29:26	2026-06-06 08:29:26
204	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/28	2	2026-06-06 08:33:09	2026-06-06 08:33:09
205	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/28	2	2026-06-06 08:33:43	2026-06-06 08:33:43
206	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/28	2	2026-06-06 08:37:47	2026-06-06 08:37:47
207	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/28	2	2026-06-06 08:38:00	2026-06-06 08:38:00
208	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/28	2	2026-06-06 08:38:03	2026-06-06 08:38:03
209	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/28	2	2026-06-06 08:43:20	2026-06-06 08:43:20
210	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/28	2	2026-06-06 08:43:27	2026-06-06 08:43:27
211	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/28	2	2026-06-06 08:43:53	2026-06-06 08:43:53
212	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/28	2	2026-06-06 08:44:16	2026-06-06 08:44:16
213	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 08:44:16	2026-06-06 08:44:16
214	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 08:44:22	2026-06-06 08:44:22
215	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/28	2	2026-06-06 08:45:46	2026-06-06 08:45:46
216	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 08:45:47	2026-06-06 08:45:47
217	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 08:45:48	2026-06-06 08:45:48
218	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/28	2	2026-06-06 08:46:08	2026-06-06 08:46:08
219	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 08:46:10	2026-06-06 08:46:10
220	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 08:46:11	2026-06-06 08:46:11
221	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 08:46:14	2026-06-06 08:46:14
222	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/28	2	2026-06-06 08:46:49	2026-06-06 08:46:49
223	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 08:46:50	2026-06-06 08:46:50
224	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 08:46:51	2026-06-06 08:46:51
225	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 08:46:52	2026-06-06 08:46:52
226	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 08:47:04	2026-06-06 08:47:04
227	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/outer-blazer-hitam-fofG	2	2026-06-06 08:47:06	2026-06-06 08:47:06
228	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/outer-blazer-hitam-fofG	2	2026-06-06 08:47:09	2026-06-06 08:47:09
229	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 08:47:10	2026-06-06 08:47:10
230	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	2	2026-06-06 08:47:47	2026-06-06 08:47:47
231	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 08:47:54	2026-06-06 08:47:54
232	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 08:48:04	2026-06-06 08:48:04
233	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	payment/29	2	2026-06-06 08:48:07	2026-06-06 08:48:07
234	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 08:48:36	2026-06-06 08:48:36
235	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	2	2026-06-06 08:48:40	2026-06-06 08:48:40
236	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 08:48:42	2026-06-06 08:48:42
237	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 08:49:11	2026-06-06 08:49:11
238	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 08:49:20	2026-06-06 08:49:20
239	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 08:51:33	2026-06-06 08:51:33
240	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 08:52:00	2026-06-06 08:52:00
241	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 08:52:10	2026-06-06 08:52:10
242	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 08:55:15	2026-06-06 08:55:15
243	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/48QQtTHiWa7LRymTAcuzBCLK	2	2026-06-06 08:55:19	2026-06-06 08:55:19
244	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 08:55:25	2026-06-06 08:55:25
245	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/48QQtTHiWa7LRymTAcuzBCLK	2	2026-06-06 08:55:26	2026-06-06 08:55:26
246	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/48QQtTHiWa7LRymTAcuzBCLK	2	2026-06-06 10:44:48	2026-06-06 10:44:48
247	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 10:44:54	2026-06-06 10:44:54
248	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 10:45:40	2026-06-06 10:45:40
249	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 10:45:46	2026-06-06 10:45:46
250	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 10:45:51	2026-06-06 10:45:51
251	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/48QQtTHiWa7LRymTAcuzBCLK	2	2026-06-06 10:45:52	2026-06-06 10:45:52
252	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 10:46:16	2026-06-06 10:46:16
253	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 10:46:30	2026-06-06 10:46:30
254	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 10:46:33	2026-06-06 10:46:33
255	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 10:46:47	2026-06-06 10:46:47
256	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 10:47:10	2026-06-06 10:47:10
257	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 10:48:20	2026-06-06 10:48:20
258	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 10:48:29	2026-06-06 10:48:29
259	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/48QQtTHiWa7LRymTAcuzBCLK	2	2026-06-06 10:48:29	2026-06-06 10:48:29
260	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 10:48:58	2026-06-06 10:48:58
261	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/48QQtTHiWa7LRymTAcuzBCLK	2	2026-06-06 10:48:58	2026-06-06 10:48:58
262	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 10:50:14	2026-06-06 10:50:14
263	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/48QQtTHiWa7LRymTAcuzBCLK	2	2026-06-06 10:50:14	2026-06-06 10:50:14
264	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/29	2	2026-06-06 10:50:22	2026-06-06 10:50:22
265	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/48QQtTHiWa7LRymTAcuzBCLK	2	2026-06-06 10:50:23	2026-06-06 10:50:23
266	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 10:50:24	2026-06-06 10:50:24
267	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 10:50:25	2026-06-06 10:50:25
268	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/48QQtTHiWa7LRymTAcuzBCLK	2	2026-06-06 10:50:41	2026-06-06 10:50:41
269	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/48QQtTHiWa7LRymTAcuzBCLK	2	2026-06-06 10:50:47	2026-06-06 10:50:47
270	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:07:15	2026-06-06 11:07:15
271	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:07:18	2026-06-06 11:07:18
272	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:08:13	2026-06-06 11:08:13
273	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:08:41	2026-06-06 11:08:41
274	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:09:18	2026-06-06 11:09:18
275	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:09:46	2026-06-06 11:09:46
276	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:10:17	2026-06-06 11:10:17
277	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:10:33	2026-06-06 11:10:33
278	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:14:54	2026-06-06 11:14:54
279	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:15:09	2026-06-06 11:15:09
280	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:15:24	2026-06-06 11:15:24
281	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:15:34	2026-06-06 11:15:34
282	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:16:47	2026-06-06 11:16:47
283	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:18:36	2026-06-06 11:18:36
284	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:40:43	2026-06-06 11:40:43
285	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:42:11	2026-06-06 11:42:11
286	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:42:36	2026-06-06 11:42:36
287	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:43:07	2026-06-06 11:43:07
288	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:43:28	2026-06-06 11:43:28
289	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:44:25	2026-06-06 11:44:25
290	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:44:41	2026-06-06 11:44:41
291	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:45:04	2026-06-06 11:45:04
292	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:45:12	2026-06-06 11:45:12
293	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:45:21	2026-06-06 11:45:21
294	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:45:41	2026-06-06 11:45:41
295	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:46:37	2026-06-06 11:46:37
296	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:47:22	2026-06-06 11:47:22
297	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:50:13	2026-06-06 11:50:13
298	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/outer-blazer-hitam-fofG	2	2026-06-06 11:51:26	2026-06-06 11:51:26
299	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 11:52:49	2026-06-06 11:52:49
300	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:11:36	2026-06-06 12:11:36
301	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:12:46	2026-06-06 12:12:46
302	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:12:58	2026-06-06 12:12:58
303	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:14:13	2026-06-06 12:14:13
304	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 12:18:47	2026-06-06 12:18:47
305	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:18:47	2026-06-06 12:18:47
306	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 12:18:49	2026-06-06 12:18:49
307	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:18:49	2026-06-06 12:18:49
308	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 12:18:52	2026-06-06 12:18:52
309	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:18:53	2026-06-06 12:18:53
310	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 12:18:55	2026-06-06 12:18:55
311	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:18:55	2026-06-06 12:18:55
312	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 12:18:57	2026-06-06 12:18:57
313	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:18:57	2026-06-06 12:18:57
314	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 12:18:58	2026-06-06 12:18:58
315	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:18:59	2026-06-06 12:18:59
316	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 12:19:00	2026-06-06 12:19:00
317	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 12:19:00	2026-06-06 12:19:00
318	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 12:19:01	2026-06-06 12:19:01
319	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 12:19:01	2026-06-06 12:19:01
320	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 12:19:01	2026-06-06 12:19:01
321	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:19:02	2026-06-06 12:19:02
322	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:23:32	2026-06-06 12:23:32
323	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:24:03	2026-06-06 12:24:03
324	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:24:14	2026-06-06 12:24:14
325	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:24:16	2026-06-06 12:24:16
326	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 12:24:22	2026-06-06 12:24:22
327	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:24:22	2026-06-06 12:24:22
328	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 12:24:25	2026-06-06 12:24:25
329	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:24:25	2026-06-06 12:24:25
330	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 12:24:28	2026-06-06 12:24:28
331	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 12:24:30	2026-06-06 12:24:30
332	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 12:24:31	2026-06-06 12:24:31
333	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 12:24:33	2026-06-06 12:24:33
334	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 12:24:33	2026-06-06 12:24:33
335	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:24:54	2026-06-06 12:24:54
336	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 12:24:57	2026-06-06 12:24:57
337	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:24:57	2026-06-06 12:24:57
338	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 12:25:04	2026-06-06 12:25:04
339	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:25:04	2026-06-06 12:25:04
340	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 12:25:06	2026-06-06 12:25:06
341	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:25:06	2026-06-06 12:25:06
342	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 12:26:03	2026-06-06 12:26:03
343	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 12:26:06	2026-06-06 12:26:06
344	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 12:26:09	2026-06-06 12:26:09
345	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 12:26:09	2026-06-06 12:26:09
346	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 12:26:12	2026-06-06 12:26:12
347	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 12:26:12	2026-06-06 12:26:12
348	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 12:47:12	2026-06-06 12:47:12
349	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/celana-kulot-abu-x0zS	2	2026-06-06 12:47:31	2026-06-06 12:47:31
350	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/celana-kulot-abu-x0zS	2	2026-06-06 12:47:58	2026-06-06 12:47:58
351	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/celana-kulot-abu-x0zS	2	2026-06-06 12:59:00	2026-06-06 12:59:00
352	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 13:06:18	2026-06-06 13:06:18
353	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/celana-kulot-abu-x0zS	2	2026-06-06 13:06:18	2026-06-06 13:06:18
354	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 13:06:20	2026-06-06 13:06:20
355	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/celana-kulot-abu-x0zS	2	2026-06-06 13:06:20	2026-06-06 13:06:20
356	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 13:06:21	2026-06-06 13:06:21
357	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/celana-kulot-abu-x0zS	2	2026-06-06 13:06:22	2026-06-06 13:06:22
358	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:06:25	2026-06-06 13:06:25
359	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 13:06:27	2026-06-06 13:06:27
360	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:06:27	2026-06-06 13:06:27
361	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 13:06:29	2026-06-06 13:06:29
362	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:06:29	2026-06-06 13:06:29
363	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 13:06:39	2026-06-06 13:06:39
364	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:06:39	2026-06-06 13:06:39
365	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:08:38	2026-06-06 13:08:38
366	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:10:44	2026-06-06 13:10:44
367	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:11:03	2026-06-06 13:11:03
368	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:11:12	2026-06-06 13:11:12
369	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:11:35	2026-06-06 13:11:35
370	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:11:58	2026-06-06 13:11:58
371	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:12:29	2026-06-06 13:12:29
372	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:12:41	2026-06-06 13:12:41
373	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:13:31	2026-06-06 13:13:31
374	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:14:10	2026-06-06 13:14:10
375	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:14:15	2026-06-06 13:14:15
376	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:14:31	2026-06-06 13:14:31
377	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:14:44	2026-06-06 13:14:44
378	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:14:50	2026-06-06 13:14:50
379	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:15:02	2026-06-06 13:15:02
380	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 13:15:07	2026-06-06 13:15:07
381	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:15:07	2026-06-06 13:15:07
382	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 13:15:10	2026-06-06 13:15:10
383	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:15:10	2026-06-06 13:15:10
384	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:17:05	2026-06-06 13:17:05
385	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:17:08	2026-06-06 13:17:08
386	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:22:57	2026-06-06 13:22:57
387	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 13:23:22	2026-06-06 13:23:22
388	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:23:22	2026-06-06 13:23:22
389	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 13:34:57	2026-06-06 13:34:57
390	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:22:01	2026-06-06 14:22:01
391	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:29:18	2026-06-06 14:29:18
392	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 14:29:27	2026-06-06 14:29:27
393	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:29:27	2026-06-06 14:29:27
394	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 14:29:29	2026-06-06 14:29:29
395	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:29:29	2026-06-06 14:29:29
396	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 14:29:34	2026-06-06 14:29:34
397	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:29:34	2026-06-06 14:29:34
398	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 14:29:38	2026-06-06 14:29:38
399	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:29:39	2026-06-06 14:29:39
400	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 14:34:35	2026-06-06 14:34:35
401	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:34:35	2026-06-06 14:34:35
402	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:39:41	2026-06-06 14:39:41
403	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 14:39:47	2026-06-06 14:39:47
404	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:39:48	2026-06-06 14:39:48
405	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 14:39:50	2026-06-06 14:39:50
406	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:39:50	2026-06-06 14:39:50
407	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 14:40:17	2026-06-06 14:40:17
408	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:40:18	2026-06-06 14:40:18
409	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:42:06	2026-06-06 14:42:06
410	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:42:07	2026-06-06 14:42:07
411	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:42:20	2026-06-06 14:42:20
412	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:42:21	2026-06-06 14:42:21
413	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 14:42:32	2026-06-06 14:42:32
414	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:42:33	2026-06-06 14:42:33
415	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 14:42:43	2026-06-06 14:42:43
416	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:42:43	2026-06-06 14:42:43
417	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 14:42:59	2026-06-06 14:42:59
418	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:42:59	2026-06-06 14:42:59
419	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	2	2026-06-06 14:52:21	2026-06-06 14:52:21
420	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	2	2026-06-06 14:52:25	2026-06-06 14:52:25
421	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	2	2026-06-06 14:52:26	2026-06-06 14:52:26
422	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	2	2026-06-06 14:52:30	2026-06-06 14:52:30
423	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	2	2026-06-06 14:52:30	2026-06-06 14:52:30
424	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	2	2026-06-06 14:56:27	2026-06-06 14:56:27
425	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	2	2026-06-06 14:56:47	2026-06-06 14:56:47
426	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/baju-kaos-basic-putih-1BTD	2	2026-06-06 14:56:53	2026-06-06 14:56:53
427	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/baju-kaos-basic-putih-1BTD	2	2026-06-06 14:57:00	2026-06-06 14:57:00
428	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	2	2026-06-06 14:57:03	2026-06-06 14:57:03
429	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	2	2026-06-06 14:57:05	2026-06-06 14:57:05
430	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 14:57:11	2026-06-06 14:57:11
431	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	2	2026-06-06 14:57:12	2026-06-06 14:57:12
432	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/30	2	2026-06-06 14:58:32	2026-06-06 14:58:32
433	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	payment/30	2	2026-06-06 14:58:46	2026-06-06 14:58:46
434	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/30	2	2026-06-06 14:59:35	2026-06-06 14:59:35
435	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 14:59:48	2026-06-06 14:59:48
436	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:01:48	2026-06-06 15:01:48
437	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:02:07	2026-06-06 15:02:07
438	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/30	2	2026-06-06 15:03:02	2026-06-06 15:03:02
439	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:03:03	2026-06-06 15:03:03
440	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/30	2	2026-06-06 15:12:23	2026-06-06 15:12:23
441	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:12:24	2026-06-06 15:12:24
442	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:12:26	2026-06-06 15:12:26
443	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/30	2	2026-06-06 15:14:02	2026-06-06 15:14:02
444	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:14:06	2026-06-06 15:14:06
445	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/30	2	2026-06-06 15:14:16	2026-06-06 15:14:16
446	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:14:17	2026-06-06 15:14:17
447	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:14:19	2026-06-06 15:14:19
448	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:14:33	2026-06-06 15:14:33
449	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:14:38	2026-06-06 15:14:38
450	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:14:44	2026-06-06 15:14:44
451	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:14:46	2026-06-06 15:14:46
452	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:15:16	2026-06-06 15:15:16
453	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:15:19	2026-06-06 15:15:19
454	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/30	2	2026-06-06 15:21:37	2026-06-06 15:21:37
455	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:21:39	2026-06-06 15:21:39
456	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:21:40	2026-06-06 15:21:40
457	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/30	2	2026-06-06 15:25:53	2026-06-06 15:25:53
458	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:25:54	2026-06-06 15:25:54
459	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:26:49	2026-06-06 15:26:49
460	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	2	2026-06-06 15:26:57	2026-06-06 15:26:57
461	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 15:27:19	2026-06-06 15:27:19
462	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 15:28:01	2026-06-06 15:28:01
463	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/h5BelZiT37sRUS1yUStnL8yc	2	2026-06-06 16:09:51	2026-06-06 16:09:51
464	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-07 04:26:25	2026-06-07 04:26:25
465	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	\N	2026-06-07 04:27:25	2026-06-07 04:27:25
466	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-07 04:27:25	2026-06-07 04:27:25
467	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	\N	2026-06-07 04:27:40	2026-06-07 04:27:40
468	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-07 04:27:41	2026-06-07 04:27:41
469	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	\N	2026-06-07 04:27:44	2026-06-07 04:27:44
470	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-07 04:27:45	2026-06-07 04:27:45
471	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	login	\N	2026-06-07 04:27:53	2026-06-07 04:27:53
472	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 04:28:08	2026-06-07 04:28:08
473	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 04:28:47	2026-06-07 04:28:47
474	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	login	1	2026-06-07 04:28:53	2026-06-07 04:28:53
475	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 04:29:00	2026-06-07 04:29:00
476	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	1	2026-06-07 05:51:31	2026-06-07 05:51:31
477	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 05:58:24	2026-06-07 05:58:24
478	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 05:58:28	2026-06-07 05:58:28
479	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 05:58:34	2026-06-07 05:58:34
480	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 06:02:42	2026-06-07 06:02:42
481	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	1	2026-06-07 06:02:42	2026-06-07 06:02:42
482	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 06:03:44	2026-06-07 06:03:44
483	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	1	2026-06-07 06:03:54	2026-06-07 06:03:54
484	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 06:04:20	2026-06-07 06:04:20
485	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	1	2026-06-07 06:04:22	2026-06-07 06:04:22
486	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 06:04:43	2026-06-07 06:04:43
487	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	1	2026-06-07 06:04:44	2026-06-07 06:04:44
488	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 06:05:31	2026-06-07 06:05:31
489	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	1	2026-06-07 06:05:33	2026-06-07 06:05:33
490	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 06:06:05	2026-06-07 06:06:05
491	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 06:06:12	2026-06-07 06:06:12
492	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 06:06:20	2026-06-07 06:06:20
493	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/celana	1	2026-06-07 06:19:23	2026-06-07 06:19:23
494	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/celana	1	2026-06-07 06:19:29	2026-06-07 06:19:29
495	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/celana	1	2026-06-07 06:19:32	2026-06-07 06:19:32
496	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-07 06:19:35	2026-06-07 06:19:35
497	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-07 08:32:19	2026-06-07 08:32:19
498	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-07 08:33:03	2026-06-07 08:33:03
499	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-07 08:39:58	2026-06-07 08:39:58
500	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-07 08:40:46	2026-06-07 08:40:46
501	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-07 08:43:10	2026-06-07 08:43:10
502	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-07 08:43:36	2026-06-07 08:43:36
503	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-07 08:44:47	2026-06-07 08:44:47
504	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	\N	2026-06-07 08:50:03	2026-06-07 08:50:03
505	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	\N	2026-06-07 08:50:49	2026-06-07 08:50:49
506	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	\N	2026-06-07 08:51:57	2026-06-07 08:51:57
507	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 05:02:21	2026-06-08 05:02:21
508	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	\N	2026-06-08 05:02:28	2026-06-08 05:02:28
509	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 05:02:47	2026-06-08 05:02:47
510	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	\N	2026-06-08 08:24:15	2026-06-08 08:24:15
511	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 08:29:39	2026-06-08 08:29:39
512	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 08:29:42	2026-06-08 08:29:42
513	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 08:39:06	2026-06-08 08:39:06
514	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 08:40:17	2026-06-08 08:40:17
515	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 08:40:34	2026-06-08 08:40:34
516	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 08:41:55	2026-06-08 08:41:55
517	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 08:41:59	2026-06-08 08:41:59
518	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 08:42:26	2026-06-08 08:42:26
519	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 08:43:05	2026-06-08 08:43:05
520	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 08:43:21	2026-06-08 08:43:21
521	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 10:51:19	2026-06-08 10:51:19
522	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 10:51:38	2026-06-08 10:51:38
523	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 10:51:44	2026-06-08 10:51:44
524	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 10:51:48	2026-06-08 10:51:48
525	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 10:51:50	2026-06-08 10:51:50
526	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 10:55:52	2026-06-08 10:55:52
527	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 10:57:18	2026-06-08 10:57:18
528	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 10:59:25	2026-06-08 10:59:25
529	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 11:00:47	2026-06-08 11:00:47
530	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 11:07:01	2026-06-08 11:07:01
531	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 11:07:53	2026-06-08 11:07:53
532	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 11:09:43	2026-06-08 11:09:43
533	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 11:16:51	2026-06-08 11:16:51
534	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-8Mgd	\N	2026-06-08 11:23:49	2026-06-08 11:23:49
535	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 11:23:54	2026-06-08 11:23:54
536	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 11:27:52	2026-06-08 11:27:52
537	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 11:27:55	2026-06-08 11:27:55
538	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 11:32:01	2026-06-08 11:32:01
539	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 11:32:46	2026-06-08 11:32:46
540	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 11:34:07	2026-06-08 11:34:07
541	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 11:35:18	2026-06-08 11:35:18
542	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 11:36:31	2026-06-08 11:36:31
543	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 11:36:49	2026-06-08 11:36:49
544	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 11:37:37	2026-06-08 11:37:37
545	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 11:37:47	2026-06-08 11:37:47
546	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 11:43:50	2026-06-08 11:43:50
547	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 11:44:58	2026-06-08 11:44:58
548	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 11:44:58	2026-06-08 11:44:58
549	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 11:45:51	2026-06-08 11:45:51
550	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 11:50:50	2026-06-08 11:50:50
551	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 11:50:52	2026-06-08 11:50:52
552	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	\N	2026-06-08 11:50:57	2026-06-08 11:50:57
553	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 11:50:57	2026-06-08 11:50:57
554	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	\N	2026-06-08 11:50:59	2026-06-08 11:50:59
555	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 11:50:59	2026-06-08 11:50:59
556	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	\N	2026-06-08 11:51:01	2026-06-08 11:51:01
557	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 11:51:02	2026-06-08 11:51:02
558	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-08 11:51:09	2026-06-08 11:51:09
559	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-08 11:52:34	2026-06-08 11:52:34
560	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-08 11:53:02	2026-06-08 11:53:02
561	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 11:53:07	2026-06-08 11:53:07
562	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 11:53:11	2026-06-08 11:53:11
563	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-08 11:53:19	2026-06-08 11:53:19
564	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:00:01	2026-06-08 12:00:01
565	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:00:50	2026-06-08 12:00:50
566	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:01:14	2026-06-08 12:01:14
567	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:01:27	2026-06-08 12:01:27
568	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:02:54	2026-06-08 12:02:54
569	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:03:46	2026-06-08 12:03:46
570	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:05:10	2026-06-08 12:05:10
571	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:05:36	2026-06-08 12:05:36
572	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:06:25	2026-06-08 12:06:25
573	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:07:14	2026-06-08 12:07:14
574	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:07:37	2026-06-08 12:07:37
575	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:08:14	2026-06-08 12:08:14
576	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-08 12:08:16	2026-06-08 12:08:16
577	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:09:23	2026-06-08 12:09:23
578	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:09:28	2026-06-08 12:09:28
579	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/baju	\N	2026-06-08 12:09:35	2026-06-08 12:09:35
580	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/baju	\N	2026-06-08 12:11:30	2026-06-08 12:11:30
581	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/baju	\N	2026-06-08 12:12:45	2026-06-08 12:12:45
582	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/baju	\N	2026-06-08 12:13:15	2026-06-08 12:13:15
583	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/baju	\N	2026-06-08 12:13:31	2026-06-08 12:13:31
584	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/baju	\N	2026-06-08 12:14:08	2026-06-08 12:14:08
585	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/baju	\N	2026-06-08 12:14:34	2026-06-08 12:14:34
586	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/baju	\N	2026-06-08 12:14:49	2026-06-08 12:14:49
587	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/baju	\N	2026-06-08 12:15:05	2026-06-08 12:15:05
588	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-08 12:15:14	2026-06-08 12:15:14
589	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:15:49	2026-06-08 12:15:49
590	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:38:12	2026-06-08 12:38:12
591	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-08 12:38:16	2026-06-08 12:38:16
592	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:38:33	2026-06-08 12:38:33
593	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 12:39:18	2026-06-08 12:39:18
594	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products	\N	2026-06-08 12:39:25	2026-06-08 12:39:25
595	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-08 12:43:52	2026-06-08 12:43:52
596	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-08 12:44:22	2026-06-08 12:44:22
597	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-08 13:19:46	2026-06-08 13:19:46
598	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-08 13:19:49	2026-06-08 13:19:49
599	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-08 13:22:25	2026-06-08 13:22:25
600	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-08 13:23:11	2026-06-08 13:23:11
601	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-08 13:25:24	2026-06-08 13:25:24
602	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 13:25:48	2026-06-08 13:25:48
603	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-08 13:25:50	2026-06-08 13:25:50
604	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-08 13:25:57	2026-06-08 13:25:57
605	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-08 13:28:10	2026-06-08 13:28:10
606	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 13:28:15	2026-06-08 13:28:15
607	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-08 13:29:06	2026-06-08 13:29:06
608	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-08 13:30:11	2026-06-08 13:30:11
609	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-08 13:30:30	2026-06-08 13:30:30
610	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 13:31:02	2026-06-08 13:31:02
611	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-08 13:31:10	2026-06-08 13:31:10
612	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 13:35:40	2026-06-08 13:35:40
613	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-08 13:48:25	2026-06-08 13:48:25
614	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	\N	2026-06-08 13:48:41	2026-06-08 13:48:41
615	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-08 13:48:41	2026-06-08 13:48:41
616	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	\N	2026-06-08 13:48:43	2026-06-08 13:48:43
617	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-08 13:48:44	2026-06-08 13:48:44
618	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-08 13:49:12	2026-06-08 13:49:12
619	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-08 13:49:17	2026-06-08 13:49:17
620	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-08 13:49:27	2026-06-08 13:49:27
621	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 03:27:36	2026-06-09 03:27:36
622	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 03:27:39	2026-06-09 03:27:39
623	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 03:27:39	2026-06-09 03:27:39
624	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 03:27:40	2026-06-09 03:27:40
625	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 03:30:35	2026-06-09 03:30:35
626	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 03:32:10	2026-06-09 03:32:10
627	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 03:34:23	2026-06-09 03:34:23
661	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	login	\N	2026-06-09 04:22:15	2026-06-09 04:22:15
628	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 03:36:27	2026-06-09 03:36:27
629	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 03:36:44	2026-06-09 03:36:44
630	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 03:37:26	2026-06-09 03:37:26
631	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 03:37:28	2026-06-09 03:37:28
632	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 03:39:21	2026-06-09 03:39:21
633	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 03:39:28	2026-06-09 03:39:28
634	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 03:42:18	2026-06-09 03:42:18
635	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 03:43:44	2026-06-09 03:43:44
636	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 03:43:45	2026-06-09 03:43:45
637	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 03:43:48	2026-06-09 03:43:48
638	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	\N	2026-06-09 03:43:50	2026-06-09 03:43:50
639	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 03:44:35	2026-06-09 03:44:35
640	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/muslim-lebaran-uBVG	\N	2026-06-09 03:44:38	2026-06-09 03:44:38
641	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-09 03:44:48	2026-06-09 03:44:48
642	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-09 03:46:44	2026-06-09 03:46:44
643	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-09 03:46:46	2026-06-09 03:46:46
644	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-09 03:46:49	2026-06-09 03:46:49
645	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-09 03:46:50	2026-06-09 03:46:50
646	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-09 03:48:42	2026-06-09 03:48:42
647	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-09 03:48:54	2026-06-09 03:48:54
648	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-09 03:48:55	2026-06-09 03:48:55
649	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-09 03:51:06	2026-06-09 03:51:06
650	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	login	\N	2026-06-09 03:55:07	2026-06-09 03:55:07
651	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-09 03:55:22	2026-06-09 03:55:22
652	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	1	2026-06-09 03:55:32	2026-06-09 03:55:32
653	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	1	2026-06-09 04:13:49	2026-06-09 04:13:49
654	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	login	\N	2026-06-09 04:14:23	2026-06-09 04:14:23
655	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 04:14:26	2026-06-09 04:14:26
656	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 04:15:55	2026-06-09 04:15:55
657	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tentang-kami	\N	2026-06-09 04:17:45	2026-06-09 04:17:45
658	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	login	\N	2026-06-09 04:19:23	2026-06-09 04:19:23
659	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	login	\N	2026-06-09 04:20:48	2026-06-09 04:20:48
660	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	login	\N	2026-06-09 04:20:56	2026-06-09 04:20:56
662	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	register	\N	2026-06-09 04:22:18	2026-06-09 04:22:18
663	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	register	\N	2026-06-09 04:22:26	2026-06-09 04:22:26
664	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	register	\N	2026-06-09 04:22:39	2026-06-09 04:22:39
665	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	login	\N	2026-06-09 04:22:46	2026-06-09 04:22:46
666	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	login	\N	2026-06-09 05:24:57	2026-06-09 05:24:57
667	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:26:09	2026-06-09 05:26:09
668	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 05:26:11	2026-06-09 05:26:11
669	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:26:47	2026-06-09 05:26:47
670	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:33:16	2026-06-09 05:33:16
671	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:34:54	2026-06-09 05:34:54
672	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:35:04	2026-06-09 05:35:04
673	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:35:50	2026-06-09 05:35:50
674	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:36:55	2026-06-09 05:36:55
675	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:38:52	2026-06-09 05:38:52
676	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:39:12	2026-06-09 05:39:12
677	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:39:32	2026-06-09 05:39:32
678	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:40:43	2026-06-09 05:40:43
679	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:51:13	2026-06-09 05:51:13
680	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:51:40	2026-06-09 05:51:40
681	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:52:38	2026-06-09 05:52:38
682	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:52:58	2026-06-09 05:52:58
683	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:53:14	2026-06-09 05:53:14
684	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:55:10	2026-06-09 05:55:10
685	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:55:15	2026-06-09 05:55:15
686	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:56:16	2026-06-09 05:56:16
687	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:58:25	2026-06-09 05:58:25
688	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:58:45	2026-06-09 05:58:45
689	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:59:07	2026-06-09 05:59:07
690	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:59:08	2026-06-09 05:59:08
691	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 05:59:37	2026-06-09 05:59:37
692	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 06:03:23	2026-06-09 06:03:23
693	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 06:03:31	2026-06-09 06:03:31
694	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 06:06:24	2026-06-09 06:06:24
695	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 06:08:04	2026-06-09 06:08:04
696	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 06:09:32	2026-06-09 06:09:32
697	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	\N	2026-06-09 06:14:32	2026-06-09 06:14:32
698	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 06:14:33	2026-06-09 06:14:33
699	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/baju	\N	2026-06-09 06:15:47	2026-06-09 06:15:47
700	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/outer	\N	2026-06-09 06:16:14	2026-06-09 06:16:14
701	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/celana	\N	2026-06-09 06:16:19	2026-06-09 06:16:19
702	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	\N	2026-06-09 06:17:13	2026-06-09 06:17:13
703	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 06:38:46	2026-06-09 06:38:46
704	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 07:32:09	2026-06-09 07:32:09
705	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 07:46:26	2026-06-09 07:46:26
706	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 07:46:33	2026-06-09 07:46:33
707	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 07:47:24	2026-06-09 07:47:24
708	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 07:48:27	2026-06-09 07:48:27
709	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 07:48:48	2026-06-09 07:48:48
710	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 07:51:20	2026-06-09 07:51:20
711	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 07:51:47	2026-06-09 07:51:47
712	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 07:53:23	2026-06-09 07:53:23
713	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 07:55:10	2026-06-09 07:55:10
714	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 07:55:40	2026-06-09 07:55:40
715	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 07:59:48	2026-06-09 07:59:48
716	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 09:31:57	2026-06-09 09:31:57
717	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 09:37:13	2026-06-09 09:37:13
718	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 09:41:59	2026-06-09 09:41:59
719	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 09:42:55	2026-06-09 09:42:55
720	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 09:53:37	2026-06-09 09:53:37
721	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	\N	2026-06-09 09:54:05	2026-06-09 09:54:05
722	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	tracking/dFIFGa0aM0oTwIOIFkNENpsW	\N	2026-06-09 09:54:11	2026-06-09 09:54:11
723	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 09:59:30	2026-06-09 09:59:30
724	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products	\N	2026-06-09 09:59:43	2026-06-09 09:59:43
725	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/outer	\N	2026-06-09 10:06:18	2026-06-09 10:06:18
726	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/baju	\N	2026-06-09 10:06:24	2026-06-09 10:06:24
727	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:06:38	2026-06-09 10:06:38
728	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:11:00	2026-06-09 10:11:00
729	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products	\N	2026-06-09 10:11:11	2026-06-09 10:11:11
730	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-2206-adeeva-blouse-blouse-broken-white-atasan-broken-white-blouse-busui-blouse-bahan-adem-korean-blouse-wFWR	\N	2026-06-09 10:11:28	2026-06-09 10:11:28
731	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:20:22	2026-06-09 10:20:22
732	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:21:01	2026-06-09 10:21:01
733	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:21:57	2026-06-09 10:21:57
734	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	\N	2026-06-09 10:22:17	2026-06-09 10:22:17
735	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:22:17	2026-06-09 10:22:17
736	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:27:56	2026-06-09 10:27:56
737	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	\N	2026-06-09 10:28:01	2026-06-09 10:28:01
738	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:28:10	2026-06-09 10:28:10
739	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:28:48	2026-06-09 10:28:48
740	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products	\N	2026-06-09 10:28:55	2026-06-09 10:28:55
741	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:29:15	2026-06-09 10:29:15
742	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	\N	2026-06-09 10:29:28	2026-06-09 10:29:28
743	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:29:28	2026-06-09 10:29:28
744	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:29:53	2026-06-09 10:29:53
745	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/id	\N	2026-06-09 10:29:56	2026-06-09 10:29:56
746	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:29:57	2026-06-09 10:29:57
747	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	language/en	\N	2026-06-09 10:30:13	2026-06-09 10:30:13
748	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:30:13	2026-06-09 10:30:13
749	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/outwear	\N	2026-06-09 10:30:22	2026-06-09 10:30:22
750	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:30:33	2026-06-09 10:30:33
751	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:30:55	2026-06-09 10:30:55
752	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/outwear	\N	2026-06-09 10:32:58	2026-06-09 10:32:58
753	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/outwear	\N	2026-06-09 10:35:24	2026-06-09 10:35:24
754	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/outwear	\N	2026-06-09 10:35:51	2026-06-09 10:35:51
755	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/outwear	\N	2026-06-09 10:35:58	2026-06-09 10:35:58
756	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/outwear	\N	2026-06-09 10:36:11	2026-06-09 10:36:11
757	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/outwear	\N	2026-06-09 10:36:12	2026-06-09 10:36:12
758	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/atasan	\N	2026-06-09 10:36:15	2026-06-09 10:36:15
759	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/atasan-muslim-wanita	\N	2026-06-09 10:36:17	2026-06-09 10:36:17
760	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/sweater-cardigan	\N	2026-06-09 10:36:18	2026-06-09 10:36:18
761	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/celana	\N	2026-06-09 10:36:21	2026-06-09 10:36:21
762	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/sweater-cardigan	\N	2026-06-09 10:36:31	2026-06-09 10:36:31
763	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/atasan-muslim-wanita	\N	2026-06-09 10:36:33	2026-06-09 10:36:33
764	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/atasan	\N	2026-06-09 10:36:34	2026-06-09 10:36:34
765	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/outwear	\N	2026-06-09 10:36:42	2026-06-09 10:36:42
766	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:36:48	2026-06-09 10:36:48
767	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-09 10:36:55	2026-06-09 10:36:55
768	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:40:54	2026-06-09 10:40:54
769	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:42:27	2026-06-09 10:42:27
770	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:44:26	2026-06-09 10:44:26
771	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:44:44	2026-06-09 10:44:44
772	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:45:56	2026-06-09 10:45:56
773	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:46:59	2026-06-09 10:46:59
774	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-09 10:47:25	2026-06-09 10:47:25
775	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-09 10:48:20	2026-06-09 10:48:20
776	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 10:48:44	2026-06-09 10:48:44
777	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-09 11:42:16	2026-06-09 11:42:16
778	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-10 07:22:52	2026-06-10 07:22:52
779	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products	\N	2026-06-10 07:49:11	2026-06-10 07:49:11
780	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-10 07:49:18	2026-06-10 07:49:18
781	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products	\N	2026-06-10 07:49:22	2026-06-10 07:49:22
782	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-10 07:49:29	2026-06-10 07:49:29
783	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/outwear	\N	2026-06-10 07:49:32	2026-06-10 07:49:32
784	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/atasan	\N	2026-06-10 07:49:39	2026-06-10 07:49:39
785	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/atasan-muslim-wanita	\N	2026-06-10 07:49:41	2026-06-10 07:49:41
786	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/sweater-cardigan	\N	2026-06-10 07:49:42	2026-06-10 07:49:42
787	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/celana	\N	2026-06-10 07:49:44	2026-06-10 07:49:44
788	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	category/outwear	\N	2026-06-10 07:49:47	2026-06-10 07:49:47
789	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-10 07:49:55	2026-06-10 07:49:55
790	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-10 07:50:58	2026-06-10 07:50:58
791	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-10 08:54:54	2026-06-10 08:54:54
792	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-10 09:48:13	2026-06-10 09:48:13
793	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-10 09:50:40	2026-06-10 09:50:40
794	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-10 09:50:42	2026-06-10 09:50:42
795	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-10 09:54:55	2026-06-10 09:54:55
796	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	\N	2026-06-10 09:55:31	2026-06-10 09:55:31
797	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	login	\N	2026-06-10 09:55:46	2026-06-10 09:55:46
798	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	/	1	2026-06-10 09:55:59	2026-06-10 09:55:59
799	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-atasan-polos-wanita-atasan-bahan-knit-halus-sweater-rajut-sweater-polos-rajut-SES0	1	2026-06-10 09:56:07	2026-06-10 09:56:07
800	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-10 09:56:17	2026-06-10 09:56:17
801	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-10 09:56:54	2026-06-10 09:56:54
802	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-10 09:57:02	2026-06-10 09:57:02
803	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	cart	1	2026-06-10 09:57:05	2026-06-10 09:57:05
804	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 09:57:15	2026-06-10 09:57:15
805	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 09:58:59	2026-06-10 09:58:59
806	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 09:59:03	2026-06-10 09:59:03
807	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 10:00:26	2026-06-10 10:00:26
808	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 10:04:03	2026-06-10 10:04:03
809	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 10:11:33	2026-06-10 10:11:33
810	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 10:46:08	2026-06-10 10:46:08
811	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 10:46:52	2026-06-10 10:46:52
812	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 10:48:21	2026-06-10 10:48:21
813	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 10:49:37	2026-06-10 10:49:37
814	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 10:50:22	2026-06-10 10:50:22
815	127.0.0.1	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-10 10:52:19	2026-06-10 10:52:19
816	127.0.0.1	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-10 10:52:28	2026-06-10 10:52:28
817	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 10:56:45	2026-06-10 10:56:45
818	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 11:00:55	2026-06-10 11:00:55
819	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 11:03:14	2026-06-10 11:03:14
820	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 11:08:39	2026-06-10 11:08:39
821	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 11:14:23	2026-06-10 11:14:23
822	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 11:14:40	2026-06-10 11:14:40
823	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 11:20:12	2026-06-10 11:20:12
824	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 11:31:36	2026-06-10 11:31:36
825	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 11:32:12	2026-06-10 11:32:12
826	127.0.0.1	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-10 11:35:10	2026-06-10 11:35:10
827	127.0.0.1	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-10 11:41:52	2026-06-10 11:41:52
828	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 11:42:20	2026-06-10 11:42:20
829	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 11:45:43	2026-06-10 11:45:43
830	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 11:45:44	2026-06-10 11:45:44
831	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 11:46:10	2026-06-10 11:46:10
832	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 11:46:12	2026-06-10 11:46:12
833	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 12:00:05	2026-06-10 12:00:05
834	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 12:12:47	2026-06-10 12:12:47
835	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 12:12:49	2026-06-10 12:12:49
836	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 12:17:36	2026-06-10 12:17:36
837	127.0.0.1	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-10 12:25:26	2026-06-10 12:25:26
838	127.0.0.1	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-10 12:25:36	2026-06-10 12:25:36
839	127.0.0.1	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-10 12:26:21	2026-06-10 12:26:21
840	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 12:27:17	2026-06-10 12:27:17
841	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 12:28:07	2026-06-10 12:28:07
842	127.0.0.1	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-10 12:30:08	2026-06-10 12:30:08
843	127.0.0.1	Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-10 12:30:33	2026-06-10 12:30:33
844	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 13:58:42	2026-06-10 13:58:42
845	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:01:23	2026-06-10 14:01:23
846	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 14:01:27	2026-06-10 14:01:27
847	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 14:01:55	2026-06-10 14:01:55
848	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 14:01:57	2026-06-10 14:01:57
849	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:07:47	2026-06-10 14:07:47
850	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:08:31	2026-06-10 14:08:31
851	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:09:44	2026-06-10 14:09:44
852	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:10:23	2026-06-10 14:10:23
853	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:11:40	2026-06-10 14:11:40
854	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:12:16	2026-06-10 14:12:16
855	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:12:42	2026-06-10 14:12:42
856	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:16:02	2026-06-10 14:16:02
857	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:18:12	2026-06-10 14:18:12
858	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 14:22:15	2026-06-10 14:22:15
859	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 14:22:18	2026-06-10 14:22:18
860	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 14:22:19	2026-06-10 14:22:19
861	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:24:08	2026-06-10 14:24:08
862	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:24:45	2026-06-10 14:24:45
863	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:25:20	2026-06-10 14:25:20
864	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 14:25:38	2026-06-10 14:25:38
865	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 14:25:40	2026-06-10 14:25:40
866	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 14:25:44	2026-06-10 14:25:44
867	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:29:26	2026-06-10 14:29:26
868	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:29:41	2026-06-10 14:29:41
869	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:29:45	2026-06-10 14:29:45
870	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:32:48	2026-06-10 14:32:48
871	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	checkout	1	2026-06-10 14:32:59	2026-06-10 14:32:59
872	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 14:34:34	2026-06-10 14:34:34
873	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 14:34:39	2026-06-10 14:34:39
874	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 14:34:42	2026-06-10 14:34:42
875	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-10 14:34:42	2026-06-10 14:34:42
876	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/31	1	2026-06-10 14:35:12	2026-06-10 14:35:12
877	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	1	2026-06-10 14:37:32	2026-06-10 14:37:32
878	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/31	1	2026-06-10 14:37:33	2026-06-10 14:37:33
879	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/31	1	2026-06-10 14:37:38	2026-06-10 14:37:38
880	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders/31	1	2026-06-10 14:37:45	2026-06-10 14:37:45
881	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	1	2026-06-10 14:37:48	2026-06-10 14:37:48
882	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	orders	1	2026-06-10 14:58:52	2026-06-10 14:58:52
883	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-11 01:41:48	2026-06-11 01:41:48
884	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-11 01:44:36	2026-06-11 01:44:36
885	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-11 01:45:03	2026-06-11 01:45:03
886	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-11 01:48:24	2026-06-11 01:48:24
887	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 01:58:10	2026-06-11 01:58:10
888	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 01:58:21	2026-06-11 01:58:21
889	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-11 01:58:23	2026-06-11 01:58:23
890	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-11 01:58:27	2026-06-11 01:58:27
891	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 02:00:10	2026-06-11 02:00:10
892	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 02:00:11	2026-06-11 02:00:11
893	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 02:00:13	2026-06-11 02:00:13
894	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 02:00:18	2026-06-11 02:00:18
895	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 02:00:19	2026-06-11 02:00:19
896	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 02:00:20	2026-06-11 02:00:20
897	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 02:00:20	2026-06-11 02:00:20
898	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 02:00:24	2026-06-11 02:00:24
899	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 02:00:25	2026-06-11 02:00:25
900	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 02:00:26	2026-06-11 02:00:26
901	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 02:00:27	2026-06-11 02:00:27
902	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 02:00:29	2026-06-11 02:00:29
903	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:36:15	2026-06-11 02:36:15
904	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:36:59	2026-06-11 02:36:59
905	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:37:30	2026-06-11 02:37:30
906	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:37:46	2026-06-11 02:37:46
907	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:38:37	2026-06-11 02:38:37
908	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:38:47	2026-06-11 02:38:47
909	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:39:55	2026-06-11 02:39:55
910	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:40:57	2026-06-11 02:40:57
911	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:41:05	2026-06-11 02:41:05
912	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:43:12	2026-06-11 02:43:12
913	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:44:32	2026-06-11 02:44:32
914	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:45:53	2026-06-11 02:45:53
915	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:47:25	2026-06-11 02:47:25
916	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:48:37	2026-06-11 02:48:37
917	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:48:38	2026-06-11 02:48:38
918	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:51:58	2026-06-11 02:51:58
919	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:52:20	2026-06-11 02:52:20
920	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:55:03	2026-06-11 02:55:03
921	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:55:08	2026-06-11 02:55:08
922	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:55:16	2026-06-11 02:55:16
923	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:55:45	2026-06-11 02:55:45
924	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:55:49	2026-06-11 02:55:49
925	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:57:43	2026-06-11 02:57:43
926	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:59:01	2026-06-11 02:59:01
927	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:59:09	2026-06-11 02:59:09
928	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 02:59:12	2026-06-11 02:59:12
929	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-11 02:59:27	2026-06-11 02:59:27
930	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-11 02:59:28	2026-06-11 02:59:28
931	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-11 03:07:50	2026-06-11 03:07:50
932	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-11 03:36:51	2026-06-11 03:36:51
933	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-11 03:37:18	2026-06-11 03:37:18
934	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-11 03:37:32	2026-06-11 03:37:32
935	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-11 03:37:36	2026-06-11 03:37:36
936	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-11 03:37:37	2026-06-11 03:37:37
937	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-11 03:37:53	2026-06-11 03:37:53
938	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-11 03:38:46	2026-06-11 03:38:46
939	127.0.0.1	Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-11 03:39:07	2026-06-11 03:39:07
940	127.0.0.1	Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-11 03:42:18	2026-06-11 03:42:18
941	127.0.0.1	Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-11 03:44:10	2026-06-11 03:44:10
942	127.0.0.1	Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-11 03:44:40	2026-06-11 03:44:40
943	127.0.0.1	Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-11 03:45:09	2026-06-11 03:45:09
944	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/33	1	2026-06-11 03:47:16	2026-06-11 03:47:16
945	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-11 03:47:57	2026-06-11 03:47:57
946	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/33	1	2026-06-11 03:50:55	2026-06-11 03:50:55
947	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/33	1	2026-06-11 03:51:09	2026-06-11 03:51:09
948	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/33	1	2026-06-11 04:01:25	2026-06-11 04:01:25
949	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/33	1	2026-06-11 04:03:24	2026-06-11 04:03:24
950	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/33	1	2026-06-11 04:03:40	2026-06-11 04:03:40
951	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/33	1	2026-06-11 04:04:12	2026-06-11 04:04:12
952	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/33	1	2026-06-11 04:06:04	2026-06-11 04:06:04
953	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/33	1	2026-06-11 04:06:08	2026-06-11 04:06:08
954	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/33	1	2026-06-11 04:07:18	2026-06-11 04:07:18
955	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/33	1	2026-06-11 04:08:24	2026-06-11 04:08:24
956	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/33	1	2026-06-11 04:08:42	2026-06-11 04:08:42
957	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-11 04:08:58	2026-06-11 04:08:58
958	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-11 04:09:05	2026-06-11 04:09:05
959	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-hara-tunik-bahan-tencel-bordir-baju-formal-baju-undangan-raya-tunik-qyCN	1	2026-06-11 04:09:23	2026-06-11 04:09:23
960	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-hara-tunik-bahan-tencel-bordir-baju-formal-baju-undangan-raya-tunik-qyCN	1	2026-06-11 04:09:25	2026-06-11 04:09:25
961	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-11 04:09:27	2026-06-11 04:09:27
962	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-11 04:09:29	2026-06-11 04:09:29
963	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 04:09:40	2026-06-11 04:09:40
964	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-11 04:09:56	2026-06-11 04:09:56
965	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/34	1	2026-06-11 04:10:13	2026-06-11 04:10:13
966	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/34	1	2026-06-11 04:10:17	2026-06-11 04:10:17
967	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/34	1	2026-06-11 04:10:54	2026-06-11 04:10:54
968	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/IONH4qSozeM6RLDgh3vyyJp2	1	2026-06-11 04:11:12	2026-06-11 04:11:12
969	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/IONH4qSozeM6RLDgh3vyyJp2	1	2026-06-11 04:11:20	2026-06-11 04:11:20
970	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/34	1	2026-06-11 04:11:27	2026-06-11 04:11:27
971	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/IONH4qSozeM6RLDgh3vyyJp2	1	2026-06-11 04:11:27	2026-06-11 04:11:27
972	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/34	\N	2026-06-11 07:34:17	2026-06-11 07:34:17
973	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-11 07:34:18	2026-06-11 07:34:18
974	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-11 07:36:30	2026-06-11 07:36:30
975	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-11 07:37:10	2026-06-11 07:37:10
976	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-11 07:37:38	2026-06-11 07:37:38
977	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-11 07:37:47	2026-06-11 07:37:47
978	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-11 07:37:56	2026-06-11 07:37:56
979	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-11 07:39:35	2026-06-11 07:39:35
980	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-11 07:40:09	2026-06-11 07:40:09
981	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-11 07:41:40	2026-06-11 07:41:40
982	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-11 07:41:47	2026-06-11 07:41:47
983	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-11 07:41:53	2026-06-11 07:41:53
984	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-11 07:42:06	2026-06-11 07:42:06
985	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-11 07:43:51	2026-06-11 07:43:51
986	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-11 07:44:33	2026-06-11 07:44:33
987	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/IONH4qSozeM6RLDgh3vyyJp2	1	2026-06-11 07:52:38	2026-06-11 07:52:38
988	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/IONH4qSozeM6RLDgh3vyyJp2	1	2026-06-11 07:53:55	2026-06-11 07:53:55
989	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/IONH4qSozeM6RLDgh3vyyJp2	1	2026-06-11 07:54:00	2026-06-11 07:54:00
990	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/IONH4qSozeM6RLDgh3vyyJp2	1	2026-06-11 07:55:30	2026-06-11 07:55:30
991	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-11 10:55:03	2026-06-11 10:55:03
992	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-11 10:55:11	2026-06-11 10:55:11
993	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-11 10:55:26	2026-06-11 10:55:26
994	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-11 10:55:26	2026-06-11 10:55:26
995	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-11 10:55:32	2026-06-11 10:55:32
996	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-11 10:55:33	2026-06-11 10:55:33
997	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-11 10:55:33	2026-06-11 10:55:33
998	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-11 10:55:34	2026-06-11 10:55:34
999	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-11 11:32:45	2026-06-11 11:32:45
1000	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-11 11:33:36	2026-06-11 11:33:36
1001	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-11 11:34:14	2026-06-11 11:34:14
1002	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-11 11:34:14	2026-06-11 11:34:14
1003	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-11 11:34:39	2026-06-11 11:34:39
1004	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-11 11:34:39	2026-06-11 11:34:39
1005	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-11 11:34:47	2026-06-11 11:34:47
1006	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-2212-lumi-blouse-blouse-tali-belakang-atasan-tali-belakang-bahan-polo-linen-qu5S	\N	2026-06-11 11:34:59	2026-06-11 11:34:59
1007	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-11 11:35:11	2026-06-11 11:35:11
1008	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-11 11:35:53	2026-06-11 11:35:53
1009	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-11 11:52:07	2026-06-11 11:52:07
1010	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-12 10:44:12	2026-06-12 10:44:12
1011	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-12 10:44:34	2026-06-12 10:44:34
1012	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tentang-kami	\N	2026-06-12 10:46:13	2026-06-12 10:46:13
1013	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	\N	2026-06-12 10:46:23	2026-06-12 10:46:23
1014	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-12 11:41:13	2026-06-12 11:41:13
1015	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-13 02:42:51	2026-06-13 02:42:51
1016	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	register	\N	2026-06-13 02:44:06	2026-06-13 02:44:06
1017	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 02:45:40	2026-06-13 02:45:40
1018	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-13 02:45:58	2026-06-13 02:45:58
1019	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-13 02:52:06	2026-06-13 02:52:06
1020	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	register	\N	2026-06-13 02:52:13	2026-06-13 02:52:13
1021	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	register	\N	2026-06-13 02:52:31	2026-06-13 02:52:31
1022	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-13 02:52:43	2026-06-13 02:52:43
1023	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 02:52:53	2026-06-13 02:52:53
1024	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-13 02:53:02	2026-06-13 02:53:02
1025	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-13 02:53:16	2026-06-13 02:53:16
1026	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-13 02:53:42	2026-06-13 02:53:42
1027	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 02:54:20	2026-06-13 02:54:20
1028	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	3	2026-06-13 02:54:33	2026-06-13 02:54:33
1029	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 02:54:33	2026-06-13 02:54:33
1030	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	3	2026-06-13 02:54:45	2026-06-13 02:54:45
1031	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 02:54:45	2026-06-13 02:54:45
1032	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	3	2026-06-13 02:54:51	2026-06-13 02:54:51
1033	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	3	2026-06-13 02:55:17	2026-06-13 02:55:17
1034	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	3	2026-06-13 02:55:43	2026-06-13 02:55:43
1035	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	3	2026-06-13 02:56:01	2026-06-13 02:56:01
1036	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-13 02:56:11	2026-06-13 02:56:11
1037	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-13 02:56:24	2026-06-13 02:56:24
1038	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 02:56:41	2026-06-13 02:56:41
1039	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	3	2026-06-13 02:57:15	2026-06-13 02:57:15
1040	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 02:57:17	2026-06-13 02:57:17
1041	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	3	2026-06-13 02:57:20	2026-06-13 02:57:20
1042	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 02:57:22	2026-06-13 02:57:22
1043	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan-muslim-wanita	3	2026-06-13 02:57:24	2026-06-13 02:57:24
1044	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 02:57:26	2026-06-13 02:57:26
1045	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/sweater-cardigan	3	2026-06-13 02:57:28	2026-06-13 02:57:28
1046	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	3	2026-06-13 02:57:31	2026-06-13 02:57:31
1047	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 02:57:33	2026-06-13 02:57:33
1048	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	3	2026-06-13 02:57:47	2026-06-13 02:57:47
1049	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	3	2026-06-13 02:58:25	2026-06-13 02:58:25
1050	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	3	2026-06-13 02:58:35	2026-06-13 02:58:35
1051	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	3	2026-06-13 02:58:38	2026-06-13 02:58:38
1052	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	3	2026-06-13 02:58:53	2026-06-13 02:58:53
1053	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	3	2026-06-13 02:59:16	2026-06-13 02:59:16
1054	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	3	2026-06-13 02:59:56	2026-06-13 02:59:56
1055	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	3	2026-06-13 03:00:07	2026-06-13 03:00:07
1056	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	3	2026-06-13 03:00:15	2026-06-13 03:00:15
1057	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	3	2026-06-13 03:00:19	2026-06-13 03:00:19
1058	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	search	3	2026-06-13 03:00:49	2026-06-13 03:00:49
1059	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	search	3	2026-06-13 03:00:53	2026-06-13 03:00:53
1060	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	search	3	2026-06-13 03:01:03	2026-06-13 03:01:03
1061	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	3	2026-06-13 03:01:18	2026-06-13 03:01:18
1062	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:03:02	2026-06-13 03:03:02
1063	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	3	2026-06-13 03:03:04	2026-06-13 03:03:04
1064	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	3	2026-06-13 03:03:08	2026-06-13 03:03:08
1065	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan-muslim-wanita	3	2026-06-13 03:03:12	2026-06-13 03:03:12
1066	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/sweater-cardigan	3	2026-06-13 03:03:16	2026-06-13 03:03:16
1067	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	3	2026-06-13 03:03:20	2026-06-13 03:03:20
1068	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:03:25	2026-06-13 03:03:25
1069	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-sweat-pants-baan-katun-celana-olahraga-celana-santai-bahan-katun-N0ba	3	2026-06-13 03:04:31	2026-06-13 03:04:31
1070	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:05:25	2026-06-13 03:05:25
1071	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	3	2026-06-13 03:05:32	2026-06-13 03:05:32
1072	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	3	2026-06-13 03:05:45	2026-06-13 03:05:45
1073	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan-muslim-wanita	3	2026-06-13 03:05:47	2026-06-13 03:05:47
1074	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/sweater-cardigan	3	2026-06-13 03:05:49	2026-06-13 03:05:49
1075	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	3	2026-06-13 03:05:50	2026-06-13 03:05:50
1076	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan-muslim-wanita	3	2026-06-13 03:05:51	2026-06-13 03:05:51
1077	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/sweater-cardigan	3	2026-06-13 03:05:52	2026-06-13 03:05:52
1078	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	3	2026-06-13 03:05:53	2026-06-13 03:05:53
1079	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	3	2026-06-13 03:05:57	2026-06-13 03:05:57
1080	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:05:59	2026-06-13 03:05:59
1081	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	3	2026-06-13 03:06:02	2026-06-13 03:06:02
1082	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:06:06	2026-06-13 03:06:06
1083	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	3	2026-06-13 03:06:09	2026-06-13 03:06:09
1084	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:06:15	2026-06-13 03:06:15
1085	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:11:33	2026-06-13 03:11:33
1086	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	3	2026-06-13 03:11:45	2026-06-13 03:11:45
1087	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:11:47	2026-06-13 03:11:47
1088	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:11:54	2026-06-13 03:11:54
1089	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:11:57	2026-06-13 03:11:57
1090	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:12:07	2026-06-13 03:12:07
1091	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	3	2026-06-13 03:12:10	2026-06-13 03:12:10
1092	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:12:12	2026-06-13 03:12:12
1093	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:12:22	2026-06-13 03:12:22
1094	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	3	2026-06-13 03:12:32	2026-06-13 03:12:32
1095	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:12:32	2026-06-13 03:12:32
1096	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	3	2026-06-13 03:12:34	2026-06-13 03:12:34
1097	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:12:34	2026-06-13 03:12:34
1098	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	3	2026-06-13 03:12:42	2026-06-13 03:12:42
1099	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:12:42	2026-06-13 03:12:42
1100	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-2206-adeeva-blouse-blouse-broken-white-atasan-broken-white-blouse-busui-blouse-bahan-adem-korean-blouse-wFWR	3	2026-06-13 03:12:56	2026-06-13 03:12:56
1101	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:13:09	2026-06-13 03:13:09
1102	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	3	2026-06-13 03:13:10	2026-06-13 03:13:10
1103	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:13:11	2026-06-13 03:13:11
1104	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:13:13	2026-06-13 03:13:13
1105	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	3	2026-06-13 03:13:16	2026-06-13 03:13:16
1106	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	3	2026-06-13 03:13:23	2026-06-13 03:13:23
1107	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	3	2026-06-13 03:13:24	2026-06-13 03:13:24
1108	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	3	2026-06-13 03:13:25	2026-06-13 03:13:25
1109	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	3	2026-06-13 03:13:25	2026-06-13 03:13:25
1110	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:13:43	2026-06-13 03:13:43
1111	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:13:46	2026-06-13 03:13:46
1112	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:13:47	2026-06-13 03:13:47
1113	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:13:50	2026-06-13 03:13:50
1114	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:13:52	2026-06-13 03:13:52
1115	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:13:53	2026-06-13 03:13:53
1116	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:13:54	2026-06-13 03:13:54
1117	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:13:58	2026-06-13 03:13:58
1118	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/35	3	2026-06-13 03:14:13	2026-06-13 03:14:13
1119	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/35	3	2026-06-13 03:14:28	2026-06-13 03:14:28
1120	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/35	3	2026-06-13 03:14:30	2026-06-13 03:14:30
1121	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/35	3	2026-06-13 03:14:40	2026-06-13 03:14:40
1122	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/35	3	2026-06-13 03:14:41	2026-06-13 03:14:41
1123	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/35	3	2026-06-13 03:15:25	2026-06-13 03:15:25
1124	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:15:32	2026-06-13 03:15:32
1125	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	3	2026-06-13 03:15:36	2026-06-13 03:15:36
1126	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:15:38	2026-06-13 03:15:38
1127	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:15:40	2026-06-13 03:15:40
1128	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:15:41	2026-06-13 03:15:41
1129	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	3	2026-06-13 03:15:43	2026-06-13 03:15:43
1130	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:15:56	2026-06-13 03:15:56
1131	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:15:58	2026-06-13 03:15:58
1132	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/36	3	2026-06-13 03:16:08	2026-06-13 03:16:08
1133	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/36	3	2026-06-13 03:16:10	2026-06-13 03:16:10
1134	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	3	2026-06-13 03:17:31	2026-06-13 03:17:31
1135	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:17:33	2026-06-13 03:17:33
1136	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:17:35	2026-06-13 03:17:35
1137	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	notifications/147/read	3	2026-06-13 03:17:38	2026-06-13 03:17:38
1138	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/36	3	2026-06-13 03:17:39	2026-06-13 03:17:39
1139	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	3	2026-06-13 03:17:43	2026-06-13 03:17:43
1140	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:17:47	2026-06-13 03:17:47
1141	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	3	2026-06-13 03:17:51	2026-06-13 03:17:51
1142	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:18:03	2026-06-13 03:18:03
1143	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:20:46	2026-06-13 03:20:46
1144	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:21:31	2026-06-13 03:21:31
1145	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-hara-tunik-bahan-tencel-bordir-baju-formal-baju-undangan-raya-tunik-qyCN	3	2026-06-13 03:21:35	2026-06-13 03:21:35
1146	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:23:09	2026-06-13 03:23:09
1147	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	3	2026-06-13 03:23:12	2026-06-13 03:23:12
1148	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:23:13	2026-06-13 03:23:13
1149	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:23:39	2026-06-13 03:23:39
1150	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	3	2026-06-13 03:23:43	2026-06-13 03:23:43
1151	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	3	2026-06-13 03:23:45	2026-06-13 03:23:45
1152	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:23:50	2026-06-13 03:23:50
1153	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:24:16	2026-06-13 03:24:16
1154	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:24:32	2026-06-13 03:24:32
1155	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	3	2026-06-13 03:24:35	2026-06-13 03:24:35
1156	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:24:37	2026-06-13 03:24:37
1157	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-2212-lumi-blouse-blouse-tali-belakang-atasan-tali-belakang-bahan-polo-linen-qu5S	3	2026-06-13 03:24:40	2026-06-13 03:24:40
1158	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:24:42	2026-06-13 03:24:42
1159	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-polos-wanita-atasan-bahan-knit-halus-sweater-rajut-sweater-polos-rajut-SES0	3	2026-06-13 03:24:44	2026-06-13 03:24:44
1160	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-polos-wanita-atasan-bahan-knit-halus-sweater-rajut-sweater-polos-rajut-SES0	3	2026-06-13 03:25:16	2026-06-13 03:25:16
1161	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:25:18	2026-06-13 03:25:18
1162	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:25:20	2026-06-13 03:25:20
1163	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:25:22	2026-06-13 03:25:22
1164	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:25:32	2026-06-13 03:25:32
1165	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:25:41	2026-06-13 03:25:41
1166	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:25:44	2026-06-13 03:25:44
1167	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:25:46	2026-06-13 03:25:46
1168	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:25:49	2026-06-13 03:25:49
1169	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	3	2026-06-13 03:26:31	2026-06-13 03:26:31
1170	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:26:56	2026-06-13 03:26:56
1171	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:26:57	2026-06-13 03:26:57
1172	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:26:59	2026-06-13 03:26:59
1173	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/37	3	2026-06-13 03:27:32	2026-06-13 03:27:32
1174	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	3	2026-06-13 03:28:21	2026-06-13 03:28:21
1175	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/37	3	2026-06-13 03:28:25	2026-06-13 03:28:25
1176	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:28:38	2026-06-13 03:28:38
1177	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:28:41	2026-06-13 03:28:41
1178	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	3	2026-06-13 03:28:44	2026-06-13 03:28:44
1179	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	3	2026-06-13 03:28:46	2026-06-13 03:28:46
1180	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:28:47	2026-06-13 03:28:47
1181	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	3	2026-06-13 03:28:49	2026-06-13 03:28:49
1182	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:29:04	2026-06-13 03:29:04
1183	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:29:07	2026-06-13 03:29:07
1184	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:29:27	2026-06-13 03:29:27
1185	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	3	2026-06-13 03:29:29	2026-06-13 03:29:29
1186	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:29:38	2026-06-13 03:29:38
1187	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:29:39	2026-06-13 03:29:39
1188	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:29:40	2026-06-13 03:29:40
1189	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/38	3	2026-06-13 03:30:10	2026-06-13 03:30:10
1190	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/38	3	2026-06-13 03:30:23	2026-06-13 03:30:23
1191	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	3	2026-06-13 03:31:04	2026-06-13 03:31:04
1192	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:31:07	2026-06-13 03:31:07
1193	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	3	2026-06-13 03:31:20	2026-06-13 03:31:20
1194	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/38	3	2026-06-13 03:31:43	2026-06-13 03:31:43
1195	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/36	3	2026-06-13 03:31:50	2026-06-13 03:31:50
1196	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:31:59	2026-06-13 03:31:59
1197	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	3	2026-06-13 03:32:03	2026-06-13 03:32:03
1198	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	3	2026-06-13 03:32:15	2026-06-13 03:32:15
1199	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/35	3	2026-06-13 03:32:17	2026-06-13 03:32:17
1200	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	3	2026-06-13 03:32:21	2026-06-13 03:32:21
1201	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/36	3	2026-06-13 03:32:23	2026-06-13 03:32:23
1202	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	3	2026-06-13 03:32:37	2026-06-13 03:32:37
1203	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/38	3	2026-06-13 03:32:39	2026-06-13 03:32:39
1204	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/38	3	2026-06-13 03:32:43	2026-06-13 03:32:43
1205	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	3	2026-06-13 03:32:52	2026-06-13 03:32:52
1206	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/3ifdwBaLKPQ91773SzFrj0wh	\N	2026-06-13 03:33:12	2026-06-13 03:33:12
1207	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	3	2026-06-13 03:33:31	2026-06-13 03:33:31
1208	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/36	3	2026-06-13 03:33:32	2026-06-13 03:33:32
1209	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/3ifdwBaLKPQ91773SzFrj0wh	3	2026-06-13 03:33:33	2026-06-13 03:33:33
1210	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/36	3	2026-06-13 03:35:04	2026-06-13 03:35:04
1211	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/3ifdwBaLKPQ91773SzFrj0wh	3	2026-06-13 03:35:04	2026-06-13 03:35:04
1212	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/36	3	2026-06-13 03:35:43	2026-06-13 03:35:43
1213	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/3ifdwBaLKPQ91773SzFrj0wh	3	2026-06-13 03:35:44	2026-06-13 03:35:44
1214	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:35:51	2026-06-13 03:35:51
1215	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/3ifdwBaLKPQ91773SzFrj0wh	\N	2026-06-13 03:36:00	2026-06-13 03:36:00
1216	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	3	2026-06-13 03:36:04	2026-06-13 03:36:04
1217	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/38	3	2026-06-13 03:36:06	2026-06-13 03:36:06
1218	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/36	3	2026-06-13 03:36:09	2026-06-13 03:36:09
1219	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/3ifdwBaLKPQ91773SzFrj0wh	3	2026-06-13 03:36:09	2026-06-13 03:36:09
1220	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/36	3	2026-06-13 03:36:21	2026-06-13 03:36:21
1221	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/3ifdwBaLKPQ91773SzFrj0wh	3	2026-06-13 03:36:21	2026-06-13 03:36:21
1222	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:36:26	2026-06-13 03:36:26
1223	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:36:30	2026-06-13 03:36:30
1224	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	3	2026-06-13 03:37:14	2026-06-13 03:37:14
1225	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/36	3	2026-06-13 03:37:17	2026-06-13 03:37:17
1226	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/3ifdwBaLKPQ91773SzFrj0wh	3	2026-06-13 03:37:17	2026-06-13 03:37:17
1227	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:38:24	2026-06-13 03:38:24
1228	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:38:34	2026-06-13 03:38:34
1229	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:38:45	2026-06-13 03:38:45
1230	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:38:46	2026-06-13 03:38:46
1231	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	3	2026-06-13 03:38:48	2026-06-13 03:38:48
1232	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:38:53	2026-06-13 03:38:53
1233	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:39:16	2026-06-13 03:39:16
1234	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:39:58	2026-06-13 03:39:58
1235	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	3	2026-06-13 03:39:59	2026-06-13 03:39:59
1236	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:40:26	2026-06-13 03:40:26
1237	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	3	2026-06-13 03:40:28	2026-06-13 03:40:28
1238	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/39	3	2026-06-13 03:40:33	2026-06-13 03:40:33
1239	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	3	2026-06-13 03:40:35	2026-06-13 03:40:35
1240	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/39	3	2026-06-13 03:40:38	2026-06-13 03:40:38
1241	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/39	3	2026-06-13 03:40:40	2026-06-13 03:40:40
1242	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/39	3	2026-06-13 03:41:25	2026-06-13 03:41:25
1243	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/R0Ad4iJET0MKZtKPJxWJqFIo	\N	2026-06-13 03:42:08	2026-06-13 03:42:08
1244	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/39	3	2026-06-13 03:42:28	2026-06-13 03:42:28
1245	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/R0Ad4iJET0MKZtKPJxWJqFIo	3	2026-06-13 03:42:29	2026-06-13 03:42:29
1246	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/39	3	2026-06-13 03:43:54	2026-06-13 03:43:54
1247	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/R0Ad4iJET0MKZtKPJxWJqFIo	3	2026-06-13 03:43:55	2026-06-13 03:43:55
1248	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/R0Ad4iJET0MKZtKPJxWJqFIo	\N	2026-06-13 03:44:00	2026-06-13 03:44:00
1249	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/R0Ad4iJET0MKZtKPJxWJqFIo	\N	2026-06-13 03:44:04	2026-06-13 03:44:04
1250	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/39	3	2026-06-13 03:44:07	2026-06-13 03:44:07
1251	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/R0Ad4iJET0MKZtKPJxWJqFIo	3	2026-06-13 03:44:07	2026-06-13 03:44:07
1252	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/39	3	2026-06-13 03:44:19	2026-06-13 03:44:19
1253	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/R0Ad4iJET0MKZtKPJxWJqFIo	3	2026-06-13 03:44:19	2026-06-13 03:44:19
1254	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:44:24	2026-06-13 03:44:24
1255	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:44:28	2026-06-13 03:44:28
1256	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	3	2026-06-13 03:45:00	2026-06-13 03:45:00
1257	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:45:05	2026-06-13 03:45:05
1258	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:45:07	2026-06-13 03:45:07
1259	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/5	3	2026-06-13 03:45:09	2026-06-13 03:45:09
1260	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/5	3	2026-06-13 03:45:19	2026-06-13 03:45:19
1261	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/5	3	2026-06-13 03:45:34	2026-06-13 03:45:34
1262	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:46:09	2026-06-13 03:46:09
1263	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:46:32	2026-06-13 03:46:32
1264	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	notifications/160/read	3	2026-06-13 03:46:39	2026-06-13 03:46:39
1265	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/39	\N	2026-06-13 03:46:39	2026-06-13 03:46:39
1266	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-13 03:46:39	2026-06-13 03:46:39
1267	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:46:55	2026-06-13 03:46:55
1268	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	notifications/160/read	3	2026-06-13 03:46:57	2026-06-13 03:46:57
1269	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/39	3	2026-06-13 03:46:57	2026-06-13 03:46:57
1270	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/R0Ad4iJET0MKZtKPJxWJqFIo	3	2026-06-13 03:46:58	2026-06-13 03:46:58
1271	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/39	3	2026-06-13 03:47:04	2026-06-13 03:47:04
1272	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/R0Ad4iJET0MKZtKPJxWJqFIo	3	2026-06-13 03:47:05	2026-06-13 03:47:05
1273	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	3	2026-06-13 03:47:06	2026-06-13 03:47:06
1274	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:47:08	2026-06-13 03:47:08
1275	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:47:12	2026-06-13 03:47:12
1276	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:47:17	2026-06-13 03:47:17
1277	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	3	2026-06-13 03:47:44	2026-06-13 03:47:44
1278	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:47:44	2026-06-13 03:47:44
1279	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	3	2026-06-13 03:47:46	2026-06-13 03:47:46
1280	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:47:46	2026-06-13 03:47:46
1281	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	3	2026-06-13 03:47:57	2026-06-13 03:47:57
1282	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	3	2026-06-13 03:47:59	2026-06-13 03:47:59
1283	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	3	2026-06-13 03:48:00	2026-06-13 03:48:00
1284	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	3	2026-06-13 03:48:01	2026-06-13 03:48:01
1285	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	3	2026-06-13 03:48:03	2026-06-13 03:48:03
1286	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	3	2026-06-13 03:48:04	2026-06-13 03:48:04
1287	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/40	3	2026-06-13 03:49:29	2026-06-13 03:49:29
1288	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/40	3	2026-06-13 03:49:55	2026-06-13 03:49:55
1289	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/40	3	2026-06-13 03:49:57	2026-06-13 03:49:57
1290	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/40	3	2026-06-13 03:50:40	2026-06-13 03:50:40
1291	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/40	3	2026-06-13 03:51:04	2026-06-13 03:51:04
1292	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/40	3	2026-06-13 03:51:29	2026-06-13 03:51:29
1293	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/40	3	2026-06-13 03:51:39	2026-06-13 03:51:39
1294	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:51:42	2026-06-13 03:51:42
1295	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	3	2026-06-13 03:51:45	2026-06-13 03:51:45
1296	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:54:13	2026-06-13 03:54:13
1297	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	3	2026-06-13 03:54:16	2026-06-13 03:54:16
1298	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	3	2026-06-13 03:54:18	2026-06-13 03:54:18
1299	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	3	2026-06-13 03:54:18	2026-06-13 03:54:18
1300	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/5	3	2026-06-13 03:54:20	2026-06-13 03:54:20
1301	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:54:22	2026-06-13 03:54:22
1302	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	3	2026-06-13 03:54:26	2026-06-13 03:54:26
1303	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	3	2026-06-13 03:54:31	2026-06-13 03:54:31
1304	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 02:53:47	2026-06-14 02:53:47
1305	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 04:02:15	2026-06-14 04:02:15
1306	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 04:05:39	2026-06-14 04:05:39
1307	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 04:05:50	2026-06-14 04:05:50
1308	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 04:05:51	2026-06-14 04:05:51
1309	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:05:53	2026-06-14 04:05:53
1310	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 04:05:59	2026-06-14 04:05:59
1311	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:06:01	2026-06-14 04:06:01
1312	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-14 04:06:04	2026-06-14 04:06:04
1313	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	\N	2026-06-14 04:06:06	2026-06-14 04:06:06
1314	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	\N	2026-06-14 04:08:01	2026-06-14 04:08:01
1315	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:08:06	2026-06-14 04:08:06
1316	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:08:11	2026-06-14 04:08:11
1317	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:11:25	2026-06-14 04:11:25
1318	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:11:38	2026-06-14 04:11:38
1319	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:18:03	2026-06-14 04:18:03
1320	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:19:15	2026-06-14 04:19:15
1321	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:21:28	2026-06-14 04:21:28
1322	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:23:23	2026-06-14 04:23:23
1323	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:23:32	2026-06-14 04:23:32
1324	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:27:27	2026-06-14 04:27:27
1325	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	\N	2026-06-14 04:28:53	2026-06-14 04:28:53
1326	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:28:55	2026-06-14 04:28:55
1327	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-polos-wanita-atasan-bahan-knit-halus-sweater-rajut-sweater-polos-rajut-SES0	\N	2026-06-14 04:28:58	2026-06-14 04:28:58
1328	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:29:03	2026-06-14 04:29:03
1329	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:32:16	2026-06-14 04:32:16
1330	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:32:33	2026-06-14 04:32:33
1331	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 04:32:37	2026-06-14 04:32:37
1332	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:34:06	2026-06-14 04:34:06
1333	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:34:49	2026-06-14 04:34:49
1334	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:37:15	2026-06-14 04:37:15
1335	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:37:26	2026-06-14 04:37:26
1336	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:37:39	2026-06-14 04:37:39
1337	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:38:02	2026-06-14 04:38:02
1338	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:38:12	2026-06-14 04:38:12
1339	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:38:22	2026-06-14 04:38:22
1340	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:38:28	2026-06-14 04:38:28
1341	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:40:30	2026-06-14 04:40:30
1342	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:40:45	2026-06-14 04:40:45
1343	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:41:59	2026-06-14 04:41:59
1344	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:49:15	2026-06-14 04:49:15
1345	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	\N	2026-06-14 04:49:22	2026-06-14 04:49:22
1346	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	\N	2026-06-14 04:49:24	2026-06-14 04:49:24
1347	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan-muslim-wanita	\N	2026-06-14 04:49:26	2026-06-14 04:49:26
1348	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/sweater-cardigan	\N	2026-06-14 04:49:27	2026-06-14 04:49:27
1349	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	\N	2026-06-14 04:49:28	2026-06-14 04:49:28
1350	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:49:30	2026-06-14 04:49:30
1351	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	\N	2026-06-14 04:49:33	2026-06-14 04:49:33
1352	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	\N	2026-06-14 04:49:36	2026-06-14 04:49:36
1353	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan-muslim-wanita	\N	2026-06-14 04:49:38	2026-06-14 04:49:38
1354	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:49:39	2026-06-14 04:49:39
1355	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:49:42	2026-06-14 04:49:42
1356	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	\N	2026-06-14 04:49:46	2026-06-14 04:49:46
1357	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:50:12	2026-06-14 04:50:12
1358	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:50:15	2026-06-14 04:50:15
1359	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:50:58	2026-06-14 04:50:58
1360	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	\N	2026-06-14 04:51:00	2026-06-14 04:51:00
1361	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	\N	2026-06-14 04:51:02	2026-06-14 04:51:02
1362	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan-muslim-wanita	\N	2026-06-14 04:51:03	2026-06-14 04:51:03
1363	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/sweater-cardigan	\N	2026-06-14 04:51:04	2026-06-14 04:51:04
1364	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	\N	2026-06-14 04:51:06	2026-06-14 04:51:06
1365	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-14 04:51:07	2026-06-14 04:51:07
1366	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:51:13	2026-06-14 04:51:13
1367	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:52:28	2026-06-14 04:52:28
1368	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:52:38	2026-06-14 04:52:38
1369	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-14 04:53:37	2026-06-14 04:53:37
1370	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	\N	2026-06-14 04:53:57	2026-06-14 04:53:57
1371	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:54:08	2026-06-14 04:54:08
1372	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 04:58:01	2026-06-14 04:58:01
1373	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 05:01:34	2026-06-14 05:01:34
1374	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 05:01:56	2026-06-14 05:01:56
1375	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-14 05:02:16	2026-06-14 05:02:16
1376	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 05:02:24	2026-06-14 05:02:24
1377	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-14 05:02:28	2026-06-14 05:02:28
1378	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 05:02:29	2026-06-14 05:02:29
1379	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-14 05:02:38	2026-06-14 05:02:38
1380	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 05:02:38	2026-06-14 05:02:38
1381	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-14 05:02:40	2026-06-14 05:02:40
1382	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 05:02:40	2026-06-14 05:02:40
1383	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-14 05:02:43	2026-06-14 05:02:43
1384	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 05:02:43	2026-06-14 05:02:43
1385	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 05:05:32	2026-06-14 05:05:32
1386	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 05:05:54	2026-06-14 05:05:54
1387	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-14 05:06:42	2026-06-14 05:06:42
1388	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-14 05:07:01	2026-06-14 05:07:01
1389	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-14 05:07:20	2026-06-14 05:07:20
1390	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	1	2026-06-14 05:07:45	2026-06-14 05:07:45
1391	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-14 05:07:52	2026-06-14 05:07:52
1392	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-14 05:09:06	2026-06-14 05:09:06
1393	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	1	2026-06-14 05:09:08	2026-06-14 05:09:08
1394	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-14 05:09:11	2026-06-14 05:09:11
1395	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	1	2026-06-14 05:09:11	2026-06-14 05:09:11
1396	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	1	2026-06-14 05:09:25	2026-06-14 05:09:25
1397	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-14 05:09:28	2026-06-14 05:09:28
1398	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-14 05:09:42	2026-06-14 05:09:42
1399	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-14 05:12:57	2026-06-14 05:12:57
1400	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-14 05:43:48	2026-06-14 05:43:48
1401	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-14 05:44:49	2026-06-14 05:44:49
1402	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-14 05:44:52	2026-06-14 05:44:52
1403	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-14 05:45:32	2026-06-14 05:45:32
1404	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-14 05:45:51	2026-06-14 05:45:51
1405	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-14 05:46:02	2026-06-14 05:46:02
1406	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-14 05:48:40	2026-06-14 05:48:40
1407	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-14 05:48:43	2026-06-14 05:48:43
1408	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-14 05:48:59	2026-06-14 05:48:59
1409	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-14 05:48:59	2026-06-14 05:48:59
1410	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-14 05:49:07	2026-06-14 05:49:07
1411	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-14 05:49:07	2026-06-14 05:49:07
1412	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-14 05:49:09	2026-06-14 05:49:09
1413	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-14 05:49:12	2026-06-14 05:49:12
1414	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-14 05:49:19	2026-06-14 05:49:19
1415	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-14 05:49:23	2026-06-14 05:49:23
1416	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-14 05:49:25	2026-06-14 05:49:25
1417	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	1	2026-06-14 05:49:27	2026-06-14 05:49:27
1418	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	1	2026-06-14 05:49:30	2026-06-14 05:49:30
1419	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-14 05:49:31	2026-06-14 05:49:31
1420	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-14 05:49:33	2026-06-14 05:49:33
1421	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-14 05:49:36	2026-06-14 05:49:36
1422	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-14 05:52:39	2026-06-14 05:52:39
1423	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-14 06:58:43	2026-06-14 06:58:43
1424	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:32:30	2026-06-15 05:32:30
1425	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-15 05:33:16	2026-06-15 05:33:16
1426	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:33:17	2026-06-15 05:33:17
1427	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:33:31	2026-06-15 05:33:31
1428	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:33:37	2026-06-15 05:33:37
1429	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:33:46	2026-06-15 05:33:46
1430	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-15 05:35:32	2026-06-15 05:35:32
1431	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-2212-lumi-blouse-blouse-tali-belakang-atasan-tali-belakang-bahan-polo-linen-qu5S	\N	2026-06-15 05:35:39	2026-06-15 05:35:39
1432	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-15 05:36:24	2026-06-15 05:36:24
1433	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:36:32	2026-06-15 05:36:32
1434	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	\N	2026-06-15 05:36:34	2026-06-15 05:36:34
1435	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:36:40	2026-06-15 05:36:40
1436	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 05:36:56	2026-06-15 05:36:56
1437	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 05:37:03	2026-06-15 05:37:03
1438	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-15 05:37:07	2026-06-15 05:37:07
1439	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-15 05:37:09	2026-06-15 05:37:09
1440	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 05:37:11	2026-06-15 05:37:11
1441	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 05:37:13	2026-06-15 05:37:13
1442	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 05:37:50	2026-06-15 05:37:50
1443	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-15 05:37:54	2026-06-15 05:37:54
1444	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 05:37:54	2026-06-15 05:37:54
1445	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-15 05:37:56	2026-06-15 05:37:56
1446	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 05:37:57	2026-06-15 05:37:57
1447	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-15 05:38:01	2026-06-15 05:38:01
1448	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 05:38:01	2026-06-15 05:38:01
1449	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	register	\N	2026-06-15 05:38:03	2026-06-15 05:38:03
1450	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 05:38:07	2026-06-15 05:38:07
1451	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-15 05:38:09	2026-06-15 05:38:09
1452	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 05:38:09	2026-06-15 05:38:09
1453	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:38:11	2026-06-15 05:38:11
1454	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-15 05:38:26	2026-06-15 05:38:26
1455	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 05:38:30	2026-06-15 05:38:30
1456	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 05:38:38	2026-06-15 05:38:38
1457	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-15 05:39:48	2026-06-15 05:39:48
1458	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	\N	2026-06-15 05:39:56	2026-06-15 05:39:56
1459	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	\N	2026-06-15 05:40:15	2026-06-15 05:40:15
1460	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:40:24	2026-06-15 05:40:24
1461	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	\N	2026-06-15 05:40:39	2026-06-15 05:40:39
1462	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	\N	2026-06-15 05:40:40	2026-06-15 05:40:40
1463	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan-muslim-wanita	\N	2026-06-15 05:40:42	2026-06-15 05:40:42
1464	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/sweater-cardigan	\N	2026-06-15 05:40:43	2026-06-15 05:40:43
1465	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-15 05:40:44	2026-06-15 05:40:44
1466	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	\N	2026-06-15 05:40:47	2026-06-15 05:40:47
1467	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:40:50	2026-06-15 05:40:50
1468	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	\N	2026-06-15 05:40:57	2026-06-15 05:40:57
1469	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan-muslim-wanita	\N	2026-06-15 05:40:59	2026-06-15 05:40:59
1470	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-15 05:41:01	2026-06-15 05:41:01
1471	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:41:09	2026-06-15 05:41:09
1472	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tentang-kami	\N	2026-06-15 05:41:14	2026-06-15 05:41:14
1473	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	\N	2026-06-15 05:41:18	2026-06-15 05:41:18
1474	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:46:07	2026-06-15 05:46:07
1475	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:46:14	2026-06-15 05:46:14
1476	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:46:36	2026-06-15 05:46:36
1477	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:46:49	2026-06-15 05:46:49
1478	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 05:47:00	2026-06-15 05:47:00
1479	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-15 05:47:02	2026-06-15 05:47:02
1480	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 05:47:02	2026-06-15 05:47:02
1481	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-15 05:47:06	2026-06-15 05:47:06
1482	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 05:47:06	2026-06-15 05:47:06
1483	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 05:49:03	2026-06-15 05:49:03
1484	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-15 05:49:08	2026-06-15 05:49:08
1485	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-15 05:51:29	2026-06-15 05:51:29
1486	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-15 05:52:16	2026-06-15 05:52:16
1487	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-15 05:52:20	2026-06-15 05:52:20
1488	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 05:52:23	2026-06-15 05:52:23
1489	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 05:52:35	2026-06-15 05:52:35
1490	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 05:52:56	2026-06-15 05:52:56
1491	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 05:52:58	2026-06-15 05:52:58
1492	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 06:56:20	2026-06-15 06:56:20
1493	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 06:56:25	2026-06-15 06:56:25
1494	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 06:56:37	2026-06-15 06:56:37
1495	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 06:56:57	2026-06-15 06:56:57
1496	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 06:57:01	2026-06-15 06:57:01
1497	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-15 06:57:11	2026-06-15 06:57:11
1498	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-15 06:57:14	2026-06-15 06:57:14
1499	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 06:57:17	2026-06-15 06:57:17
1500	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 06:57:18	2026-06-15 06:57:18
1501	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 06:57:43	2026-06-15 06:57:43
1502	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 06:58:07	2026-06-15 06:58:07
1503	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 06:58:11	2026-06-15 06:58:11
1504	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 06:58:29	2026-06-15 06:58:29
1505	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 06:58:38	2026-06-15 06:58:38
1506	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-15 07:03:30	2026-06-15 07:03:30
1507	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 07:03:30	2026-06-15 07:03:30
1508	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-15 07:03:33	2026-06-15 07:03:33
1509	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 07:03:33	2026-06-15 07:03:33
1510	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 07:04:22	2026-06-15 07:04:22
1511	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-15 07:04:39	2026-06-15 07:04:39
1512	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 07:04:40	2026-06-15 07:04:40
1513	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 07:05:04	2026-06-15 07:05:04
1514	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:08:45	2026-06-15 07:08:45
1515	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:11:36	2026-06-15 07:11:36
1516	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:11:59	2026-06-15 07:11:59
1517	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:13:23	2026-06-15 07:13:23
1518	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:13:43	2026-06-15 07:13:43
1519	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:13:50	2026-06-15 07:13:50
1520	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:15:50	2026-06-15 07:15:50
1521	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:15:54	2026-06-15 07:15:54
1522	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:15:56	2026-06-15 07:15:56
1523	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:15:57	2026-06-15 07:15:57
1524	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-15 07:16:01	2026-06-15 07:16:01
1525	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:16:04	2026-06-15 07:16:04
1526	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-15 07:16:07	2026-06-15 07:16:07
1527	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:16:13	2026-06-15 07:16:13
1528	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:16:15	2026-06-15 07:16:15
1529	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 07:16:17	2026-06-15 07:16:17
1530	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-15 07:16:20	2026-06-15 07:16:20
1531	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-15 07:16:23	2026-06-15 07:16:23
1532	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:16:25	2026-06-15 07:16:25
1533	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 07:16:32	2026-06-15 07:16:32
1534	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 07:17:24	2026-06-15 07:17:24
1535	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/41	1	2026-06-15 07:17:38	2026-06-15 07:17:38
1536	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/6	1	2026-06-15 07:17:45	2026-06-15 07:17:45
1537	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/6	1	2026-06-15 07:18:24	2026-06-15 07:18:24
1538	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 07:18:35	2026-06-15 07:18:35
1539	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/41	1	2026-06-15 07:21:43	2026-06-15 07:21:43
1540	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/41	1	2026-06-15 07:22:10	2026-06-15 07:22:10
1541	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/41	1	2026-06-15 07:22:22	2026-06-15 07:22:22
1542	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/41	1	2026-06-15 07:23:20	2026-06-15 07:23:20
1543	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/41	1	2026-06-15 07:24:57	2026-06-15 07:24:57
1544	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 07:26:50	2026-06-15 07:26:50
1545	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 07:28:22	2026-06-15 07:28:22
1546	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 07:28:25	2026-06-15 07:28:25
1547	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 07:29:00	2026-06-15 07:29:00
1548	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 07:29:14	2026-06-15 07:29:14
1549	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 07:29:57	2026-06-15 07:29:57
1550	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	notifications/169/read	1	2026-06-15 07:30:32	2026-06-15 07:30:32
1551	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/7	1	2026-06-15 07:30:32	2026-06-15 07:30:32
1552	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	notifications/169/read	1	2026-06-15 07:30:36	2026-06-15 07:30:36
1553	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/7	1	2026-06-15 07:30:36	2026-06-15 07:30:36
1554	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 07:30:42	2026-06-15 07:30:42
1555	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/11	1	2026-06-15 07:30:43	2026-06-15 07:30:43
1556	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/11	1	2026-06-15 07:31:12	2026-06-15 07:31:12
1557	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-15 07:31:18	2026-06-15 07:31:18
1558	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/41	1	2026-06-15 07:31:20	2026-06-15 07:31:20
1559	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/11	1	2026-06-15 07:31:21	2026-06-15 07:31:21
1560	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 07:31:36	2026-06-15 07:31:36
1561	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/11	1	2026-06-15 07:31:38	2026-06-15 07:31:38
1562	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 07:31:42	2026-06-15 07:31:42
1563	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 07:33:06	2026-06-15 07:33:06
1564	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 07:33:10	2026-06-15 07:33:10
1565	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/11	1	2026-06-15 07:33:13	2026-06-15 07:33:13
1566	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 07:33:16	2026-06-15 07:33:16
1567	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	notifications/169/read	1	2026-06-15 07:33:17	2026-06-15 07:33:17
1568	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/7	1	2026-06-15 07:33:18	2026-06-15 07:33:18
1569	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 07:37:01	2026-06-15 07:37:01
1570	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	notifications/169/read	1	2026-06-15 07:37:05	2026-06-15 07:37:05
1571	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/7	1	2026-06-15 07:37:05	2026-06-15 07:37:05
1572	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 07:37:11	2026-06-15 07:37:11
1573	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 07:37:18	2026-06-15 07:37:18
1574	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 07:37:33	2026-06-15 07:37:33
1575	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 07:37:42	2026-06-15 07:37:42
1576	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 07:38:05	2026-06-15 07:38:05
1577	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	notifications/170/read	1	2026-06-15 07:38:09	2026-06-15 07:38:09
1578	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/11	1	2026-06-15 07:38:09	2026-06-15 07:38:09
1579	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	1	2026-06-15 07:38:25	2026-06-15 07:38:25
1580	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 07:49:02	2026-06-15 07:49:02
1581	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 07:56:16	2026-06-15 07:56:16
1582	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	\N	2026-06-15 07:56:19	2026-06-15 07:56:19
1583	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 07:56:21	2026-06-15 07:56:21
1625	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/jaket-3Cvt	1	2026-06-15 10:53:39	2026-06-15 10:53:39
1584	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-15 08:01:02	2026-06-15 08:01:02
1585	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-15 08:05:36	2026-06-15 08:05:36
1586	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 08:05:38	2026-06-15 08:05:38
1587	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	\N	2026-06-15 08:05:45	2026-06-15 08:05:45
1588	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 08:06:05	2026-06-15 08:06:05
1589	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 08:06:08	2026-06-15 08:06:08
1590	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 08:06:41	2026-06-15 08:06:41
1591	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	\N	2026-06-15 08:06:42	2026-06-15 08:06:42
1592	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 08:06:50	2026-06-15 08:06:50
1593	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	/	\N	2026-06-15 08:07:29	2026-06-15 08:07:29
1594	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 08:07:50	2026-06-15 08:07:50
1595	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 09:48:19	2026-06-15 09:48:19
1596	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 10:18:08	2026-06-15 10:18:08
1597	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 10:18:20	2026-06-15 10:18:20
1598	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	\N	2026-06-15 10:33:16	2026-06-15 10:33:16
1599	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 10:34:03	2026-06-15 10:34:03
1600	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-15 10:38:27	2026-06-15 10:38:27
1601	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-15 10:39:41	2026-06-15 10:39:41
1602	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/jaket-3Cvt	\N	2026-06-15 10:39:46	2026-06-15 10:39:46
1603	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-15 10:40:06	2026-06-15 10:40:06
1604	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 10:40:19	2026-06-15 10:40:19
1605	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/jaket-3Cvt	1	2026-06-15 10:40:23	2026-06-15 10:40:23
1606	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 10:41:41	2026-06-15 10:41:41
1607	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 10:44:20	2026-06-15 10:44:20
1608	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	1	2026-06-15 10:44:30	2026-06-15 10:44:30
1609	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 10:44:36	2026-06-15 10:44:36
1610	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	1	2026-06-15 10:45:28	2026-06-15 10:45:28
1611	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 10:45:34	2026-06-15 10:45:34
1612	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-15 10:51:15	2026-06-15 10:51:15
1613	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 10:51:16	2026-06-15 10:51:16
1614	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-15 10:51:55	2026-06-15 10:51:55
1615	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 10:51:56	2026-06-15 10:51:56
1616	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	1	2026-06-15 10:52:04	2026-06-15 10:52:04
1617	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	1	2026-06-15 10:52:08	2026-06-15 10:52:08
1618	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/black-blouse-dFCP	1	2026-06-15 10:52:16	2026-06-15 10:52:16
1619	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 10:52:20	2026-06-15 10:52:20
1620	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	1	2026-06-15 10:52:24	2026-06-15 10:52:24
1621	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 10:52:32	2026-06-15 10:52:32
1622	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	1	2026-06-15 10:53:09	2026-06-15 10:53:09
1623	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/jaket-3Cvt	1	2026-06-15 10:53:12	2026-06-15 10:53:12
1624	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	1	2026-06-15 10:53:35	2026-06-15 10:53:35
1626	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/jaket-3Cvt	1	2026-06-15 10:53:44	2026-06-15 10:53:44
1627	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 10:53:59	2026-06-15 10:53:59
1628	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 10:54:05	2026-06-15 10:54:05
1629	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:54:21	2026-06-15 10:54:21
1630	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:54:26	2026-06-15 10:54:26
1631	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:54:28	2026-06-15 10:54:28
1632	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:54:30	2026-06-15 10:54:30
1633	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:54:32	2026-06-15 10:54:32
1634	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 10:54:35	2026-06-15 10:54:35
1635	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 10:55:01	2026-06-15 10:55:01
1636	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:55:08	2026-06-15 10:55:08
1637	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:55:10	2026-06-15 10:55:10
1638	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 10:55:13	2026-06-15 10:55:13
1639	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 10:56:01	2026-06-15 10:56:01
1640	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:56:08	2026-06-15 10:56:08
1641	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:56:11	2026-06-15 10:56:11
1642	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 10:56:17	2026-06-15 10:56:17
1643	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:57:40	2026-06-15 10:57:40
1644	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:57:44	2026-06-15 10:57:44
1645	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:57:47	2026-06-15 10:57:47
1646	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:57:49	2026-06-15 10:57:49
1647	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:57:51	2026-06-15 10:57:51
1648	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:57:58	2026-06-15 10:57:58
1649	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 10:58:02	2026-06-15 10:58:02
1650	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:58:17	2026-06-15 10:58:17
1651	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:58:18	2026-06-15 10:58:18
1652	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:58:33	2026-06-15 10:58:33
1653	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 10:58:35	2026-06-15 10:58:35
1654	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 10:58:37	2026-06-15 10:58:37
1655	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-15 10:59:37	2026-06-15 10:59:37
1656	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 10:59:38	2026-06-15 10:59:38
1657	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/42	1	2026-06-15 11:01:12	2026-06-15 11:01:12
1658	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/42	1	2026-06-15 11:02:35	2026-06-15 11:02:35
1659	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/42	1	2026-06-15 11:02:42	2026-06-15 11:02:42
1660	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/42	1	2026-06-15 11:04:02	2026-06-15 11:04:02
1661	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/42	1	2026-06-15 11:04:37	2026-06-15 11:04:37
1662	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-15 11:05:16	2026-06-15 11:05:16
1663	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/42	1	2026-06-15 11:05:26	2026-06-15 11:05:26
1664	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/42	1	2026-06-15 11:05:38	2026-06-15 11:05:38
1665	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 11:05:41	2026-06-15 11:05:41
1666	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/jaket-3Cvt	1	2026-06-15 11:05:44	2026-06-15 11:05:44
1667	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/jaket-3Cvt	1	2026-06-15 11:41:29	2026-06-15 11:41:29
1668	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 11:41:31	2026-06-15 11:41:31
1669	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 11:41:33	2026-06-15 11:41:33
1670	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/43	1	2026-06-15 11:41:52	2026-06-15 11:41:52
1671	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 11:42:23	2026-06-15 11:42:23
1672	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 11:42:26	2026-06-15 11:42:26
1673	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/11	1	2026-06-15 11:42:28	2026-06-15 11:42:28
1674	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 11:43:52	2026-06-15 11:43:52
1675	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 11:44:37	2026-06-15 11:44:37
1676	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:03:16	2026-06-15 12:03:16
1677	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 12:03:21	2026-06-15 12:03:21
1678	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 12:03:26	2026-06-15 12:03:26
1679	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/11	1	2026-06-15 12:03:28	2026-06-15 12:03:28
1680	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:05:53	2026-06-15 12:05:53
1681	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:06:04	2026-06-15 12:06:04
1682	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:07:48	2026-06-15 12:07:48
1683	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:09:05	2026-06-15 12:09:05
1684	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:09:47	2026-06-15 12:09:47
1685	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:10:56	2026-06-15 12:10:56
1686	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:11:49	2026-06-15 12:11:49
1687	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:11:53	2026-06-15 12:11:53
1688	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:13:54	2026-06-15 12:13:54
1689	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-15 12:14:26	2026-06-15 12:14:26
1690	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/11	1	2026-06-15 12:14:29	2026-06-15 12:14:29
1691	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	products/basariid-hara-tunik-bahan-tencel-bordir-baju-formal-baju-undangan-raya-tunik-qyCN	1	2026-06-15 12:22:56	2026-06-15 12:22:56
1692	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-15 12:23:42	2026-06-15 12:23:42
1693	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	category/atasan	1	2026-06-15 12:23:47	2026-06-15 12:23:47
1694	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-15 12:23:54	2026-06-15 12:23:54
1695	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	products/jaket-3Cvt	1	2026-06-15 12:24:10	2026-06-15 12:24:10
1696	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	products/jaket-3Cvt	1	2026-06-15 12:24:14	2026-06-15 12:24:14
1697	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	cart	1	2026-06-15 12:24:18	2026-06-15 12:24:18
1698	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	checkout	1	2026-06-15 12:24:20	2026-06-15 12:24:20
1699	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-15 12:24:32	2026-06-15 12:24:32
1700	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	chat	1	2026-06-15 12:24:39	2026-06-15 12:24:39
1701	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	chat/11	1	2026-06-15 12:24:41	2026-06-15 12:24:41
1702	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	chat	1	2026-06-15 12:24:49	2026-06-15 12:24:49
1703	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-15 12:24:50	2026-06-15 12:24:50
1704	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	category/outwear	1	2026-06-15 12:28:02	2026-06-15 12:28:02
1705	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	category/outwear	1	2026-06-15 12:28:06	2026-06-15 12:28:06
1706	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:32:51	2026-06-15 12:32:51
1707	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:41:11	2026-06-15 12:41:11
1708	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:41:31	2026-06-15 12:41:31
1709	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:41:40	2026-06-15 12:41:40
1710	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:41:41	2026-06-15 12:41:41
1711	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:41:47	2026-06-15 12:41:47
1712	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:41:48	2026-06-15 12:41:48
1713	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:42:16	2026-06-15 12:42:16
1714	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:42:17	2026-06-15 12:42:17
1715	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:43:26	2026-06-15 12:43:26
1716	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:43:47	2026-06-15 12:43:47
1717	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 12:45:05	2026-06-15 12:45:05
1718	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 12:45:07	2026-06-15 12:45:07
1719	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 12:45:12	2026-06-15 12:45:12
1720	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 12:45:13	2026-06-15 12:45:13
1721	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 12:45:18	2026-06-15 12:45:18
1722	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	checkout	1	2026-06-15 12:46:54	2026-06-15 12:46:54
1723	127.0.0.1	Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36	shipping/search-location	1	2026-06-15 12:47:10	2026-06-15 12:47:10
1724	127.0.0.1	Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36	checkout	1	2026-06-15 12:47:18	2026-06-15 12:47:18
1725	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 12:51:08	2026-06-15 12:51:08
1726	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-15 12:51:18	2026-06-15 12:51:18
1727	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-15 12:51:21	2026-06-15 12:51:21
1728	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:51:46	2026-06-15 12:51:46
1729	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:53:57	2026-06-15 12:53:57
1730	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:53:58	2026-06-15 12:53:58
1731	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:55:00	2026-06-15 12:55:00
1732	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:55:01	2026-06-15 12:55:01
1733	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:55:18	2026-06-15 12:55:18
1734	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:55:32	2026-06-15 12:55:32
1735	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:55:51	2026-06-15 12:55:51
1736	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:55:52	2026-06-15 12:55:52
1737	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:56:03	2026-06-15 12:56:03
1738	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:56:04	2026-06-15 12:56:04
1739	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:57:20	2026-06-15 12:57:20
1740	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:57:36	2026-06-15 12:57:36
1741	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:57:37	2026-06-15 12:57:37
1742	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:57:38	2026-06-15 12:57:38
1743	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:58:11	2026-06-15 12:58:11
1744	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:58:36	2026-06-15 12:58:36
1745	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:58:37	2026-06-15 12:58:37
1746	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 12:59:11	2026-06-15 12:59:11
1747	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:00:10	2026-06-15 13:00:10
1748	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:03:07	2026-06-15 13:03:07
1749	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:03:33	2026-06-15 13:03:33
1750	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 13:08:20	2026-06-15 13:08:20
1751	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-15 13:08:22	2026-06-15 13:08:22
1752	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:08:25	2026-06-15 13:08:25
1753	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:11:00	2026-06-15 13:11:00
1754	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:11:01	2026-06-15 13:11:01
1755	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:11:14	2026-06-15 13:11:14
1756	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:11:15	2026-06-15 13:11:15
1757	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:11:25	2026-06-15 13:11:25
1758	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:11:26	2026-06-15 13:11:26
1759	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:11:49	2026-06-15 13:11:49
1760	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:11:50	2026-06-15 13:11:50
1761	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:11:57	2026-06-15 13:11:57
1762	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:11:57	2026-06-15 13:11:57
1763	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:12:41	2026-06-15 13:12:41
1764	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:12:54	2026-06-15 13:12:54
1765	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:13:05	2026-06-15 13:13:05
1766	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:13:14	2026-06-15 13:13:14
1767	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:13:24	2026-06-15 13:13:24
1768	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:17:23	2026-06-15 13:17:23
1769	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:18:24	2026-06-15 13:18:24
1770	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:19:06	2026-06-15 13:19:06
1771	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:19:19	2026-06-15 13:19:19
1772	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:19:20	2026-06-15 13:19:20
1773	127.0.0.1	Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36	/	1	2026-06-15 13:25:06	2026-06-15 13:25:06
1774	127.0.0.1	Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36	/	1	2026-06-15 13:25:09	2026-06-15 13:25:09
1775	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:27:28	2026-06-15 13:27:28
1776	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:27:30	2026-06-15 13:27:30
1777	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:27:35	2026-06-15 13:27:35
1778	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:27:40	2026-06-15 13:27:40
1779	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:28:10	2026-06-15 13:28:10
1780	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:28:12	2026-06-15 13:28:12
1781	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-15 13:28:25	2026-06-15 13:28:25
1782	127.0.0.1	Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36	/	1	2026-06-15 13:31:02	2026-06-15 13:31:02
1783	127.0.0.1	Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36	/	1	2026-06-15 13:31:13	2026-06-15 13:31:13
1784	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 03:41:05	2026-06-16 03:41:05
1785	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-16 03:41:50	2026-06-16 03:41:50
1786	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-16 03:41:50	2026-06-16 03:41:50
1787	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 03:41:51	2026-06-16 03:41:51
1788	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-16 03:41:52	2026-06-16 03:41:52
1789	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 03:41:53	2026-06-16 03:41:53
1790	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-16 03:41:59	2026-06-16 03:41:59
1791	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 03:42:14	2026-06-16 03:42:14
1792	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/jaket-3Cvt	1	2026-06-16 03:42:20	2026-06-16 03:42:20
1793	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/jaket-3Cvt	1	2026-06-16 03:42:25	2026-06-16 03:42:25
1794	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-16 03:42:27	2026-06-16 03:42:27
1795	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-16 03:42:28	2026-06-16 03:42:28
1796	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-16 03:42:33	2026-06-16 03:42:33
1797	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-16 03:42:36	2026-06-16 03:42:36
1798	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-16 03:42:39	2026-06-16 03:42:39
1799	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-16 03:44:08	2026-06-16 03:44:08
1800	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-16 03:44:15	2026-06-16 03:44:15
1801	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-16 03:44:38	2026-06-16 03:44:38
1802	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-16 03:44:48	2026-06-16 03:44:48
1803	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-16 03:48:34	2026-06-16 03:48:34
1804	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-16 03:48:36	2026-06-16 03:48:36
1805	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-16 03:48:43	2026-06-16 03:48:43
1806	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-16 03:50:16	2026-06-16 03:50:16
1807	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-16 03:50:22	2026-06-16 03:50:22
1808	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 03:50:36	2026-06-16 03:50:36
1809	127.0.0.1	Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36	/	1	2026-06-16 03:56:01	2026-06-16 03:56:01
1810	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 03:56:17	2026-06-16 03:56:17
1811	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 03:59:45	2026-06-16 03:59:45
1812	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 04:00:08	2026-06-16 04:00:08
1813	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 04:00:44	2026-06-16 04:00:44
1814	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 04:01:49	2026-06-16 04:01:49
1815	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 04:02:18	2026-06-16 04:02:18
1816	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-16 04:05:19	2026-06-16 04:05:19
1817	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 04:05:20	2026-06-16 04:05:20
1818	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-16 04:05:23	2026-06-16 04:05:23
1819	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 04:05:23	2026-06-16 04:05:23
1820	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-16 04:37:01	2026-06-16 04:37:01
1821	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-16 04:37:02	2026-06-16 04:37:02
1822	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/11	1	2026-06-16 04:37:07	2026-06-16 04:37:07
1823	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 06:49:19	2026-06-16 06:49:19
1824	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-16 06:50:21	2026-06-16 06:50:21
1825	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-16 06:50:24	2026-06-16 06:50:24
1826	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 06:50:29	2026-06-16 06:50:29
1827	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:10:47	2026-06-16 07:10:47
1828	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:11:32	2026-06-16 07:11:32
1829	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:12:08	2026-06-16 07:12:08
1830	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:12:45	2026-06-16 07:12:45
1831	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:12:56	2026-06-16 07:12:56
1832	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:13:14	2026-06-16 07:13:14
1833	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:14:00	2026-06-16 07:14:00
1834	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:23:08	2026-06-16 07:23:08
1835	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:23:24	2026-06-16 07:23:24
1836	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:24:26	2026-06-16 07:24:26
1837	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:24:38	2026-06-16 07:24:38
1838	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:24:43	2026-06-16 07:24:43
1839	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:26:20	2026-06-16 07:26:20
1840	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:26:20	2026-06-16 07:26:20
1841	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:26:22	2026-06-16 07:26:22
1842	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:27:01	2026-06-16 07:27:01
1843	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 07:29:17	2026-06-16 07:29:17
1844	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:13:42	2026-06-16 08:13:42
1845	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:16:23	2026-06-16 08:16:23
1846	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:24:53	2026-06-16 08:24:53
1847	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:27:30	2026-06-16 08:27:30
1848	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:28:24	2026-06-16 08:28:24
1849	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:28:58	2026-06-16 08:28:58
1850	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:29:21	2026-06-16 08:29:21
1851	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:29:33	2026-06-16 08:29:33
1852	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	1	2026-06-16 08:30:34	2026-06-16 08:30:34
1853	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	1	2026-06-16 08:30:41	2026-06-16 08:30:41
1854	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:30:43	2026-06-16 08:30:43
1855	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-16 08:30:53	2026-06-16 08:30:53
1856	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:30:53	2026-06-16 08:30:53
1857	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-16 08:30:57	2026-06-16 08:30:57
1858	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:30:57	2026-06-16 08:30:57
1859	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:33:03	2026-06-16 08:33:03
1860	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:33:05	2026-06-16 08:33:05
1861	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:33:54	2026-06-16 08:33:54
1862	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:35:25	2026-06-16 08:35:25
1863	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:37:18	2026-06-16 08:37:18
1864	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-16 08:37:24	2026-06-16 08:37:24
1865	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:37:24	2026-06-16 08:37:24
1866	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-16 08:37:29	2026-06-16 08:37:29
1867	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	1	2026-06-16 08:37:41	2026-06-16 08:37:41
1868	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tentang-kami	1	2026-06-16 08:37:58	2026-06-16 08:37:58
1869	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:38:18	2026-06-16 08:38:18
1870	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:39:46	2026-06-16 08:39:46
1871	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:40:12	2026-06-16 08:40:12
1872	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:40:30	2026-06-16 08:40:30
1873	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-16 08:40:33	2026-06-16 08:40:33
1874	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:40:34	2026-06-16 08:40:34
1875	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-16 08:40:38	2026-06-16 08:40:38
1876	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:40:38	2026-06-16 08:40:38
1877	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:41:56	2026-06-16 08:41:56
1878	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:42:20	2026-06-16 08:42:20
1879	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:42:31	2026-06-16 08:42:31
1880	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:43:47	2026-06-16 08:43:47
1881	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:43:50	2026-06-16 08:43:50
1882	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:45:21	2026-06-16 08:45:21
1883	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 08:46:37	2026-06-16 08:46:37
1884	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/jaket-3Cvt	1	2026-06-16 08:46:45	2026-06-16 08:46:45
1885	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:15:35	2026-06-16 09:15:35
1886	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:16:14	2026-06-16 09:16:14
1887	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:16:26	2026-06-16 09:16:26
1888	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:17:55	2026-06-16 09:17:55
1889	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:18:57	2026-06-16 09:18:57
1890	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:19:49	2026-06-16 09:19:49
1891	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:20:50	2026-06-16 09:20:50
1892	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-16 09:22:24	2026-06-16 09:22:24
1893	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-16 09:22:29	2026-06-16 09:22:29
1894	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-16 09:22:32	2026-06-16 09:22:32
1895	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-16 09:22:34	2026-06-16 09:22:34
1896	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-16 09:22:35	2026-06-16 09:22:35
1897	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:22:37	2026-06-16 09:22:37
1898	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-16 09:22:46	2026-06-16 09:22:46
1899	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/43	1	2026-06-16 09:22:51	2026-06-16 09:22:51
1900	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/43	1	2026-06-16 09:23:54	2026-06-16 09:23:54
1901	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/43	1	2026-06-16 09:25:09	2026-06-16 09:25:09
1902	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/43	1	2026-06-16 09:25:21	2026-06-16 09:25:21
1903	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:25:32	2026-06-16 09:25:32
1904	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:27:19	2026-06-16 09:27:19
1905	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:27:41	2026-06-16 09:27:41
1906	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:29:16	2026-06-16 09:29:16
1907	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:29:29	2026-06-16 09:29:29
1908	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:30:57	2026-06-16 09:30:57
1909	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 09:36:02	2026-06-16 09:36:02
1910	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	1	2026-06-16 09:36:35	2026-06-16 09:36:35
1911	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 10:06:05	2026-06-16 10:06:05
1912	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 10:38:29	2026-06-16 10:38:29
1913	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 10:38:38	2026-06-16 10:38:38
1914	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 10:39:21	2026-06-16 10:39:21
1915	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 10:40:23	2026-06-16 10:40:23
1916	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 10:44:02	2026-06-16 10:44:02
1917	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	1	2026-06-16 10:45:11	2026-06-16 10:45:11
1918	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/jaket-3Cvt	1	2026-06-16 10:45:29	2026-06-16 10:45:29
1919	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-16 10:48:56	2026-06-16 10:48:56
1920	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 10:54:11	2026-06-16 10:54:11
1921	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:03:58	2026-06-16 11:03:58
1922	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:04:13	2026-06-16 11:04:13
1923	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:05:27	2026-06-16 11:05:27
1924	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:05:34	2026-06-16 11:05:34
1925	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:05:48	2026-06-16 11:05:48
1926	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:06:08	2026-06-16 11:06:08
1927	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:06:27	2026-06-16 11:06:27
1928	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:07:00	2026-06-16 11:07:00
1929	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:10:28	2026-06-16 11:10:28
1930	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:11:14	2026-06-16 11:11:14
1931	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:11:54	2026-06-16 11:11:54
1932	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:12:43	2026-06-16 11:12:43
1933	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:13:27	2026-06-16 11:13:27
1934	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:13:59	2026-06-16 11:13:59
1935	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:14:33	2026-06-16 11:14:33
1936	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:15:30	2026-06-16 11:15:30
1937	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:16:04	2026-06-16 11:16:04
1938	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:19:11	2026-06-16 11:19:11
1939	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:19:22	2026-06-16 11:19:22
1940	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:19:37	2026-06-16 11:19:37
1941	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-16 11:21:20	2026-06-16 11:21:20
1942	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:21:20	2026-06-16 11:21:20
1943	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-16 11:21:25	2026-06-16 11:21:25
1944	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:21:25	2026-06-16 11:21:25
1945	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-16 11:21:34	2026-06-16 11:21:34
1946	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:21:34	2026-06-16 11:21:34
1947	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-16 11:21:42	2026-06-16 11:21:42
1948	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-16 11:21:46	2026-06-16 11:21:46
1949	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-16 11:21:46	2026-06-16 11:21:46
1950	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-16 11:24:00	2026-06-16 11:24:00
1951	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-16 11:24:02	2026-06-16 11:24:02
1952	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-16 11:24:23	2026-06-16 11:24:23
1953	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-16 11:25:02	2026-06-16 11:25:02
1954	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:25:07	2026-06-16 11:25:07
1955	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-16 11:25:59	2026-06-16 11:25:59
1956	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/41	1	2026-06-16 11:26:06	2026-06-16 11:26:06
1957	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/41	1	2026-06-16 11:26:11	2026-06-16 11:26:11
1958	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/IONH4qSozeM6RLDgh3vyyJp2	1	2026-06-16 11:26:47	2026-06-16 11:26:47
1959	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/IONH4qSozeM6RLDgh3vyyJp2	1	2026-06-16 11:26:58	2026-06-16 11:26:58
1960	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/IONH4qSozeM6RLDgh3vyyJp2	1	2026-06-16 11:28:40	2026-06-16 11:28:40
1961	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:31:14	2026-06-16 11:31:14
1962	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:33:47	2026-06-16 11:33:47
1963	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-16 11:33:51	2026-06-16 11:33:51
1964	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-16 11:33:51	2026-06-16 11:33:51
1965	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:18:56	2026-06-16 14:18:56
1966	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:21:17	2026-06-16 14:21:17
1967	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:28:35	2026-06-16 14:28:35
1968	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:29:45	2026-06-16 14:29:45
1969	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:29:48	2026-06-16 14:29:48
1970	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:39:20	2026-06-16 14:39:20
1971	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:39:57	2026-06-16 14:39:57
1972	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:41:45	2026-06-16 14:41:45
1973	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:44:02	2026-06-16 14:44:02
1974	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tentang-kami	\N	2026-06-16 14:47:48	2026-06-16 14:47:48
1975	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	\N	2026-06-16 14:47:54	2026-06-16 14:47:54
1976	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-16 14:48:07	2026-06-16 14:48:07
1977	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	\N	2026-06-16 14:48:37	2026-06-16 14:48:37
1978	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	\N	2026-06-16 14:48:40	2026-06-16 14:48:40
1979	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan-muslim-wanita	\N	2026-06-16 14:49:29	2026-06-16 14:49:29
1980	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:50:20	2026-06-16 14:50:20
1981	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-16 14:50:23	2026-06-16 14:50:23
1982	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:50:23	2026-06-16 14:50:23
1983	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-16 14:50:25	2026-06-16 14:50:25
1984	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:50:26	2026-06-16 14:50:26
1985	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-16 14:50:31	2026-06-16 14:50:31
1986	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:50:32	2026-06-16 14:50:32
1987	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:57:22	2026-06-16 14:57:22
1988	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:59:02	2026-06-16 14:59:02
1989	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:59:24	2026-06-16 14:59:24
1990	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 14:59:40	2026-06-16 14:59:40
1991	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:00:21	2026-06-16 15:00:21
1992	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:00:36	2026-06-16 15:00:36
1993	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:01:26	2026-06-16 15:01:26
1994	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:03:22	2026-06-16 15:03:22
1995	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:03:38	2026-06-16 15:03:38
1996	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:04:16	2026-06-16 15:04:16
1997	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:04:28	2026-06-16 15:04:28
1998	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:12:02	2026-06-16 15:12:02
1999	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:12:37	2026-06-16 15:12:37
2000	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:14:47	2026-06-16 15:14:47
2001	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:16:27	2026-06-16 15:16:27
2002	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:17:59	2026-06-16 15:17:59
2003	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:18:49	2026-06-16 15:18:49
2004	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:19:04	2026-06-16 15:19:04
2005	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:19:27	2026-06-16 15:19:27
2006	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:20:29	2026-06-16 15:20:29
2007	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:20:48	2026-06-16 15:20:48
2008	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-16 15:20:58	2026-06-16 15:20:58
2009	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:20:58	2026-06-16 15:20:58
2010	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-16 15:22:23	2026-06-16 15:22:23
2011	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:22:23	2026-06-16 15:22:23
2012	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-16 15:22:28	2026-06-16 15:22:28
2013	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:22:29	2026-06-16 15:22:29
2014	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-16 15:33:45	2026-06-16 15:33:45
2015	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:34:58	2026-06-16 15:34:58
2016	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:37:33	2026-06-16 15:37:33
2017	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:42:39	2026-06-16 15:42:39
2018	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:43:04	2026-06-16 15:43:04
2019	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-16 15:43:10	2026-06-16 15:43:10
2020	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	\N	2026-06-16 15:43:22	2026-06-16 15:43:22
2021	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	\N	2026-06-16 15:44:03	2026-06-16 15:44:03
2022	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-16 15:44:07	2026-06-16 15:44:07
2023	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	\N	2026-06-16 15:44:39	2026-06-16 15:44:39
2024	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	\N	2026-06-16 15:45:59	2026-06-16 15:45:59
2025	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	\N	2026-06-16 15:46:07	2026-06-16 15:46:07
2026	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	\N	2026-06-16 15:46:15	2026-06-16 15:46:15
2027	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	\N	2026-06-16 15:47:02	2026-06-16 15:47:02
2028	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan-muslim-wanita	\N	2026-06-16 15:47:05	2026-06-16 15:47:05
2029	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/sweater-cardigan	\N	2026-06-16 15:47:09	2026-06-16 15:47:09
2030	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	\N	2026-06-16 15:47:12	2026-06-16 15:47:12
2031	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/aksesoris	\N	2026-06-16 15:47:15	2026-06-16 15:47:15
2032	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-16 15:47:39	2026-06-16 15:47:39
2033	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-16 15:47:43	2026-06-16 15:47:43
2034	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 03:22:27	2026-06-18 03:22:27
2035	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 03:22:45	2026-06-18 03:22:45
2036	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 03:31:27	2026-06-18 03:31:27
2037	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	products	\N	2026-06-18 03:33:31	2026-06-18 03:33:31
2038	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-18 03:33:38	2026-06-18 03:33:38
2039	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	category/outwear	\N	2026-06-18 03:34:59	2026-06-18 03:34:59
2040	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	products/korpako-Vs6k	\N	2026-06-18 03:35:01	2026-06-18 03:35:01
2041	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-18 03:35:08	2026-06-18 03:35:08
2042	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 03:59:29	2026-06-18 03:59:29
2043	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:00:36	2026-06-18 04:00:36
2044	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:02:43	2026-06-18 04:02:43
2045	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-18 04:03:02	2026-06-18 04:03:02
2046	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:03:03	2026-06-18 04:03:03
2047	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	\N	2026-06-18 04:03:08	2026-06-18 04:03:08
2048	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-18 04:03:08	2026-06-18 04:03:08
2049	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:03:22	2026-06-18 04:03:22
2050	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:03:50	2026-06-18 04:03:50
2051	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:04:12	2026-06-18 04:04:12
2052	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	\N	2026-06-18 04:04:36	2026-06-18 04:04:36
2053	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	\N	2026-06-18 04:04:40	2026-06-18 04:04:40
2054	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:05:15	2026-06-18 04:05:15
2055	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:06:04	2026-06-18 04:06:04
2056	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:06:17	2026-06-18 04:06:17
2057	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:07:33	2026-06-18 04:07:33
2058	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:13:46	2026-06-18 04:13:46
2059	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:21:12	2026-06-18 04:21:12
2060	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:21:13	2026-06-18 04:21:13
2061	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:21:14	2026-06-18 04:21:14
2062	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:21:14	2026-06-18 04:21:14
2063	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:21:14	2026-06-18 04:21:14
2064	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:21:15	2026-06-18 04:21:15
2065	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:21:32	2026-06-18 04:21:32
2066	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 04:22:05	2026-06-18 04:22:05
2067	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 05:05:06	2026-06-18 05:05:06
2068	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 05:06:55	2026-06-18 05:06:55
2069	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 06:54:43	2026-06-18 06:54:43
2070	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 07:16:02	2026-06-18 07:16:02
2071	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 07:16:34	2026-06-18 07:16:34
2072	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 07:16:44	2026-06-18 07:16:44
2073	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 07:17:05	2026-06-18 07:17:05
2074	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 07:17:14	2026-06-18 07:17:14
2075	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 07:17:20	2026-06-18 07:17:20
2076	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 13:19:12	2026-06-18 13:19:12
2077	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 13:27:04	2026-06-18 13:27:04
2078	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 13:27:40	2026-06-18 13:27:40
2079	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-18 13:29:28	2026-06-18 13:29:28
2080	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 13:29:28	2026-06-18 13:29:28
2081	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 13:29:39	2026-06-18 13:29:39
2082	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 14:54:32	2026-06-18 14:54:32
2083	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-18 15:01:48	2026-06-18 15:01:48
2084	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 15:01:52	2026-06-18 15:01:52
2085	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 15:03:10	2026-06-18 15:03:10
2086	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 15:03:15	2026-06-18 15:03:15
2087	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-18 15:03:30	2026-06-18 15:03:30
2088	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-18 15:08:29	2026-06-18 15:08:29
2089	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-18 15:08:39	2026-06-18 15:08:39
2090	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-18 15:08:46	2026-06-18 15:08:46
2091	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	1	2026-06-18 15:09:02	2026-06-18 15:09:02
2092	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	1	2026-06-18 15:10:08	2026-06-18 15:10:08
2093	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	1	2026-06-18 15:13:22	2026-06-18 15:13:22
2094	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	1	2026-06-18 15:13:27	2026-06-18 15:13:27
2095	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	1	2026-06-18 15:14:01	2026-06-18 15:14:01
2096	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	1	2026-06-18 15:14:16	2026-06-18 15:14:16
2097	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	1	2026-06-18 15:15:56	2026-06-18 15:15:56
2098	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	1	2026-06-18 15:16:09	2026-06-18 15:16:09
2099	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	1	2026-06-18 15:17:52	2026-06-18 15:17:52
2100	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	1	2026-06-18 15:30:31	2026-06-18 15:30:31
2101	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	profile	1	2026-06-18 15:30:58	2026-06-18 15:30:58
2102	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-18 15:31:46	2026-06-18 15:31:46
2103	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-18 15:31:51	2026-06-18 15:31:51
2104	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-18 15:31:56	2026-06-18 15:31:56
2105	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-18 15:31:58	2026-06-18 15:31:58
2106	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-18 15:32:03	2026-06-18 15:32:03
2107	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-18 15:32:10	2026-06-18 15:32:10
2108	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-18 15:32:13	2026-06-18 15:32:13
2109	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-18 15:32:33	2026-06-18 15:32:33
2110	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-18 15:32:42	2026-06-18 15:32:42
2111	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-18 15:32:42	2026-06-18 15:32:42
2112	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-18 15:33:14	2026-06-18 15:33:14
2113	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-18 15:37:07	2026-06-18 15:37:07
2114	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-18 15:37:42	2026-06-18 15:37:42
2115	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-18 15:38:14	2026-06-18 15:38:14
2116	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-18 15:38:40	2026-06-18 15:38:40
2117	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-18 15:44:26	2026-06-18 15:44:26
2118	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-18 15:44:33	2026-06-18 15:44:33
2119	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-18 15:44:38	2026-06-18 15:44:38
2120	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-19 03:37:43	2026-06-19 03:37:43
2121	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-19 03:38:33	2026-06-19 03:38:33
2122	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 03:38:44	2026-06-19 03:38:44
2123	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 03:43:00	2026-06-19 03:43:00
2124	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 03:48:40	2026-06-19 03:48:40
2125	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 03:49:49	2026-06-19 03:49:49
2126	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-2212-lumi-blouse-blouse-tali-belakang-atasan-tali-belakang-bahan-polo-linen-qu5S	1	2026-06-19 03:55:40	2026-06-19 03:55:40
2127	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-19 03:55:45	2026-06-19 03:55:45
2128	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-19 03:55:49	2026-06-19 03:55:49
2129	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 03:55:52	2026-06-19 03:55:52
2130	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 03:56:34	2026-06-19 03:56:34
2131	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 03:56:41	2026-06-19 03:56:41
2132	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 03:56:43	2026-06-19 03:56:43
2133	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 03:56:44	2026-06-19 03:56:44
2134	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/45	1	2026-06-19 03:56:54	2026-06-19 03:56:54
2135	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/45	1	2026-06-19 03:58:22	2026-06-19 03:58:22
2136	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/45	1	2026-06-19 03:59:02	2026-06-19 03:59:02
2137	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/45	1	2026-06-19 03:59:06	2026-06-19 03:59:06
2138	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 03:59:50	2026-06-19 03:59:50
2139	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:02:54	2026-06-19 04:02:54
2140	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:03:05	2026-06-19 04:03:05
2141	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:06:28	2026-06-19 04:06:28
2142	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:07:45	2026-06-19 04:07:45
2143	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:08:12	2026-06-19 04:08:12
2144	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:10:39	2026-06-19 04:10:39
2145	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:10:46	2026-06-19 04:10:46
2146	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:11:28	2026-06-19 04:11:28
2147	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:14:07	2026-06-19 04:14:07
2148	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:15:54	2026-06-19 04:15:54
2149	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:16:25	2026-06-19 04:16:25
2150	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:16:32	2026-06-19 04:16:32
2151	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:17:39	2026-06-19 04:17:39
2152	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:18:16	2026-06-19 04:18:16
2153	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:18:28	2026-06-19 04:18:28
2154	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:19:13	2026-06-19 04:19:13
2155	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:22:05	2026-06-19 04:22:05
2156	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:23:07	2026-06-19 04:23:07
2157	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:23:18	2026-06-19 04:23:18
2158	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:24:48	2026-06-19 04:24:48
2159	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:26:04	2026-06-19 04:26:04
2160	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:28:50	2026-06-19 04:28:50
2161	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:29:02	2026-06-19 04:29:02
2162	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:29:20	2026-06-19 04:29:20
2163	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 04:29:35	2026-06-19 04:29:35
2164	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 06:03:55	2026-06-19 06:03:55
2165	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 06:05:58	2026-06-19 06:05:58
2166	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	1	2026-06-19 06:06:23	2026-06-19 06:06:23
2167	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-19 06:06:39	2026-06-19 06:06:39
2168	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-19 06:06:43	2026-06-19 06:06:43
2169	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 06:06:46	2026-06-19 06:06:46
2170	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 06:06:56	2026-06-19 06:06:56
2171	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 06:13:53	2026-06-19 06:13:53
2172	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 06:14:51	2026-06-19 06:14:51
2173	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 06:16:57	2026-06-19 06:16:57
2174	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 06:19:32	2026-06-19 06:19:32
2175	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 06:20:54	2026-06-19 06:20:54
2176	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-2212-lumi-blouse-blouse-tali-belakang-atasan-tali-belakang-bahan-polo-linen-qu5S	1	2026-06-19 06:26:09	2026-06-19 06:26:09
2177	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-2212-lumi-blouse-blouse-tali-belakang-atasan-tali-belakang-bahan-polo-linen-qu5S	1	2026-06-19 06:26:14	2026-06-19 06:26:14
2178	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 06:26:18	2026-06-19 06:26:18
2179	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 06:26:25	2026-06-19 06:26:25
2180	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 06:29:00	2026-06-19 06:29:00
2181	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 06:29:29	2026-06-19 06:29:29
2182	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 06:30:56	2026-06-19 06:30:56
2183	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 06:31:14	2026-06-19 06:31:14
2184	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:31:20	2026-06-19 06:31:20
2185	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-19 06:31:24	2026-06-19 06:31:24
2186	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:31:24	2026-06-19 06:31:24
2187	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 06:31:37	2026-06-19 06:31:37
2188	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 06:31:38	2026-06-19 06:31:38
2189	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:34:38	2026-06-19 06:34:38
2190	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:35:07	2026-06-19 06:35:07
2191	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:35:11	2026-06-19 06:35:11
2192	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:35:47	2026-06-19 06:35:47
2193	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 06:35:54	2026-06-19 06:35:54
2194	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 06:35:56	2026-06-19 06:35:56
2195	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 06:35:57	2026-06-19 06:35:57
2196	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:38:36	2026-06-19 06:38:36
2197	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:40:37	2026-06-19 06:40:37
2198	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:40:41	2026-06-19 06:40:41
2199	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:43:14	2026-06-19 06:43:14
2200	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-19 06:43:20	2026-06-19 06:43:20
2201	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:43:20	2026-06-19 06:43:20
2202	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-19 06:43:23	2026-06-19 06:43:23
2203	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:43:24	2026-06-19 06:43:24
2204	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 06:43:37	2026-06-19 06:43:37
2205	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 06:43:38	2026-06-19 06:43:38
2206	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 06:43:39	2026-06-19 06:43:39
2207	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 06:43:41	2026-06-19 06:43:41
2208	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-19 06:44:02	2026-06-19 06:44:02
2209	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:44:03	2026-06-19 06:44:03
2210	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-19 06:44:08	2026-06-19 06:44:08
2211	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:44:08	2026-06-19 06:44:08
2212	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 06:56:06	2026-06-19 06:56:06
2213	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 06:56:08	2026-06-19 06:56:08
2214	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 07:04:24	2026-06-19 07:04:24
2215	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 07:20:29	2026-06-19 07:20:29
2216	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 07:22:07	2026-06-19 07:22:07
2217	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 07:41:38	2026-06-19 07:41:38
2218	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 07:42:21	2026-06-19 07:42:21
2219	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 07:42:27	2026-06-19 07:42:27
2220	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 07:44:21	2026-06-19 07:44:21
2221	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 07:47:01	2026-06-19 07:47:01
2222	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 07:47:11	2026-06-19 07:47:11
2223	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 07:48:16	2026-06-19 07:48:16
2224	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 07:51:31	2026-06-19 07:51:31
2225	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 07:52:05	2026-06-19 07:52:05
2226	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 07:54:18	2026-06-19 07:54:18
2227	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 07:58:13	2026-06-19 07:58:13
2228	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 07:58:18	2026-06-19 07:58:18
2229	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:02:19	2026-06-19 09:02:19
2230	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/46	1	2026-06-19 09:07:41	2026-06-19 09:07:41
2231	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/46	1	2026-06-19 09:08:53	2026-06-19 09:08:53
2232	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/46	1	2026-06-19 09:09:44	2026-06-19 09:09:44
2233	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/46	1	2026-06-19 09:10:18	2026-06-19 09:10:18
2234	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/46	1	2026-06-19 09:11:33	2026-06-19 09:11:33
2235	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/46	1	2026-06-19 09:12:00	2026-06-19 09:12:00
2236	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/46	1	2026-06-19 09:12:01	2026-06-19 09:12:01
2237	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/46	1	2026-06-19 09:12:01	2026-06-19 09:12:01
2238	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/46	1	2026-06-19 09:12:03	2026-06-19 09:12:03
2239	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/46	1	2026-06-19 09:15:48	2026-06-19 09:15:48
2240	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 09:15:51	2026-06-19 09:15:51
2241	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-19 09:16:11	2026-06-19 09:16:11
2242	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-19 09:16:15	2026-06-19 09:16:15
2243	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 09:16:19	2026-06-19 09:16:19
2244	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:16:21	2026-06-19 09:16:21
2245	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/47	1	2026-06-19 09:16:46	2026-06-19 09:16:46
2246	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/47	1	2026-06-19 09:18:43	2026-06-19 09:18:43
2247	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/47	1	2026-06-19 09:19:44	2026-06-19 09:19:44
2248	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/47	1	2026-06-19 09:20:58	2026-06-19 09:20:58
2249	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:22:24	2026-06-19 09:22:24
2250	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:22:26	2026-06-19 09:22:26
2251	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 09:22:27	2026-06-19 09:22:27
2252	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 09:22:29	2026-06-19 09:22:29
2253	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-19 09:22:35	2026-06-19 09:22:35
2254	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/47	1	2026-06-19 09:22:39	2026-06-19 09:22:39
2255	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/47	1	2026-06-19 09:24:05	2026-06-19 09:24:05
2256	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/47	1	2026-06-19 09:25:14	2026-06-19 09:25:14
2257	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-19 09:25:19	2026-06-19 09:25:19
2258	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 09:25:25	2026-06-19 09:25:25
2259	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-19 09:25:32	2026-06-19 09:25:32
2260	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-19 09:25:34	2026-06-19 09:25:34
2261	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-19 09:25:38	2026-06-19 09:25:38
2262	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 09:25:42	2026-06-19 09:25:42
2263	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 09:25:45	2026-06-19 09:25:45
2264	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:25:47	2026-06-19 09:25:47
2265	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:26:03	2026-06-19 09:26:03
2266	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:39:26	2026-06-19 09:39:26
2267	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:39:29	2026-06-19 09:39:29
2268	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:41:37	2026-06-19 09:41:37
2269	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:42:00	2026-06-19 09:42:00
2270	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:42:19	2026-06-19 09:42:19
2271	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-19 09:43:25	2026-06-19 09:43:25
2272	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:43:26	2026-06-19 09:43:26
2273	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-19 09:43:30	2026-06-19 09:43:30
2274	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:43:30	2026-06-19 09:43:30
2275	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-19 09:43:32	2026-06-19 09:43:32
2276	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:43:32	2026-06-19 09:43:32
2277	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:47:16	2026-06-19 09:47:16
2278	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 09:47:24	2026-06-19 09:47:24
2279	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 09:47:26	2026-06-19 09:47:26
2280	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-19 09:47:27	2026-06-19 09:47:27
2281	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/48	1	2026-06-19 09:47:40	2026-06-19 09:47:40
2282	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/48	1	2026-06-19 09:48:23	2026-06-19 09:48:23
2283	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:48:26	2026-06-19 09:48:26
2284	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:48:29	2026-06-19 09:48:29
2285	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 09:48:30	2026-06-19 09:48:30
2286	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-19 09:48:35	2026-06-19 09:48:35
2287	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-19 09:48:43	2026-06-19 09:48:43
2288	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-19 09:49:34	2026-06-19 09:49:34
2289	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/48	1	2026-06-19 09:49:37	2026-06-19 09:49:37
2290	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 09:49:57	2026-06-19 09:49:57
2291	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-19 09:50:00	2026-06-19 09:50:00
2292	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/48	1	2026-06-19 09:50:03	2026-06-19 09:50:03
2293	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/48	1	2026-06-19 09:50:08	2026-06-19 09:50:08
2294	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-19 09:50:11	2026-06-19 09:50:11
2295	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 09:50:14	2026-06-19 09:50:14
2296	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-19 09:50:18	2026-06-19 09:50:18
2297	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-19 09:50:23	2026-06-19 09:50:23
2298	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 09:50:26	2026-06-19 09:50:26
2299	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 09:50:27	2026-06-19 09:50:27
2300	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/49	1	2026-06-19 09:50:42	2026-06-19 09:50:42
2301	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-19 09:53:37	2026-06-19 09:53:37
2302	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/49	1	2026-06-19 09:53:38	2026-06-19 09:53:38
2303	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-19 09:53:40	2026-06-19 09:53:40
2304	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/49	1	2026-06-19 09:53:41	2026-06-19 09:53:41
2305	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 10:09:00	2026-06-19 10:09:00
2306	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 10:20:59	2026-06-19 10:20:59
2307	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 10:21:18	2026-06-19 10:21:18
2308	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 10:22:36	2026-06-19 10:22:36
2309	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 10:23:25	2026-06-19 10:23:25
2310	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	1	2026-06-19 10:30:17	2026-06-19 10:30:17
2311	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/outwear	1	2026-06-19 10:30:30	2026-06-19 10:30:30
2312	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 10:30:44	2026-06-19 10:30:44
2313	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 10:33:21	2026-06-19 10:33:21
2314	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 11:36:43	2026-06-19 11:36:43
2315	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 11:38:25	2026-06-19 11:38:25
2316	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 11:38:47	2026-06-19 11:38:47
2317	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 11:40:43	2026-06-19 11:40:43
2318	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 11:40:47	2026-06-19 11:40:47
2319	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 11:41:09	2026-06-19 11:41:09
2320	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 11:41:48	2026-06-19 11:41:48
2321	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 12:15:08	2026-06-19 12:15:08
2322	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 12:19:24	2026-06-19 12:19:24
2323	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 12:21:18	2026-06-19 12:21:18
2324	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	1	2026-06-19 12:21:30	2026-06-19 12:21:30
2325	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 12:21:33	2026-06-19 12:21:33
2326	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-19 12:21:37	2026-06-19 12:21:37
2327	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/49	1	2026-06-19 12:21:39	2026-06-19 12:21:39
2328	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/49	1	2026-06-19 12:21:49	2026-06-19 12:21:49
2329	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 12:26:16	2026-06-19 12:26:16
2330	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-19 12:26:19	2026-06-19 12:26:19
2374	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:51:50	2026-06-21 06:51:50
2331	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-19 12:26:25	2026-06-19 12:26:25
2332	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-19 12:26:36	2026-06-19 12:26:36
2333	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-19 12:26:38	2026-06-19 12:26:38
2334	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/50	1	2026-06-19 12:27:19	2026-06-19 12:27:19
2335	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/50	1	2026-06-19 12:29:17	2026-06-19 12:29:17
2336	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/50	1	2026-06-19 12:29:47	2026-06-19 12:29:47
2337	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/50	1	2026-06-19 12:55:52	2026-06-19 12:55:52
2338	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/50	1	2026-06-19 12:56:02	2026-06-19 12:56:02
2339	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/50	1	2026-06-19 12:56:33	2026-06-19 12:56:33
2340	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/50	1	2026-06-19 12:57:03	2026-06-19 12:57:03
2341	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/50	1	2026-06-19 12:57:21	2026-06-19 12:57:21
2342	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/50	1	2026-06-19 12:57:41	2026-06-19 12:57:41
2343	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/50	1	2026-06-19 14:02:40	2026-06-19 14:02:40
2344	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 14:14:09	2026-06-19 14:14:09
2345	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 14:17:12	2026-06-19 14:17:12
2346	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 14:17:53	2026-06-19 14:17:53
2347	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 14:22:47	2026-06-19 14:22:47
2348	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 14:24:38	2026-06-19 14:24:38
2349	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-19 14:25:06	2026-06-19 14:25:06
2350	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:03:22	2026-06-21 06:03:22
2351	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:03:29	2026-06-21 06:03:29
2352	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:21:34	2026-06-21 06:21:34
2353	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:21:36	2026-06-21 06:21:36
2354	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:25:00	2026-06-21 06:25:00
2355	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:25:02	2026-06-21 06:25:02
2356	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:31:20	2026-06-21 06:31:20
2357	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:31:28	2026-06-21 06:31:28
2358	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:33:44	2026-06-21 06:33:44
2359	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:33:51	2026-06-21 06:33:51
2360	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:40:01	2026-06-21 06:40:01
2361	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:40:05	2026-06-21 06:40:05
2362	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:41:33	2026-06-21 06:41:33
2363	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:41:36	2026-06-21 06:41:36
2364	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:41:56	2026-06-21 06:41:56
2365	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:41:59	2026-06-21 06:41:59
2366	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:44:25	2026-06-21 06:44:25
2367	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:44:29	2026-06-21 06:44:29
2368	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:44:30	2026-06-21 06:44:30
2369	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:44:32	2026-06-21 06:44:32
2370	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:47:46	2026-06-21 06:47:46
2371	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:47:48	2026-06-21 06:47:48
2372	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:50:05	2026-06-21 06:50:05
2373	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:50:08	2026-06-21 06:50:08
2375	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:51:52	2026-06-21 06:51:52
2376	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:52:25	2026-06-21 06:52:25
2377	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:52:31	2026-06-21 06:52:31
2378	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:52:35	2026-06-21 06:52:35
2379	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:52:42	2026-06-21 06:52:42
2380	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 06:52:43	2026-06-21 06:52:43
2381	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:52:48	2026-06-21 06:52:48
2382	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	\N	2026-06-21 06:54:13	2026-06-21 06:54:13
2383	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:54:15	2026-06-21 06:54:15
2384	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:54:17	2026-06-21 06:54:17
2385	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 06:54:18	2026-06-21 06:54:18
2386	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 06:54:26	2026-06-21 06:54:26
2387	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	notifications/213/read	1	2026-06-21 06:54:36	2026-06-21 06:54:36
2388	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/50	1	2026-06-21 06:54:36	2026-06-21 06:54:36
2389	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 06:54:48	2026-06-21 06:54:48
2390	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 06:59:57	2026-06-21 06:59:57
2391	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:04:09	2026-06-21 07:04:09
2392	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:04:18	2026-06-21 07:04:18
2393	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:10	2026-06-21 07:06:10
2394	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:11	2026-06-21 07:06:11
2395	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:12	2026-06-21 07:06:12
2396	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:16	2026-06-21 07:06:16
2397	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:17	2026-06-21 07:06:17
2398	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:18	2026-06-21 07:06:18
2399	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:19	2026-06-21 07:06:19
2400	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:20	2026-06-21 07:06:20
2401	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:21	2026-06-21 07:06:21
2402	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:23	2026-06-21 07:06:23
2403	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:23	2026-06-21 07:06:23
2404	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:25	2026-06-21 07:06:25
2405	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:26	2026-06-21 07:06:26
2406	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:27	2026-06-21 07:06:27
2407	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:28	2026-06-21 07:06:28
2408	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:29	2026-06-21 07:06:29
2409	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:30	2026-06-21 07:06:30
2410	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:32	2026-06-21 07:06:32
2411	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:33	2026-06-21 07:06:33
2412	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:34	2026-06-21 07:06:34
2413	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:36	2026-06-21 07:06:36
2414	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:37	2026-06-21 07:06:37
2415	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:06:38	2026-06-21 07:06:38
2416	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-21 07:07:01	2026-06-21 07:07:01
2417	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/50	1	2026-06-21 07:07:18	2026-06-21 07:07:18
2418	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/50	1	2026-06-21 07:07:20	2026-06-21 07:07:20
2419	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/50	1	2026-06-21 07:07:21	2026-06-21 07:07:21
2420	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 07:18:50	2026-06-21 07:18:50
2421	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-21 07:18:59	2026-06-21 07:18:59
2422	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-21 07:19:12	2026-06-21 07:19:12
2423	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-21 07:19:14	2026-06-21 07:19:14
2424	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-21 07:19:17	2026-06-21 07:19:17
2425	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-21 07:19:33	2026-06-21 07:19:33
2426	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-21 07:19:38	2026-06-21 07:19:38
2427	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-21 07:19:39	2026-06-21 07:19:39
2428	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/51	1	2026-06-21 07:19:46	2026-06-21 07:19:46
2429	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/51	1	2026-06-21 07:19:48	2026-06-21 07:19:48
2430	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/xendit/51/success	1	2026-06-21 07:20:31	2026-06-21 07:20:31
2431	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/51	1	2026-06-21 07:20:58	2026-06-21 07:20:58
2432	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 07:22:43	2026-06-21 07:22:43
2433	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 11:44:36	2026-06-21 11:44:36
2434	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 11:50:01	2026-06-21 11:50:01
2435	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 11:51:36	2026-06-21 11:51:36
2436	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 11:52:41	2026-06-21 11:52:41
2437	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 11:53:18	2026-06-21 11:53:18
2438	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 11:54:36	2026-06-21 11:54:36
2439	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 11:55:23	2026-06-21 11:55:23
2440	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 11:55:28	2026-06-21 11:55:28
2441	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 11:58:44	2026-06-21 11:58:44
2442	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:00:30	2026-06-21 12:00:30
2443	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:01:02	2026-06-21 12:01:02
2444	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:01:22	2026-06-21 12:01:22
2445	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:01:33	2026-06-21 12:01:33
2446	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:01:41	2026-06-21 12:01:41
2447	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:01:50	2026-06-21 12:01:50
2448	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-21 12:04:27	2026-06-21 12:04:27
2449	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:04:28	2026-06-21 12:04:28
2450	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:05:50	2026-06-21 12:05:50
2451	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:07:12	2026-06-21 12:07:12
2452	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-21 12:07:14	2026-06-21 12:07:14
2453	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-21 12:07:15	2026-06-21 12:07:15
2454	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:07:15	2026-06-21 12:07:15
2455	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-21 12:07:16	2026-06-21 12:07:16
2456	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:07:17	2026-06-21 12:07:17
2457	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:08:09	2026-06-21 12:08:09
2458	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:08:14	2026-06-21 12:08:14
2459	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:08:20	2026-06-21 12:08:20
2460	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/aksesoris	\N	2026-06-21 12:08:31	2026-06-21 12:08:31
2461	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan-muslim-wanita	\N	2026-06-21 12:08:39	2026-06-21 12:08:39
2462	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/pakaian-luar	\N	2026-06-21 12:08:42	2026-06-21 12:08:42
2463	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/sweater-cardigan	\N	2026-06-21 12:08:44	2026-06-21 12:08:44
2464	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	\N	2026-06-21 12:08:46	2026-06-21 12:08:46
2465	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	\N	2026-06-21 12:08:47	2026-06-21 12:08:47
2466	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-21 12:08:49	2026-06-21 12:08:49
2467	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	\N	2026-06-21 12:09:02	2026-06-21 12:09:02
2468	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan-muslim-wanita	\N	2026-06-21 12:09:03	2026-06-21 12:09:03
2469	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/pakaian-luar	\N	2026-06-21 12:09:05	2026-06-21 12:09:05
2470	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/sweater-cardigan	\N	2026-06-21 12:09:06	2026-06-21 12:09:06
2471	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/atasan	\N	2026-06-21 12:09:08	2026-06-21 12:09:08
2472	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	\N	2026-06-21 12:09:09	2026-06-21 12:09:09
2473	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-21 12:09:10	2026-06-21 12:09:10
2474	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	\N	2026-06-21 12:09:10	2026-06-21 12:09:10
2475	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-21 12:09:14	2026-06-21 12:09:14
2476	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	\N	2026-06-21 12:09:14	2026-06-21 12:09:14
2477	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 12:09:16	2026-06-21 12:09:16
2478	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 13:09:06	2026-06-21 13:09:06
2479	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 13:09:43	2026-06-21 13:09:43
2480	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 13:09:59	2026-06-21 13:09:59
2481	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 13:10:45	2026-06-21 13:10:45
2482	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 13:12:57	2026-06-21 13:12:57
2483	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 13:14:19	2026-06-21 13:14:19
2484	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 13:15:29	2026-06-21 13:15:29
2485	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-21 13:15:37	2026-06-21 13:15:37
2486	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-21 13:15:56	2026-06-21 13:15:56
2487	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 13:16:04	2026-06-21 13:16:04
2488	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-21 13:16:16	2026-06-21 13:16:16
2489	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-21 13:16:18	2026-06-21 13:16:18
2490	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-21 13:16:21	2026-06-21 13:16:21
2491	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-21 13:16:24	2026-06-21 13:16:24
2492	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-21 13:16:31	2026-06-21 13:16:31
2493	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-21 13:16:48	2026-06-21 13:16:48
2494	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-21 13:16:50	2026-06-21 13:16:50
2495	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-21 13:16:52	2026-06-21 13:16:52
2496	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-21 13:16:52	2026-06-21 13:16:52
2497	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/52	1	2026-06-21 13:17:02	2026-06-21 13:17:02
2498	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/52	1	2026-06-21 13:17:06	2026-06-21 13:17:06
2499	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/52	1	2026-06-21 13:17:44	2026-06-21 13:17:44
2500	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/52	1	2026-06-21 13:30:37	2026-06-21 13:30:37
2501	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/52	1	2026-06-21 13:30:41	2026-06-21 13:30:41
2502	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/52	1	2026-06-21 13:31:06	2026-06-21 13:31:06
2503	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/52	1	2026-06-21 13:31:12	2026-06-21 13:31:12
2504	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-21 13:31:25	2026-06-21 13:31:25
2505	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-21 13:31:27	2026-06-21 13:31:27
2506	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-21 13:32:44	2026-06-21 13:32:44
2507	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 13:33:03	2026-06-21 13:33:03
2508	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-21 13:33:11	2026-06-21 13:33:11
2509	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-21 13:33:14	2026-06-21 13:33:14
2510	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-21 13:33:15	2026-06-21 13:33:15
2511	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-21 13:33:17	2026-06-21 13:33:17
2512	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/53	1	2026-06-21 13:33:34	2026-06-21 13:33:34
2513	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/53	1	2026-06-21 13:35:17	2026-06-21 13:35:17
2514	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/53	1	2026-06-21 13:35:19	2026-06-21 13:35:19
2515	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/53	1	2026-06-21 13:36:16	2026-06-21 13:36:16
2516	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/53	1	2026-06-21 13:53:29	2026-06-21 13:53:29
2517	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/53	1	2026-06-21 13:54:49	2026-06-21 13:54:49
2518	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/53	1	2026-06-21 13:55:01	2026-06-21 13:55:01
2519	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/53	1	2026-06-21 13:56:12	2026-06-21 13:56:12
2520	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/53	1	2026-06-21 13:56:16	2026-06-21 13:56:16
2521	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/53	1	2026-06-21 13:56:33	2026-06-21 13:56:33
2522	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 13:56:52	2026-06-21 13:56:52
2523	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-21 13:56:55	2026-06-21 13:56:55
2524	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-21 13:57:00	2026-06-21 13:57:00
2525	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-21 13:57:03	2026-06-21 13:57:03
2526	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-21 13:57:04	2026-06-21 13:57:04
2527	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/54	1	2026-06-21 13:57:23	2026-06-21 13:57:23
2528	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/54	1	2026-06-21 13:57:50	2026-06-21 13:57:50
2529	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/paypal/54	1	2026-06-21 13:57:53	2026-06-21 13:57:53
2530	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/54	1	2026-06-21 13:59:47	2026-06-21 13:59:47
2531	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/paypal/54	1	2026-06-21 13:59:52	2026-06-21 13:59:52
2532	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/paypal/54/success	1	2026-06-21 14:04:20	2026-06-21 14:04:20
2533	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/54	1	2026-06-21 14:04:28	2026-06-21 14:04:28
2534	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 14:09:49	2026-06-21 14:09:49
2535	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-21 14:09:56	2026-06-21 14:09:56
2536	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-21 14:10:20	2026-06-21 14:10:20
2537	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-21 14:10:23	2026-06-21 14:10:23
2538	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-21 14:10:27	2026-06-21 14:10:27
2539	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-21 14:10:32	2026-06-21 14:10:32
2540	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/55	1	2026-06-21 14:10:45	2026-06-21 14:10:45
2541	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/55	1	2026-06-21 14:11:22	2026-06-21 14:11:22
2542	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/paypal/55	1	2026-06-21 14:11:25	2026-06-21 14:11:25
2543	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/55	1	2026-06-21 14:11:46	2026-06-21 14:11:46
2544	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 14:11:53	2026-06-21 14:11:53
2545	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-21 14:11:58	2026-06-21 14:11:58
2546	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-21 14:12:01	2026-06-21 14:12:01
2547	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-21 14:12:06	2026-06-21 14:12:06
2548	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-21 14:12:13	2026-06-21 14:12:13
2549	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-21 14:12:16	2026-06-21 14:12:16
2550	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-21 14:12:18	2026-06-21 14:12:18
2551	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-21 14:12:21	2026-06-21 14:12:21
2552	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 14:12:23	2026-06-21 14:12:23
2553	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-21 14:12:31	2026-06-21 14:12:31
2554	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	1	2026-06-21 14:12:36	2026-06-21 14:12:36
2555	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-21 14:12:38	2026-06-21 14:12:38
2556	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-21 14:12:41	2026-06-21 14:12:41
2557	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-21 14:12:45	2026-06-21 14:12:45
2558	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 14:13:03	2026-06-21 14:13:03
2559	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 14:13:27	2026-06-21 14:13:27
2560	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/paypal/56	1	2026-06-21 14:13:29	2026-06-21 14:13:29
2561	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 14:13:49	2026-06-21 14:13:49
2562	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/paypal/56	1	2026-06-21 14:18:34	2026-06-21 14:18:34
2563	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 14:18:38	2026-06-21 14:18:38
2564	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	payment/paypal/56	1	2026-06-21 14:19:30	2026-06-21 14:19:30
2565	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	orders/56	1	2026-06-21 14:19:32	2026-06-21 14:19:32
2566	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	orders/56	1	2026-06-21 14:22:00	2026-06-21 14:22:00
2567	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/56	1	2026-06-21 14:22:43	2026-06-21 14:22:43
2568	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 14:45:07	2026-06-21 14:45:07
2569	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 14:45:34	2026-06-21 14:45:34
2570	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 14:45:38	2026-06-21 14:45:38
2571	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 14:46:21	2026-06-21 14:46:21
2572	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 14:47:22	2026-06-21 14:47:22
2573	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/paypal/56	1	2026-06-21 14:50:57	2026-06-21 14:50:57
2574	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 14:50:59	2026-06-21 14:50:59
2575	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 15:04:33	2026-06-21 15:04:33
2576	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 15:04:55	2026-06-21 15:04:55
2577	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/paypal/56	1	2026-06-21 15:05:22	2026-06-21 15:05:22
2578	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 15:05:27	2026-06-21 15:05:27
2579	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 15:07:25	2026-06-21 15:07:25
2580	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/paypal/56	1	2026-06-21 15:07:29	2026-06-21 15:07:29
2581	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/paypal/56	1	2026-06-21 15:07:51	2026-06-21 15:07:51
2582	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/paypal/56	1	2026-06-21 15:09:26	2026-06-21 15:09:26
2583	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/paypal/56/success	1	2026-06-21 15:10:01	2026-06-21 15:10:01
2584	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/56	1	2026-06-21 15:10:08	2026-06-21 15:10:08
2585	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:10:56	2026-06-21 15:10:56
2586	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	1	2026-06-21 15:11:27	2026-06-21 15:11:27
2587	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:11:28	2026-06-21 15:11:28
2588	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-21 15:11:32	2026-06-21 15:11:32
2589	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:11:33	2026-06-21 15:11:33
2590	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	1	2026-06-21 15:11:46	2026-06-21 15:11:46
2591	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-21 15:11:56	2026-06-21 15:11:56
2592	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-21 15:11:58	2026-06-21 15:11:58
2593	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-21 15:12:01	2026-06-21 15:12:01
2594	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-21 15:12:03	2026-06-21 15:12:03
2595	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-21 15:12:08	2026-06-21 15:12:08
2596	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-21 15:12:09	2026-06-21 15:12:09
2597	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/57	1	2026-06-21 15:12:19	2026-06-21 15:12:19
2598	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/57	1	2026-06-21 15:12:22	2026-06-21 15:12:22
2599	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/57	1	2026-06-21 15:12:30	2026-06-21 15:12:30
2600	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:12:33	2026-06-21 15:12:33
2601	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-21 15:12:37	2026-06-21 15:12:37
2602	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-21 15:12:43	2026-06-21 15:12:43
2603	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-21 15:12:45	2026-06-21 15:12:45
2604	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-21 15:12:46	2026-06-21 15:12:46
2605	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/58	1	2026-06-21 15:12:56	2026-06-21 15:12:56
2606	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/58	1	2026-06-21 15:13:21	2026-06-21 15:13:21
2607	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/58	1	2026-06-21 15:13:29	2026-06-21 15:13:29
2608	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/58	1	2026-06-21 15:14:16	2026-06-21 15:14:16
2609	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/58	1	2026-06-21 15:14:41	2026-06-21 15:14:41
2610	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:18:49	2026-06-21 15:18:49
2611	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	products	1	2026-06-21 15:20:10	2026-06-21 15:20:10
2612	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-21 15:20:13	2026-06-21 15:20:13
2613	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	language/id	1	2026-06-21 15:20:31	2026-06-21 15:20:31
2614	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-21 15:20:32	2026-06-21 15:20:32
2615	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	cart	1	2026-06-21 15:21:04	2026-06-21 15:21:04
2616	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-21 15:21:06	2026-06-21 15:21:06
2617	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	chat	1	2026-06-21 15:21:15	2026-06-21 15:21:15
2618	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-21 15:21:17	2026-06-21 15:21:17
2619	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-21 15:33:03	2026-06-21 15:33:03
2620	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-21 15:33:07	2026-06-21 15:33:07
2621	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-21 15:33:18	2026-06-21 15:33:18
2622	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-21 15:34:12	2026-06-21 15:34:12
2623	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-21 15:34:15	2026-06-21 15:34:15
2624	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-21 15:34:23	2026-06-21 15:34:23
2625	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	1	2026-06-21 15:34:25	2026-06-21 15:34:25
2626	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:34:27	2026-06-21 15:34:27
2627	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:34:51	2026-06-21 15:34:51
2628	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:38:59	2026-06-21 15:38:59
2629	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:41:15	2026-06-21 15:41:15
2630	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:41:33	2026-06-21 15:41:33
2631	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:41:35	2026-06-21 15:41:35
2632	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	cart	1	2026-06-21 15:42:44	2026-06-21 15:42:44
2633	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-21 15:42:46	2026-06-21 15:42:46
2634	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-21 15:42:57	2026-06-21 15:42:57
2635	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:43:07	2026-06-21 15:43:07
2636	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:43:18	2026-06-21 15:43:18
2637	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:43:20	2026-06-21 15:43:20
2638	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-21 15:43:29	2026-06-21 15:43:29
2639	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-21 15:43:30	2026-06-21 15:43:30
2640	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-23 04:16:54	2026-06-23 04:16:54
2641	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-23 04:29:16	2026-06-23 04:29:16
2642	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-23 04:29:40	2026-06-23 04:29:40
2643	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-23 04:31:17	2026-06-23 04:31:17
2644	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-23 04:31:27	2026-06-23 04:31:27
2645	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-23 04:31:28	2026-06-23 04:31:28
2646	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-23 04:31:32	2026-06-23 04:31:32
2647	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-23 04:31:32	2026-06-23 04:31:32
2648	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-23 04:31:43	2026-06-23 04:31:43
2649	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-23 04:31:44	2026-06-23 04:31:44
2650	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	login	\N	2026-06-23 04:32:21	2026-06-23 04:32:21
2651	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:32:41	2026-06-23 04:32:41
2652	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	cart	1	2026-06-23 04:32:53	2026-06-23 04:32:53
2653	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:32:55	2026-06-23 04:32:55
2654	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	cart	1	2026-06-23 04:32:58	2026-06-23 04:32:58
2655	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:32:59	2026-06-23 04:32:59
2656	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:34:56	2026-06-23 04:34:56
2657	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:37:52	2026-06-23 04:37:52
2658	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:38:24	2026-06-23 04:38:24
2659	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:40:06	2026-06-23 04:40:06
2660	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:40:16	2026-06-23 04:40:16
2661	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:40:29	2026-06-23 04:40:29
2662	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:40:54	2026-06-23 04:40:54
2663	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:41:34	2026-06-23 04:41:34
2664	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	language/id	1	2026-06-23 04:41:57	2026-06-23 04:41:57
2665	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:41:57	2026-06-23 04:41:57
2666	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	language/en	1	2026-06-23 04:42:01	2026-06-23 04:42:01
2667	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:42:01	2026-06-23 04:42:01
2668	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	products/korpako-Vs6k	1	2026-06-23 04:42:25	2026-06-23 04:42:25
2669	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:42:52	2026-06-23 04:42:52
2670	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:45:22	2026-06-23 04:45:22
2671	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:45:52	2026-06-23 04:45:52
2672	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:46:28	2026-06-23 04:46:28
2673	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:46:38	2026-06-23 04:46:38
2674	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:47:36	2026-06-23 04:47:36
2675	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:48:21	2026-06-23 04:48:21
2676	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:48:53	2026-06-23 04:48:53
2677	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:49:12	2026-06-23 04:49:12
2678	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:49:33	2026-06-23 04:49:33
2679	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:50:14	2026-06-23 04:50:14
2680	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:50:18	2026-06-23 04:50:18
2681	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	category/atasan-muslim-wanita	1	2026-06-23 04:50:23	2026-06-23 04:50:23
2682	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	/	1	2026-06-23 04:50:26	2026-06-23 04:50:26
2683	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-23 04:53:14	2026-06-23 04:53:14
2684	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-23 04:53:27	2026-06-23 04:53:27
2685	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-23 04:54:12	2026-06-23 04:54:12
2686	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	1	2026-06-23 05:44:16	2026-06-23 05:44:16
2687	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/52	1	2026-06-23 05:44:31	2026-06-23 05:44:31
2688	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/52	1	2026-06-23 05:48:20	2026-06-23 05:48:20
2689	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/52	1	2026-06-23 05:49:04	2026-06-23 05:49:04
2690	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/52	1	2026-06-23 05:50:06	2026-06-23 05:50:06
2691	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/52	1	2026-06-23 05:50:13	2026-06-23 05:50:13
2692	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/52	1	2026-06-23 05:52:19	2026-06-23 05:52:19
2693	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/52	1	2026-06-23 05:52:34	2026-06-23 05:52:34
2694	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/52	1	2026-06-23 05:54:36	2026-06-23 05:54:36
2695	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/52	1	2026-06-23 05:54:48	2026-06-23 05:54:48
2696	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-23 05:54:53	2026-06-23 05:54:53
2697	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-23 05:54:58	2026-06-23 05:54:58
2698	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	1	2026-06-23 05:55:01	2026-06-23 05:55:01
2699	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-23 05:55:03	2026-06-23 05:55:03
2700	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-23 05:55:05	2026-06-23 05:55:05
2701	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-23 05:55:16	2026-06-23 05:55:16
2702	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 05:55:31	2026-06-23 05:55:31
2703	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 05:57:28	2026-06-23 05:57:28
2704	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 05:58:45	2026-06-23 05:58:45
2705	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:00:52	2026-06-23 06:00:52
2706	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:01:55	2026-06-23 06:01:55
2707	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:01:58	2026-06-23 06:01:58
2708	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:02:02	2026-06-23 06:02:02
2709	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:04:48	2026-06-23 06:04:48
2710	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:05:50	2026-06-23 06:05:50
2711	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:05:53	2026-06-23 06:05:53
2712	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:06:12	2026-06-23 06:06:12
2713	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:08:20	2026-06-23 06:08:20
2714	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:08:29	2026-06-23 06:08:29
2715	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:08:59	2026-06-23 06:08:59
2716	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:10:45	2026-06-23 06:10:45
2717	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:11:00	2026-06-23 06:11:00
2718	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:11:48	2026-06-23 06:11:48
2719	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	1	2026-06-23 06:11:58	2026-06-23 06:11:58
2720	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-23 06:17:07	2026-06-23 06:17:07
2721	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/59	\N	2026-06-23 06:21:22	2026-06-23 06:21:22
2722	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-23 06:21:22	2026-06-23 06:21:22
2723	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-23 06:21:30	2026-06-23 06:21:30
2724	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-23 06:21:39	2026-06-23 06:21:39
2725	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-23 08:50:34	2026-06-23 08:50:34
2726	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-23 09:14:25	2026-06-23 09:14:25
2727	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-23 09:14:30	2026-06-23 09:14:30
2728	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-23 09:15:33	2026-06-23 09:15:33
2729	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-23 09:15:53	2026-06-23 09:15:53
2730	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-polos-wanita-atasan-bahan-knit-halus-sweater-rajut-sweater-polos-rajut-SES0	\N	2026-06-23 09:16:06	2026-06-23 09:16:06
2731	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-23 09:16:13	2026-06-23 09:16:13
2732	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-23 09:16:26	2026-06-23 09:16:26
2733	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-polos-wanita-atasan-bahan-knit-halus-sweater-rajut-sweater-polos-rajut-SES0	1	2026-06-23 09:16:34	2026-06-23 09:16:34
2734	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-polos-wanita-atasan-bahan-knit-halus-sweater-rajut-sweater-polos-rajut-SES0	1	2026-06-23 09:16:38	2026-06-23 09:16:38
2735	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-polos-wanita-atasan-bahan-knit-halus-sweater-rajut-sweater-polos-rajut-SES0	1	2026-06-23 09:16:42	2026-06-23 09:16:42
2736	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-23 09:16:44	2026-06-23 09:16:44
2737	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-23 09:17:07	2026-06-23 09:17:07
2738	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	1	2026-06-23 09:17:25	2026-06-23 09:17:25
2739	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/60	1	2026-06-23 09:17:32	2026-06-23 09:17:32
2740	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/60	1	2026-06-23 09:18:36	2026-06-23 09:18:36
2741	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/60	1	2026-06-23 09:19:40	2026-06-23 09:19:40
2742	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 09:19:53	2026-06-23 09:19:53
2743	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 09:20:00	2026-06-23 09:20:00
2744	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/60	1	2026-06-23 09:20:06	2026-06-23 09:20:06
2745	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 09:20:07	2026-06-23 09:20:07
2746	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/60	1	2026-06-23 09:24:06	2026-06-23 09:24:06
2747	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 09:24:06	2026-06-23 09:24:06
2748	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 09:24:08	2026-06-23 09:24:08
2749	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/60	1	2026-06-23 09:24:25	2026-06-23 09:24:25
2750	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 09:24:26	2026-06-23 09:24:26
2751	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 09:24:28	2026-06-23 09:24:28
2752	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 09:24:40	2026-06-23 09:24:40
2753	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 09:24:54	2026-06-23 09:24:54
2754	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 09:25:43	2026-06-23 09:25:43
2755	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 09:26:05	2026-06-23 09:26:05
2756	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/60	1	2026-06-23 09:27:09	2026-06-23 09:27:09
2757	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 09:27:10	2026-06-23 09:27:10
2758	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/60	1	2026-06-23 11:00:04	2026-06-23 11:00:04
2759	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 11:00:07	2026-06-23 11:00:07
2760	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/60	1	2026-06-23 11:00:19	2026-06-23 11:00:19
2761	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/zS3kJcU0YWN8VxUdHh0k8VXD	1	2026-06-23 11:00:20	2026-06-23 11:00:20
2762	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-23 11:00:45	2026-06-23 11:00:45
2763	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	1	2026-06-23 11:01:49	2026-06-23 11:01:49
2764	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tentang-kami	1	2026-06-23 11:01:58	2026-06-23 11:01:58
2765	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-23 12:48:14	2026-06-23 12:48:14
2766	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	1	2026-06-23 12:48:40	2026-06-23 12:48:40
2767	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-23 12:48:41	2026-06-23 12:48:41
2768	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-2212-lumi-blouse-blouse-tali-belakang-atasan-tali-belakang-bahan-polo-linen-qu5S	1	2026-06-23 12:48:47	2026-06-23 12:48:47
2769	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-2212-lumi-blouse-blouse-tali-belakang-atasan-tali-belakang-bahan-polo-linen-qu5S	1	2026-06-23 12:48:50	2026-06-23 12:48:50
2770	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	1	2026-06-23 12:48:52	2026-06-23 12:48:52
2771	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	1	2026-06-23 12:48:55	2026-06-23 12:48:55
2772	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 03:55:19	2026-06-24 03:55:19
2773	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 03:55:24	2026-06-24 03:55:24
2774	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 03:55:25	2026-06-24 03:55:25
2775	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 04:08:08	2026-06-24 04:08:08
2776	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 04:08:41	2026-06-24 04:08:41
2777	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 04:09:02	2026-06-24 04:09:02
2778	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 04:10:18	2026-06-24 04:10:18
2779	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	register	\N	2026-06-24 04:11:06	2026-06-24 04:11:06
2780	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	4	2026-06-24 04:11:34	2026-06-24 04:11:34
2781	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	4	2026-06-24 04:11:52	2026-06-24 04:11:52
2782	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	4	2026-06-24 04:11:55	2026-06-24 04:11:55
2783	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	4	2026-06-24 04:12:06	2026-06-24 04:12:06
2784	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	4	2026-06-24 04:12:15	2026-06-24 04:12:15
2785	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	4	2026-06-24 04:12:20	2026-06-24 04:12:20
2786	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tentang-kami	4	2026-06-24 04:35:07	2026-06-24 04:35:07
2787	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tentang-kami	4	2026-06-24 04:36:59	2026-06-24 04:36:59
2788	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	4	2026-06-24 04:37:54	2026-06-24 04:37:54
2789	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	4	2026-06-24 04:38:34	2026-06-24 04:38:34
2790	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products	4	2026-06-24 04:39:33	2026-06-24 04:39:33
2791	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	4	2026-06-24 04:40:02	2026-06-24 04:40:02
2792	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	4	2026-06-24 04:59:52	2026-06-24 04:59:52
2793	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	4	2026-06-24 04:59:59	2026-06-24 04:59:59
2794	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	4	2026-06-24 05:00:31	2026-06-24 05:00:31
2795	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	\N	2026-06-24 07:15:09	2026-06-24 07:15:09
2796	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 07:15:12	2026-06-24 07:15:12
2797	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 07:17:44	2026-06-24 07:17:44
2798	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 07:18:00	2026-06-24 07:18:00
2799	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 07:20:23	2026-06-24 07:20:23
2800	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 07:21:15	2026-06-24 07:21:15
2801	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 07:22:52	2026-06-24 07:22:52
2802	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 07:23:55	2026-06-24 07:23:55
2803	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 07:24:17	2026-06-24 07:24:17
2804	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 07:24:25	2026-06-24 07:24:25
2805	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 07:24:56	2026-06-24 07:24:56
2806	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 07:25:33	2026-06-24 07:25:33
2807	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	register	\N	2026-06-24 07:25:37	2026-06-24 07:25:37
2808	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	email/verify	5	2026-06-24 07:26:16	2026-06-24 07:26:16
2809	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	email/verify/5/98fe2f161791aec5a9da8fee326e6b85c5617389	\N	2026-06-24 07:26:51	2026-06-24 07:26:51
2810	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-24 07:26:52	2026-06-24 07:26:52
2811	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:27:05	2026-06-24 07:27:05
2812	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:28:32	2026-06-24 07:28:32
2813	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:32:42	2026-06-24 07:32:42
2814	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:32:44	2026-06-24 07:32:44
2815	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/celana	5	2026-06-24 07:32:51	2026-06-24 07:32:51
2816	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	5	2026-06-24 07:32:54	2026-06-24 07:32:54
2817	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	5	2026-06-24 07:33:51	2026-06-24 07:33:51
2818	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:33:54	2026-06-24 07:33:54
2819	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	5	2026-06-24 07:33:56	2026-06-24 07:33:56
2820	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	5	2026-06-24 07:34:07	2026-06-24 07:34:07
2821	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:34:38	2026-06-24 07:34:38
2822	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	5	2026-06-24 07:34:42	2026-06-24 07:34:42
2823	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/12	5	2026-06-24 07:34:44	2026-06-24 07:34:44
2824	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/12	5	2026-06-24 07:34:54	2026-06-24 07:34:54
2825	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:35:13	2026-06-24 07:35:13
2826	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	5	2026-06-24 07:35:26	2026-06-24 07:35:26
2827	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/12	5	2026-06-24 07:35:27	2026-06-24 07:35:27
2828	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat	5	2026-06-24 07:35:32	2026-06-24 07:35:32
2829	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:35:34	2026-06-24 07:35:34
2830	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/12	5	2026-06-24 07:37:55	2026-06-24 07:37:55
2831	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:37:56	2026-06-24 07:37:56
2832	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/12	5	2026-06-24 07:38:02	2026-06-24 07:38:02
2833	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:38:02	2026-06-24 07:38:02
2834	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:38:37	2026-06-24 07:38:37
2835	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/12	5	2026-06-24 07:38:38	2026-06-24 07:38:38
2836	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/12	5	2026-06-24 07:38:51	2026-06-24 07:38:51
2837	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:38:52	2026-06-24 07:38:52
2838	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:39:27	2026-06-24 07:39:27
2839	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/12	5	2026-06-24 07:39:28	2026-06-24 07:39:28
2840	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:40:06	2026-06-24 07:40:06
2841	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/12	5	2026-06-24 07:40:07	2026-06-24 07:40:07
2842	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/12	5	2026-06-24 07:40:58	2026-06-24 07:40:58
2843	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:40:59	2026-06-24 07:40:59
2844	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/12	5	2026-06-24 07:41:07	2026-06-24 07:41:07
2845	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 07:41:08	2026-06-24 07:41:08
2846	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 09:17:06	2026-06-24 09:17:06
2847	127.0.0.1	WhatsApp/2.23.20.0	/	\N	2026-06-24 09:17:41	2026-06-24 09:17:41
2848	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/korpako-Vs6k	\N	2026-06-24 09:18:00	2026-06-24 09:18:00
2849	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:18:02	2026-06-24 09:18:02
2850	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:18:22	2026-06-24 09:18:22
2851	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/12	5	2026-06-24 09:19:10	2026-06-24 09:19:10
2852	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 09:19:19	2026-06-24 09:19:19
2853	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:19:34	2026-06-24 09:19:34
2854	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 09:19:58	2026-06-24 09:19:58
2855	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 09:20:36	2026-06-24 09:20:36
2856	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	/	\N	2026-06-24 09:20:59	2026-06-24 09:20:59
2857	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:21:10	2026-06-24 09:21:10
2858	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:21:31	2026-06-24 09:21:31
2859	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 09:24:02	2026-06-24 09:24:02
2860	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 09:24:02	2026-06-24 09:24:02
2861	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	chat/12	5	2026-06-24 09:24:04	2026-06-24 09:24:04
2862	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:24:29	2026-06-24 09:24:29
2863	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:24:40	2026-06-24 09:24:40
2864	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 09:26:23	2026-06-24 09:26:23
2865	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 09:27:46	2026-06-24 09:27:46
2866	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 09:29:52	2026-06-24 09:29:52
2867	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:30:02	2026-06-24 09:30:02
2868	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:30:44	2026-06-24 09:30:44
2869	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:30:44	2026-06-24 09:30:44
2870	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:30:45	2026-06-24 09:30:45
2871	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	products	\N	2026-06-24 09:31:18	2026-06-24 09:31:18
2872	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:31:21	2026-06-24 09:31:21
2873	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	\N	2026-06-24 09:31:27	2026-06-24 09:31:27
2874	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	login	\N	2026-06-24 09:31:31	2026-06-24 09:31:31
2875	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	login	\N	2026-06-24 09:33:07	2026-06-24 09:33:07
2876	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	register	\N	2026-06-24 09:33:09	2026-06-24 09:33:09
2877	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:33:11	2026-06-24 09:33:11
2878	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:46	2026-06-24 09:34:46
2879	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:34:47	2026-06-24 09:34:47
2880	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:47	2026-06-24 09:34:47
2881	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/id	\N	2026-06-24 09:34:48	2026-06-24 09:34:48
2882	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:48	2026-06-24 09:34:48
2883	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:49	2026-06-24 09:34:49
2884	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:49	2026-06-24 09:34:49
2885	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:50	2026-06-24 09:34:50
2886	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:51	2026-06-24 09:34:51
2887	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:51	2026-06-24 09:34:51
2888	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:52	2026-06-24 09:34:52
2889	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:53	2026-06-24 09:34:53
2890	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:53	2026-06-24 09:34:53
2891	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:53	2026-06-24 09:34:53
2892	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:54	2026-06-24 09:34:54
2893	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:54	2026-06-24 09:34:54
2894	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:55	2026-06-24 09:34:55
2895	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:57	2026-06-24 09:34:57
2896	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:58	2026-06-24 09:34:58
2897	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:58	2026-06-24 09:34:58
2898	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:34:59	2026-06-24 09:34:59
2899	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:35:00	2026-06-24 09:35:00
2900	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:35:00	2026-06-24 09:35:00
2901	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:35:01	2026-06-24 09:35:01
2902	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:35:01	2026-06-24 09:35:01
2903	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:35:02	2026-06-24 09:35:02
2904	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:35:03	2026-06-24 09:35:03
2905	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	register	\N	2026-06-24 09:35:03	2026-06-24 09:35:03
2906	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 09:35:04	2026-06-24 09:35:04
2907	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-24 09:35:59	2026-06-24 09:35:59
2908	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	1	2026-06-24 09:36:14	2026-06-24 09:36:14
2909	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-24 09:36:27	2026-06-24 09:36:27
2910	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	register	\N	2026-06-24 09:36:31	2026-06-24 09:36:31
2911	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	register	\N	2026-06-24 09:37:00	2026-06-24 09:37:00
2912	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:37:49	2026-06-24 09:37:49
2913	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-24 09:37:52	2026-06-24 09:37:52
2914	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	register	\N	2026-06-24 09:37:53	2026-06-24 09:37:53
2915	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-24 09:38:04	2026-06-24 09:38:04
2916	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	register	\N	2026-06-24 09:38:27	2026-06-24 09:38:27
2917	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	login	\N	2026-06-24 09:38:33	2026-06-24 09:38:33
2918	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	/	7	2026-06-24 09:38:53	2026-06-24 09:38:53
2919	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	products/korpako-Vs6k	7	2026-06-24 09:38:59	2026-06-24 09:38:59
2920	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	chat/13	7	2026-06-24 09:39:04	2026-06-24 09:39:04
2921	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	chat/13	7	2026-06-24 09:39:10	2026-06-24 09:39:10
2922	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	tentang-kami	7	2026-06-24 09:39:47	2026-06-24 09:39:47
2923	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	kontak	7	2026-06-24 09:40:02	2026-06-24 09:40:02
2924	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	chat	7	2026-06-24 09:40:13	2026-06-24 09:40:13
2925	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	chat/13	7	2026-06-24 09:40:15	2026-06-24 09:40:15
2926	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	chat/13	7	2026-06-24 09:40:23	2026-06-24 09:40:23
2927	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	chat	7	2026-06-24 09:40:26	2026-06-24 09:40:26
2928	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	/	7	2026-06-24 09:40:27	2026-06-24 09:40:27
2929	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	chat	7	2026-06-24 09:40:44	2026-06-24 09:40:44
2930	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	orders	7	2026-06-24 09:40:48	2026-06-24 09:40:48
2931	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	orders	7	2026-06-24 09:40:49	2026-06-24 09:40:49
2932	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	orders	7	2026-06-24 09:40:49	2026-06-24 09:40:49
2933	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	orders	7	2026-06-24 09:40:49	2026-06-24 09:40:49
2934	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	orders	7	2026-06-24 09:40:50	2026-06-24 09:40:50
2935	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	orders	7	2026-06-24 09:40:50	2026-06-24 09:40:50
2936	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	profile	7	2026-06-24 09:41:17	2026-06-24 09:41:17
2937	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 09:41:58	2026-06-24 09:41:58
2938	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	login	\N	2026-06-24 09:42:02	2026-06-24 09:42:02
2939	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	5	2026-06-24 09:42:19	2026-06-24 09:42:19
2940	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	chat	5	2026-06-24 09:42:21	2026-06-24 09:42:21
2941	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	chat	5	2026-06-24 09:42:22	2026-06-24 09:42:22
2942	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	chat	5	2026-06-24 09:42:24	2026-06-24 09:42:24
2943	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	chat	5	2026-06-24 09:42:34	2026-06-24 09:42:34
2944	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	orders	5	2026-06-24 09:42:37	2026-06-24 09:42:37
2945	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	profile	5	2026-06-24 09:42:39	2026-06-24 09:42:39
2946	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	profile	5	2026-06-24 09:45:31	2026-06-24 09:45:31
2947	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	5	2026-06-24 09:45:40	2026-06-24 09:45:40
2948	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	5	2026-06-24 09:45:41	2026-06-24 09:45:41
2949	127.0.0.1	facebookexternalhit/1.1;line-poker/1.0	/	\N	2026-06-24 09:46:16	2026-06-24 09:46:16
2950	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	/	7	2026-06-24 09:46:16	2026-06-24 09:46:16
2951	127.0.0.1	facebookexternalhit/1.1;line-poker/1.0	/	\N	2026-06-24 09:46:23	2026-06-24 09:46:23
2952	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	/	7	2026-06-24 09:46:24	2026-06-24 09:46:24
2953	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	notifications/272/read	7	2026-06-24 09:46:31	2026-06-24 09:46:31
2954	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	chat/13	7	2026-06-24 09:46:31	2026-06-24 09:46:31
2955	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	/	\N	2026-06-24 09:46:35	2026-06-24 09:46:35
2956	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	chat	7	2026-06-24 09:46:35	2026-06-24 09:46:35
2957	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	language/en	7	2026-06-24 09:46:47	2026-06-24 09:46:47
2958	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	chat	7	2026-06-24 09:46:48	2026-06-24 09:46:48
2959	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	cart	7	2026-06-24 09:46:56	2026-06-24 09:46:56
2960	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3 Mobile/15E148 Safari/604.1	/	7	2026-06-24 09:46:59	2026-06-24 09:46:59
2961	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	category/atasan	\N	2026-06-24 09:47:03	2026-06-24 09:47:03
2962	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	products/basariid-2212-lumi-blouse-blouse-tali-belakang-atasan-tali-belakang-bahan-polo-linen-qu5S	\N	2026-06-24 09:47:07	2026-06-24 09:47:07
2963	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	login	\N	2026-06-24 09:47:15	2026-06-24 09:47:15
2964	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	category/atasan	\N	2026-06-24 09:47:30	2026-06-24 09:47:30
2965	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	/	\N	2026-06-24 09:47:34	2026-06-24 09:47:34
2966	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	language/en	\N	2026-06-24 09:47:40	2026-06-24 09:47:40
2967	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	/	\N	2026-06-24 09:47:40	2026-06-24 09:47:40
2968	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	login	\N	2026-06-24 09:48:33	2026-06-24 09:48:33
2969	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	login	\N	2026-06-24 09:48:41	2026-06-24 09:48:41
2970	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	language/id	\N	2026-06-24 09:48:44	2026-06-24 09:48:44
2971	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	login	\N	2026-06-24 09:48:45	2026-06-24 09:48:45
2972	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	language/en	\N	2026-06-24 09:48:47	2026-06-24 09:48:47
2973	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Safari Line/15.4.2	login	\N	2026-06-24 09:48:48	2026-06-24 09:48:48
2974	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/id	5	2026-06-24 09:49:03	2026-06-24 09:49:03
2975	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	5	2026-06-24 09:49:04	2026-06-24 09:49:04
2976	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	5	2026-06-24 09:49:07	2026-06-24 09:49:07
2977	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	5	2026-06-24 09:49:08	2026-06-24 09:49:08
2978	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	5	2026-06-24 09:54:26	2026-06-24 09:54:26
2979	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	tentang-kami	5	2026-06-24 10:09:57	2026-06-24 10:09:57
2980	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	kontak	5	2026-06-24 10:10:16	2026-06-24 10:10:16
2981	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	category/pakaian-luar	\N	2026-06-24 11:09:10	2026-06-24 11:09:10
2982	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 11:09:18	2026-06-24 11:09:18
2983	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 12:03:16	2026-06-24 12:03:16
2984	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 12:11:27	2026-06-24 12:11:27
2985	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 12:11:29	2026-06-24 12:11:29
2986	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 12:11:35	2026-06-24 12:11:35
2987	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 12:12:10	2026-06-24 12:12:10
2988	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 12:25:45	2026-06-24 12:25:45
2989	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	kontak	\N	2026-06-24 12:26:13	2026-06-24 12:26:13
2990	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	kontak	\N	2026-06-24 12:26:17	2026-06-24 12:26:17
2991	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 12:26:34	2026-06-24 12:26:34
2992	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 12:27:45	2026-06-24 12:27:45
2993	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 12:45:51	2026-06-24 12:45:51
2994	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 12:47:01	2026-06-24 12:47:01
2995	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	products	\N	2026-06-24 12:47:17	2026-06-24 12:47:17
2996	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 14:13:52	2026-06-24 14:13:52
2997	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:14:54	2026-06-24 14:14:54
2998	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:15:03	2026-06-24 14:15:03
2999	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:16:44	2026-06-24 14:16:44
3000	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:17:44	2026-06-24 14:17:44
3001	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 14:17:53	2026-06-24 14:17:53
3002	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:17:54	2026-06-24 14:17:54
3003	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 14:17:54	2026-06-24 14:17:54
3004	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:17:54	2026-06-24 14:17:54
3005	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/en	\N	2026-06-24 14:17:57	2026-06-24 14:17:57
3006	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:17:57	2026-06-24 14:17:57
3007	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:18:46	2026-06-24 14:18:46
3008	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:19:19	2026-06-24 14:19:19
3009	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 14:23:36	2026-06-24 14:23:36
3010	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:24:01	2026-06-24 14:24:01
3011	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	category/atasan-muslim-wanita	\N	2026-06-24 14:24:29	2026-06-24 14:24:29
3012	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:24:37	2026-06-24 14:24:37
3013	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 14:29:28	2026-06-24 14:29:28
3014	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	kontak	\N	2026-06-24 14:30:12	2026-06-24 14:30:12
3015	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:31:27	2026-06-24 14:31:27
3016	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/id	\N	2026-06-24 14:31:39	2026-06-24 14:31:39
3017	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:31:40	2026-06-24 14:31:40
3018	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	language/id	\N	2026-06-24 14:31:41	2026-06-24 14:31:41
3019	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Mobile/15E148 Safari/604.1	/	\N	2026-06-24 14:31:41	2026-06-24 14:31:41
3020	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 14:33:36	2026-06-24 14:33:36
3021	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-24 14:34:15	2026-06-24 14:34:15
3022	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 14:34:19	2026-06-24 14:34:19
3023	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 14:36:19	2026-06-24 14:36:19
3024	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 14:38:12	2026-06-24 14:38:12
3025	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/id	\N	2026-06-24 14:41:15	2026-06-24 14:41:15
3026	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 14:41:15	2026-06-24 14:41:15
3027	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	language/en	\N	2026-06-24 14:41:21	2026-06-24 14:41:21
3028	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 14:41:21	2026-06-24 14:41:21
3029	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tentang-kami	\N	2026-06-24 14:55:28	2026-06-24 14:55:28
3030	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 14:59:17	2026-06-24 14:59:17
3031	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-24 15:07:06	2026-06-24 15:07:06
3032	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 15:07:38	2026-06-24 15:07:38
3033	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-24 16:17:53	2026-06-24 16:17:53
3034	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-24 16:18:01	2026-06-24 16:18:01
3035	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-24 16:18:04	2026-06-24 16:18:04
3036	127.0.0.1	WhatsApp/2.23.20.0	/	\N	2026-06-25 16:06:52	2026-06-25 16:06:52
3037	127.0.0.1	WhatsApp/2.23.20.0	orders	\N	2026-06-25 16:20:10	2026-06-25 16:20:10
3038	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	orders	\N	2026-06-25 16:28:50	2026-06-25 16:28:50
3039	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	login	\N	2026-06-25 16:28:51	2026-06-25 16:28:51
3040	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	/	7	2026-06-25 16:29:38	2026-06-25 16:29:38
3041	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	login	7	2026-06-25 16:30:10	2026-06-25 16:30:10
3042	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	/	7	2026-06-25 16:30:28	2026-06-25 16:30:28
3043	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	7	2026-06-25 16:30:38	2026-06-25 16:30:38
3044	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	7	2026-06-25 16:30:47	2026-06-25 16:30:47
3045	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	7	2026-06-25 16:31:47	2026-06-25 16:31:47
3046	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	7	2026-06-25 16:31:55	2026-06-25 16:31:55
3047	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	cart	7	2026-06-25 16:31:58	2026-06-25 16:31:58
3048	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	cart	7	2026-06-25 16:32:06	2026-06-25 16:32:06
3049	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	checkout	7	2026-06-25 16:32:09	2026-06-25 16:32:09
3050	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	email/verify	7	2026-06-25 16:32:10	2026-06-25 16:32:10
3091	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/61	5	2026-06-26 00:44:33	2026-06-26 00:44:33
3051	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	email/verify	7	2026-06-25 16:32:30	2026-06-25 16:32:30
3052	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-25 16:33:23	2026-06-25 16:33:23
3053	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	email/verify	7	2026-06-25 16:33:24	2026-06-25 16:33:24
3054	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-25 16:33:31	2026-06-25 16:33:31
3055	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-25 16:33:49	2026-06-25 16:33:49
3056	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	5	2026-06-25 16:33:54	2026-06-25 16:33:54
3057	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	products/basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	5	2026-06-25 16:34:02	2026-06-25 16:34:02
3058	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	5	2026-06-25 16:34:04	2026-06-25 16:34:04
3059	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	5	2026-06-25 16:34:06	2026-06-25 16:34:06
3060	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	email/verify	5	2026-06-25 16:34:06	2026-06-25 16:34:06
3061	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	email/verify	5	2026-06-25 16:34:25	2026-06-25 16:34:25
3062	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	email/verify	7	2026-06-25 16:34:35	2026-06-25 16:34:35
3063	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	email/verify/5/98fe2f161791aec5a9da8fee326e6b85c5617389	\N	2026-06-25 16:34:56	2026-06-25 16:34:56
3064	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-25 16:34:56	2026-06-25 16:34:56
3065	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-25 16:35:17	2026-06-25 16:35:17
3066	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	5	2026-06-25 16:35:21	2026-06-25 16:35:21
3067	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	5	2026-06-25 16:35:27	2026-06-25 16:35:27
3068	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	email/verify	5	2026-06-25 16:35:27	2026-06-25 16:35:27
3069	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	login	\N	2026-06-25 16:36:41	2026-06-25 16:36:41
3070	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	/	7	2026-06-25 16:37:01	2026-06-25 16:37:01
3071	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	cart	7	2026-06-25 16:37:05	2026-06-25 16:37:05
3072	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	checkout	7	2026-06-25 16:37:09	2026-06-25 16:37:09
3073	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	email/verify	7	2026-06-25 16:37:09	2026-06-25 16:37:09
3074	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0	email/verify	7	2026-06-25 16:37:19	2026-06-25 16:37:19
3075	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-26 00:22:54	2026-06-26 00:22:54
3076	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-26 00:23:05	2026-06-26 00:23:05
3077	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-26 00:23:33	2026-06-26 00:23:33
3078	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	5	2026-06-26 00:23:42	2026-06-26 00:23:42
3079	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	5	2026-06-26 00:23:45	2026-06-26 00:23:45
3080	127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1	checkout	5	2026-06-26 00:30:51	2026-06-26 00:30:51
3081	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-26 00:34:26	2026-06-26 00:34:26
3082	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	login	\N	2026-06-26 00:34:29	2026-06-26 00:34:29
3083	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	5	2026-06-26 00:34:44	2026-06-26 00:34:44
3084	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	cart	5	2026-06-26 00:34:51	2026-06-26 00:34:51
3085	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	checkout	5	2026-06-26 00:34:53	2026-06-26 00:34:53
3086	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	5	2026-06-26 00:35:04	2026-06-26 00:35:04
3087	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping/search-location	5	2026-06-26 00:35:09	2026-06-26 00:35:09
3088	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/61	5	2026-06-26 00:35:23	2026-06-26 00:35:23
3089	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/61	5	2026-06-26 00:35:28	2026-06-26 00:35:28
3090	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/61	5	2026-06-26 00:44:30	2026-06-26 00:44:30
3092	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/61	5	2026-06-26 00:45:19	2026-06-26 00:45:19
3093	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment/61	5	2026-06-26 00:45:22	2026-06-26 00:45:22
3094	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/61	5	2026-06-26 00:45:41	2026-06-26 00:45:41
3095	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/oMB8Zn36j0JnAIXVZyuh0tgG	5	2026-06-26 00:47:15	2026-06-26 00:47:15
3096	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/oMB8Zn36j0JnAIXVZyuh0tgG	5	2026-06-26 00:47:21	2026-06-26 00:47:21
3097	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/61	5	2026-06-26 00:47:24	2026-06-26 00:47:24
3098	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/oMB8Zn36j0JnAIXVZyuh0tgG	5	2026-06-26 00:47:25	2026-06-26 00:47:25
3099	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/oMB8Zn36j0JnAIXVZyuh0tgG	5	2026-06-26 00:52:27	2026-06-26 00:52:27
3100	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/61	5	2026-06-26 00:52:41	2026-06-26 00:52:41
3101	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/oMB8Zn36j0JnAIXVZyuh0tgG	5	2026-06-26 00:52:42	2026-06-26 00:52:42
3102	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/61	5	2026-06-26 00:53:12	2026-06-26 00:53:12
3103	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/oMB8Zn36j0JnAIXVZyuh0tgG	5	2026-06-26 00:53:13	2026-06-26 00:53:13
3104	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/61	5	2026-06-26 01:25:51	2026-06-26 01:25:51
3105	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/oMB8Zn36j0JnAIXVZyuh0tgG	5	2026-06-26 01:25:52	2026-06-26 01:25:52
3106	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/oMB8Zn36j0JnAIXVZyuh0tgG	5	2026-06-26 01:26:04	2026-06-26 01:26:04
3107	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/61	5	2026-06-26 01:34:13	2026-06-26 01:34:13
3108	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/oMB8Zn36j0JnAIXVZyuh0tgG	5	2026-06-26 01:34:15	2026-06-26 01:34:15
3109	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	lacak-pesanan	5	2026-06-26 01:34:25	2026-06-26 01:34:25
3110	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	lacak-pesanan	5	2026-06-26 01:34:57	2026-06-26 01:34:57
3111	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	lacak-pesanan	5	2026-06-26 01:35:20	2026-06-26 01:35:20
3112	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders	5	2026-06-26 01:36:17	2026-06-26 01:36:17
3113	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/61	5	2026-06-26 01:36:19	2026-06-26 01:36:19
3114	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/oMB8Zn36j0JnAIXVZyuh0tgG	5	2026-06-26 01:36:21	2026-06-26 01:36:21
3115	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/oMB8Zn36j0JnAIXVZyuh0tgG	5	2026-06-26 01:36:39	2026-06-26 01:36:39
3116	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	orders/61	5	2026-06-26 01:36:46	2026-06-26 01:36:46
3117	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	tracking/oMB8Zn36j0JnAIXVZyuh0tgG	5	2026-06-26 01:36:47	2026-06-26 01:36:47
3118	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	lacak-pesanan	5	2026-06-26 01:36:56	2026-06-26 01:36:56
3119	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	/	\N	2026-06-26 04:08:25	2026-06-26 04:08:25
3120	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	payment-method	\N	2026-06-26 04:08:38	2026-06-26 04:08:38
3121	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	payment-method	\N	2026-06-26 04:10:24	2026-06-26 04:10:24
3122	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	payment-method	\N	2026-06-26 04:12:17	2026-06-26 04:12:17
3123	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	payment-method	\N	2026-06-26 04:12:58	2026-06-26 04:12:58
3124	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	payment-method	\N	2026-06-26 04:15:11	2026-06-26 04:15:11
3125	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	payment-method	\N	2026-06-26 04:16:14	2026-06-26 04:16:14
3126	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	payment-method	\N	2026-06-26 04:23:57	2026-06-26 04:23:57
3127	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	payment-method	\N	2026-06-26 06:41:54	2026-06-26 06:41:54
3128	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	/	\N	2026-06-26 07:03:07	2026-06-26 07:03:07
3129	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	payment-method	\N	2026-06-26 07:03:19	2026-06-26 07:03:19
3130	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	payment-method	\N	2026-06-26 07:06:06	2026-06-26 07:06:06
3131	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	payment-method	\N	2026-06-26 07:06:40	2026-06-26 07:06:40
3132	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	/	\N	2026-06-26 07:07:47	2026-06-26 07:07:47
3133	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	payment-method	\N	2026-06-26 07:08:06	2026-06-26 07:08:06
3134	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	shipping-information	\N	2026-06-26 07:08:50	2026-06-26 07:08:50
3135	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	return-exchange	\N	2026-06-26 07:09:26	2026-06-26 07:09:26
3136	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	faq	\N	2026-06-26 07:09:36	2026-06-26 07:09:36
3137	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	how-to-order	\N	2026-06-26 07:09:51	2026-06-26 07:09:51
3138	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	lacak-pesanan	\N	2026-06-26 07:11:52	2026-06-26 07:11:52
\.


--
-- Data for Name: product_colors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_colors (id, product_id, name, hex_code, image_index, sort_order, created_at, updated_at, stock) FROM stdin;
100	11	Maroon	#9b1037	7	0	2026-06-08 12:39:12	2026-06-08 12:39:12	9
101	11	Putih	#ffffff	1	1	2026-06-08 12:39:12	2026-06-08 12:39:12	9
102	11	Biru	#839dce	4	2	2026-06-08 12:39:12	2026-06-08 12:39:12	9
103	11	Cream	#cab68b	5	3	2026-06-08 12:39:12	2026-06-08 12:39:12	7
104	11	Abu	#afaea8	3	4	2026-06-08 12:39:12	2026-06-08 12:39:12	6
105	11	Hitam	#000000	0	5	2026-06-08 12:39:12	2026-06-08 12:39:12	12
106	10	Black	#000000	1	0	2026-06-08 13:26:38	2026-06-08 13:26:38	21
107	10	Silver Pink	#cb8688	0	1	2026-06-08 13:26:38	2026-06-08 13:26:38	7
108	9	Navy	#243163	0	0	2026-06-09 03:51:03	2026-06-09 03:51:03	12
109	9	Dark Navy	#151c35	2	1	2026-06-09 03:51:03	2026-06-09 03:51:03	11
110	9	Broken White	#d5d5d1	1	2	2026-06-09 03:51:03	2026-06-09 03:51:03	12
111	12	Light Brown	#d3c1ba	3	0	2026-06-09 09:37:09	2026-06-09 09:37:09	5
112	12	Navy	#171f37	4	1	2026-06-09 09:37:09	2026-06-09 09:37:09	4
113	12	Toffe	#553829	2	2	2026-06-09 09:37:09	2026-06-09 09:37:09	6
114	12	Red Cherry	#bd274e	1	3	2026-06-09 09:37:09	2026-06-09 09:37:09	7
115	14	Hitam	#000000	3	0	2026-06-09 09:53:11	2026-06-09 09:53:11	4
116	14	Abu Misty	#5d5956	5	1	2026-06-09 09:53:11	2026-06-09 09:53:11	5
117	14	Choco	#793b3c	0	2	2026-06-09 09:53:11	2026-06-09 09:53:11	4
118	14	Oatmeal	#e0cebb	2	3	2026-06-09 09:53:11	2026-06-09 09:53:11	3
119	14	Navy	#0e1542	1	4	2026-06-09 09:53:11	2026-06-09 09:53:11	2
120	16	Black	#000000	2	0	2026-06-09 10:05:45	2026-06-09 10:05:45	5
121	16	Broken White	#e5dfe3	3	1	2026-06-09 10:05:45	2026-06-09 10:05:45	5
145	20	BLack	#000000	0	0	2026-06-15 05:36:19	2026-06-15 05:36:19	0
170	19	Black	#000000	1	0	2026-06-19 04:27:05	2026-06-19 04:27:05	15
171	19	Coklat Muda / Cream	#cea8a0	4	1	2026-06-19 04:27:05	2026-06-19 04:27:05	14
172	17	Black	#000000	3	0	2026-06-19 04:29:09	2026-06-19 04:29:09	15
173	17	Pure White	#fafafa	1	1	2026-06-19 04:29:09	2026-06-19 04:29:09	10
174	17	Mocca	#706660	2	2	2026-06-19 04:29:09	2026-06-19 04:29:09	5
178	21	Navy	#b8b7b4	0	0	2026-06-24 04:40:49	2026-06-24 04:40:49	8
179	21	Putih	#ffffff	1	1	2026-06-24 04:40:49	2026-06-24 04:40:49	1
180	21	Mocca	#000000	2	2	2026-06-24 04:40:49	2026-06-24 04:40:49	1
\.


--
-- Data for Name: product_sizes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_sizes (id, product_id, size, stock, created_at, updated_at) FROM stdin;
61	11	ALL SIZE	100	2026-06-08 12:39:12	2026-06-08 12:39:12
62	10	ALL SIZE	40	2026-06-08 13:26:38	2026-06-08 13:26:38
63	9	ALL SIZE	60	2026-06-09 03:51:03	2026-06-09 03:51:03
64	12	ALL SIZE	30	2026-06-09 09:37:08	2026-06-09 09:37:08
65	13	ALL SIZE	9	2026-06-09 09:40:32	2026-06-09 09:40:32
67	14	M	10	2026-06-09 09:53:11	2026-06-09 09:53:11
69	16	ALL SIZE	10	2026-06-09 10:05:45	2026-06-09 10:05:45
68	15	ALL SIZE	9	2026-06-09 09:59:26	2026-06-11 04:10:13
110	17	ALL SIZE	28	2026-06-19 04:29:09	2026-06-21 14:13:03
97	20	L	0	2026-06-15 05:36:19	2026-06-15 05:36:19
98	20	XL	0	2026-06-15 05:36:19	2026-06-15 05:36:19
99	20	M	0	2026-06-15 05:36:19	2026-06-15 05:36:19
66	14	S	9	2026-06-09 09:53:11	2026-06-23 09:17:32
115	21	ALL SIZE	8	2026-06-24 04:40:49	2026-06-24 04:40:49
109	19	ALL SIZE	23	2026-06-19 04:27:05	2026-06-26 00:35:22
114	18	ALL SIZE	29	2026-06-19 06:20:48	2026-06-19 06:20:48
\.


--
-- Data for Name: product_views; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_views (id, product_id, ip_address, user_id, created_at, updated_at) FROM stdin;
61	9	127.0.0.1	\N	2026-06-08 11:27:55	2026-06-08 11:27:55
62	9	127.0.0.1	\N	2026-06-08 11:32:01	2026-06-08 11:32:01
63	9	127.0.0.1	\N	2026-06-08 11:32:46	2026-06-08 11:32:46
64	9	127.0.0.1	\N	2026-06-08 11:34:07	2026-06-08 11:34:07
65	9	127.0.0.1	\N	2026-06-08 11:35:18	2026-06-08 11:35:18
66	9	127.0.0.1	\N	2026-06-08 11:36:31	2026-06-08 11:36:31
67	9	127.0.0.1	\N	2026-06-08 11:36:49	2026-06-08 11:36:49
68	9	127.0.0.1	\N	2026-06-08 11:37:37	2026-06-08 11:37:37
69	9	127.0.0.1	\N	2026-06-08 11:43:50	2026-06-08 11:43:50
70	9	127.0.0.1	\N	2026-06-08 11:44:58	2026-06-08 11:44:58
71	9	127.0.0.1	\N	2026-06-08 11:45:52	2026-06-08 11:45:52
72	9	127.0.0.1	\N	2026-06-08 11:50:50	2026-06-08 11:50:50
73	10	127.0.0.1	\N	2026-06-08 11:51:09	2026-06-08 11:51:09
74	10	127.0.0.1	\N	2026-06-08 11:52:34	2026-06-08 11:52:34
75	10	127.0.0.1	\N	2026-06-08 11:53:02	2026-06-08 11:53:02
76	9	127.0.0.1	\N	2026-06-08 11:53:11	2026-06-08 11:53:11
77	10	127.0.0.1	\N	2026-06-08 11:53:19	2026-06-08 11:53:19
78	10	127.0.0.1	\N	2026-06-08 12:08:16	2026-06-08 12:08:16
79	10	127.0.0.1	\N	2026-06-08 12:15:14	2026-06-08 12:15:14
80	11	127.0.0.1	\N	2026-06-08 12:38:16	2026-06-08 12:38:16
81	11	127.0.0.1	\N	2026-06-08 12:43:52	2026-06-08 12:43:52
82	10	127.0.0.1	\N	2026-06-08 12:44:22	2026-06-08 12:44:22
83	10	127.0.0.1	\N	2026-06-08 13:19:46	2026-06-08 13:19:46
84	11	127.0.0.1	\N	2026-06-08 13:19:49	2026-06-08 13:19:49
85	11	127.0.0.1	\N	2026-06-08 13:22:25	2026-06-08 13:22:25
86	11	127.0.0.1	\N	2026-06-08 13:23:11	2026-06-08 13:23:11
87	11	127.0.0.1	\N	2026-06-08 13:25:24	2026-06-08 13:25:24
88	11	127.0.0.1	\N	2026-06-08 13:25:50	2026-06-08 13:25:50
89	10	127.0.0.1	\N	2026-06-08 13:25:57	2026-06-08 13:25:57
90	10	127.0.0.1	\N	2026-06-08 13:28:10	2026-06-08 13:28:10
91	11	127.0.0.1	\N	2026-06-08 13:29:06	2026-06-08 13:29:06
92	10	127.0.0.1	\N	2026-06-08 13:30:11	2026-06-08 13:30:11
93	11	127.0.0.1	\N	2026-06-08 13:30:30	2026-06-08 13:30:30
94	10	127.0.0.1	\N	2026-06-08 13:31:10	2026-06-08 13:31:10
95	11	127.0.0.1	\N	2026-06-08 13:48:25	2026-06-08 13:48:25
96	11	127.0.0.1	\N	2026-06-08 13:48:41	2026-06-08 13:48:41
97	11	127.0.0.1	\N	2026-06-08 13:48:44	2026-06-08 13:48:44
98	10	127.0.0.1	\N	2026-06-08 13:49:17	2026-06-08 13:49:17
99	9	127.0.0.1	\N	2026-06-08 13:49:27	2026-06-08 13:49:27
100	11	127.0.0.1	\N	2026-06-09 03:30:35	2026-06-09 03:30:35
101	11	127.0.0.1	\N	2026-06-09 03:32:10	2026-06-09 03:32:10
102	11	127.0.0.1	\N	2026-06-09 03:34:23	2026-06-09 03:34:23
103	11	127.0.0.1	\N	2026-06-09 03:36:27	2026-06-09 03:36:27
104	11	127.0.0.1	\N	2026-06-09 03:36:44	2026-06-09 03:36:44
105	11	127.0.0.1	\N	2026-06-09 03:37:26	2026-06-09 03:37:26
106	11	127.0.0.1	\N	2026-06-09 03:37:28	2026-06-09 03:37:28
107	11	127.0.0.1	\N	2026-06-09 03:39:21	2026-06-09 03:39:21
108	11	127.0.0.1	\N	2026-06-09 03:39:28	2026-06-09 03:39:28
109	11	127.0.0.1	\N	2026-06-09 03:42:18	2026-06-09 03:42:18
110	11	127.0.0.1	\N	2026-06-09 03:43:45	2026-06-09 03:43:45
111	10	127.0.0.1	\N	2026-06-09 03:43:50	2026-06-09 03:43:50
113	9	127.0.0.1	\N	2026-06-09 03:44:48	2026-06-09 03:44:48
114	9	127.0.0.1	\N	2026-06-09 03:46:44	2026-06-09 03:46:44
115	9	127.0.0.1	\N	2026-06-09 03:46:46	2026-06-09 03:46:46
116	9	127.0.0.1	\N	2026-06-09 03:46:49	2026-06-09 03:46:49
117	9	127.0.0.1	\N	2026-06-09 03:46:50	2026-06-09 03:46:50
118	9	127.0.0.1	\N	2026-06-09 03:48:42	2026-06-09 03:48:42
119	9	127.0.0.1	\N	2026-06-09 03:48:54	2026-06-09 03:48:54
120	9	127.0.0.1	\N	2026-06-09 03:48:55	2026-06-09 03:48:55
121	9	127.0.0.1	\N	2026-06-09 03:51:06	2026-06-09 03:51:06
122	11	127.0.0.1	1	2026-06-09 03:55:32	2026-06-09 03:55:32
123	11	127.0.0.1	1	2026-06-09 04:13:49	2026-06-09 04:13:49
124	11	127.0.0.1	\N	2026-06-09 04:15:55	2026-06-09 04:15:55
125	11	127.0.0.1	\N	2026-06-09 05:26:11	2026-06-09 05:26:11
126	11	127.0.0.1	\N	2026-06-09 06:08:04	2026-06-09 06:08:04
127	11	127.0.0.1	\N	2026-06-09 06:17:13	2026-06-09 06:17:13
128	16	127.0.0.1	\N	2026-06-09 10:11:28	2026-06-09 10:11:28
129	17	127.0.0.1	\N	2026-06-09 10:28:01	2026-06-09 10:28:01
130	19	127.0.0.1	\N	2026-06-09 10:36:55	2026-06-09 10:36:55
131	19	127.0.0.1	\N	2026-06-09 10:47:25	2026-06-09 10:47:25
132	19	127.0.0.1	\N	2026-06-09 10:48:20	2026-06-09 10:48:20
133	19	127.0.0.1	\N	2026-06-10 07:49:55	2026-06-10 07:49:55
134	14	127.0.0.1	1	2026-06-10 09:56:07	2026-06-10 09:56:07
135	17	127.0.0.1	1	2026-06-10 09:56:17	2026-06-10 09:56:17
136	17	127.0.0.1	1	2026-06-10 09:56:54	2026-06-10 09:56:54
137	17	127.0.0.1	1	2026-06-10 09:57:02	2026-06-10 09:57:02
138	17	127.0.0.1	1	2026-06-11 01:58:10	2026-06-11 01:58:10
139	17	127.0.0.1	1	2026-06-11 01:58:21	2026-06-11 01:58:21
140	17	127.0.0.1	1	2026-06-11 02:36:15	2026-06-11 02:36:15
141	17	127.0.0.1	1	2026-06-11 02:36:59	2026-06-11 02:36:59
142	17	127.0.0.1	1	2026-06-11 02:37:30	2026-06-11 02:37:30
143	17	127.0.0.1	1	2026-06-11 02:37:46	2026-06-11 02:37:46
144	17	127.0.0.1	1	2026-06-11 02:38:37	2026-06-11 02:38:37
145	17	127.0.0.1	1	2026-06-11 02:38:47	2026-06-11 02:38:47
146	17	127.0.0.1	1	2026-06-11 02:39:55	2026-06-11 02:39:55
147	17	127.0.0.1	1	2026-06-11 02:40:57	2026-06-11 02:40:57
148	17	127.0.0.1	1	2026-06-11 02:41:05	2026-06-11 02:41:05
149	17	127.0.0.1	1	2026-06-11 02:43:12	2026-06-11 02:43:12
150	17	127.0.0.1	1	2026-06-11 02:44:32	2026-06-11 02:44:32
151	17	127.0.0.1	1	2026-06-11 02:45:53	2026-06-11 02:45:53
152	17	127.0.0.1	1	2026-06-11 02:47:25	2026-06-11 02:47:25
153	17	127.0.0.1	1	2026-06-11 02:48:38	2026-06-11 02:48:38
154	17	127.0.0.1	1	2026-06-11 02:48:38	2026-06-11 02:48:38
155	17	127.0.0.1	1	2026-06-11 02:51:58	2026-06-11 02:51:58
156	17	127.0.0.1	1	2026-06-11 02:52:20	2026-06-11 02:52:20
157	17	127.0.0.1	1	2026-06-11 02:55:03	2026-06-11 02:55:03
158	17	127.0.0.1	1	2026-06-11 02:55:08	2026-06-11 02:55:08
159	17	127.0.0.1	1	2026-06-11 02:55:16	2026-06-11 02:55:16
160	17	127.0.0.1	1	2026-06-11 02:55:45	2026-06-11 02:55:45
161	17	127.0.0.1	1	2026-06-11 02:55:49	2026-06-11 02:55:49
162	17	127.0.0.1	1	2026-06-11 02:57:43	2026-06-11 02:57:43
163	17	127.0.0.1	1	2026-06-11 02:59:01	2026-06-11 02:59:01
164	17	127.0.0.1	1	2026-06-11 02:59:09	2026-06-11 02:59:09
165	17	127.0.0.1	1	2026-06-11 02:59:12	2026-06-11 02:59:12
166	17	127.0.0.1	1	2026-06-11 04:09:05	2026-06-11 04:09:05
167	15	127.0.0.1	1	2026-06-11 04:09:23	2026-06-11 04:09:23
168	15	127.0.0.1	1	2026-06-11 04:09:25	2026-06-11 04:09:25
169	19	127.0.0.1	\N	2026-06-11 11:33:36	2026-06-11 11:33:36
170	18	127.0.0.1	\N	2026-06-11 11:34:59	2026-06-11 11:34:59
171	17	127.0.0.1	3	2026-06-13 03:01:18	2026-06-13 03:01:18
172	13	127.0.0.1	3	2026-06-13 03:04:31	2026-06-13 03:04:31
173	19	127.0.0.1	3	2026-06-13 03:06:02	2026-06-13 03:06:02
174	20	127.0.0.1	3	2026-06-13 03:11:47	2026-06-13 03:11:47
175	20	127.0.0.1	3	2026-06-13 03:11:54	2026-06-13 03:11:54
176	20	127.0.0.1	3	2026-06-13 03:12:12	2026-06-13 03:12:12
177	16	127.0.0.1	3	2026-06-13 03:12:56	2026-06-13 03:12:56
178	20	127.0.0.1	3	2026-06-13 03:15:38	2026-06-13 03:15:38
179	20	127.0.0.1	3	2026-06-13 03:15:40	2026-06-13 03:15:40
180	20	127.0.0.1	3	2026-06-13 03:18:03	2026-06-13 03:18:03
181	20	127.0.0.1	3	2026-06-13 03:20:46	2026-06-13 03:20:46
182	15	127.0.0.1	3	2026-06-13 03:21:35	2026-06-13 03:21:35
183	20	127.0.0.1	3	2026-06-13 03:23:13	2026-06-13 03:23:13
184	19	127.0.0.1	3	2026-06-13 03:23:45	2026-06-13 03:23:45
185	20	127.0.0.1	3	2026-06-13 03:24:16	2026-06-13 03:24:16
186	19	127.0.0.1	3	2026-06-13 03:24:35	2026-06-13 03:24:35
187	18	127.0.0.1	3	2026-06-13 03:24:40	2026-06-13 03:24:40
188	14	127.0.0.1	3	2026-06-13 03:24:45	2026-06-13 03:24:45
189	14	127.0.0.1	3	2026-06-13 03:25:16	2026-06-13 03:25:16
190	20	127.0.0.1	3	2026-06-13 03:25:44	2026-06-13 03:25:44
191	20	127.0.0.1	3	2026-06-13 03:25:46	2026-06-13 03:25:46
192	19	127.0.0.1	3	2026-06-13 03:28:44	2026-06-13 03:28:44
193	19	127.0.0.1	3	2026-06-13 03:28:46	2026-06-13 03:28:46
194	20	127.0.0.1	3	2026-06-13 03:36:30	2026-06-13 03:36:30
195	20	127.0.0.1	3	2026-06-13 03:38:34	2026-06-13 03:38:34
196	20	127.0.0.1	3	2026-06-13 03:38:45	2026-06-13 03:38:45
197	20	127.0.0.1	3	2026-06-13 03:39:16	2026-06-13 03:39:16
198	20	127.0.0.1	3	2026-06-13 03:44:28	2026-06-13 03:44:28
199	20	127.0.0.1	3	2026-06-13 03:45:07	2026-06-13 03:45:07
200	19	127.0.0.1	3	2026-06-13 03:47:57	2026-06-13 03:47:57
201	19	127.0.0.1	3	2026-06-13 03:47:59	2026-06-13 03:47:59
202	19	127.0.0.1	3	2026-06-13 03:51:45	2026-06-13 03:51:45
203	20	127.0.0.1	3	2026-06-13 03:54:26	2026-06-13 03:54:26
204	20	127.0.0.1	\N	2026-06-14 04:02:16	2026-06-14 04:02:16
205	20	127.0.0.1	\N	2026-06-14 04:05:39	2026-06-14 04:05:39
206	20	127.0.0.1	\N	2026-06-14 04:05:50	2026-06-14 04:05:50
207	20	127.0.0.1	\N	2026-06-14 04:05:51	2026-06-14 04:05:51
208	20	127.0.0.1	\N	2026-06-14 04:05:59	2026-06-14 04:05:59
209	19	127.0.0.1	\N	2026-06-14 04:06:04	2026-06-14 04:06:04
210	14	127.0.0.1	\N	2026-06-14 04:28:58	2026-06-14 04:28:58
211	20	127.0.0.1	\N	2026-06-14 04:32:37	2026-06-14 04:32:37
212	19	127.0.0.1	\N	2026-06-14 04:53:37	2026-06-14 04:53:37
213	17	127.0.0.1	\N	2026-06-14 04:53:57	2026-06-14 04:53:57
214	20	127.0.0.1	\N	2026-06-14 05:02:24	2026-06-14 05:02:24
215	20	127.0.0.1	\N	2026-06-14 05:02:29	2026-06-14 05:02:29
216	20	127.0.0.1	\N	2026-06-14 05:02:38	2026-06-14 05:02:38
217	20	127.0.0.1	\N	2026-06-14 05:02:40	2026-06-14 05:02:40
218	20	127.0.0.1	\N	2026-06-14 05:02:43	2026-06-14 05:02:43
219	20	127.0.0.1	\N	2026-06-14 05:05:32	2026-06-14 05:05:32
220	20	127.0.0.1	\N	2026-06-14 05:05:54	2026-06-14 05:05:54
221	20	127.0.0.1	\N	2026-06-14 05:06:42	2026-06-14 05:06:42
222	20	127.0.0.1	1	2026-06-14 05:07:45	2026-06-14 05:07:45
223	20	127.0.0.1	1	2026-06-14 05:09:08	2026-06-14 05:09:08
224	20	127.0.0.1	1	2026-06-14 05:09:11	2026-06-14 05:09:11
225	20	127.0.0.1	1	2026-06-14 05:09:25	2026-06-14 05:09:25
226	20	127.0.0.1	1	2026-06-14 05:49:27	2026-06-14 05:49:27
227	20	127.0.0.1	1	2026-06-14 05:49:30	2026-06-14 05:49:30
228	20	127.0.0.1	\N	2026-06-15 05:35:32	2026-06-15 05:35:32
229	18	127.0.0.1	\N	2026-06-15 05:35:39	2026-06-15 05:35:39
230	20	127.0.0.1	\N	2026-06-15 05:36:34	2026-06-15 05:36:34
231	19	127.0.0.1	1	2026-06-15 05:37:07	2026-06-15 05:37:07
232	19	127.0.0.1	1	2026-06-15 05:37:09	2026-06-15 05:37:09
233	19	127.0.0.1	\N	2026-06-15 05:38:26	2026-06-15 05:38:26
234	19	127.0.0.1	\N	2026-06-15 05:39:48	2026-06-15 05:39:48
235	17	127.0.0.1	\N	2026-06-15 05:39:56	2026-06-15 05:39:56
236	9	127.0.0.1	\N	2026-06-15 05:40:15	2026-06-15 05:40:15
237	19	127.0.0.1	\N	2026-06-15 05:52:20	2026-06-15 05:52:20
238	19	127.0.0.1	1	2026-06-15 06:57:11	2026-06-15 06:57:11
239	19	127.0.0.1	1	2026-06-15 06:57:14	2026-06-15 06:57:14
240	19	127.0.0.1	1	2026-06-15 07:16:01	2026-06-15 07:16:01
241	19	127.0.0.1	1	2026-06-15 07:16:07	2026-06-15 07:16:07
242	19	127.0.0.1	1	2026-06-15 07:16:20	2026-06-15 07:16:20
243	19	127.0.0.1	1	2026-06-15 07:16:23	2026-06-15 07:16:23
244	19	127.0.0.1	\N	2026-06-15 08:01:02	2026-06-15 08:01:02
245	19	127.0.0.1	\N	2026-06-15 08:05:36	2026-06-15 08:05:36
246	21	127.0.0.1	\N	2026-06-15 08:05:45	2026-06-15 08:05:45
247	21	127.0.0.1	\N	2026-06-15 08:06:42	2026-06-15 08:06:42
248	21	127.0.0.1	\N	2026-06-15 10:33:17	2026-06-15 10:33:17
249	19	127.0.0.1	\N	2026-06-15 10:38:27	2026-06-15 10:38:27
252	20	127.0.0.1	1	2026-06-15 10:52:16	2026-06-15 10:52:16
258	15	127.0.0.1	1	2026-06-15 12:22:56	2026-06-15 12:22:56
265	19	127.0.0.1	1	2026-06-16 10:48:56	2026-06-16 10:48:56
266	21	127.0.0.1	1	2026-06-16 11:21:42	2026-06-16 11:21:42
267	21	127.0.0.1	1	2026-06-16 11:21:46	2026-06-16 11:21:46
268	21	127.0.0.1	1	2026-06-16 11:24:00	2026-06-16 11:24:00
269	21	127.0.0.1	1	2026-06-16 11:24:02	2026-06-16 11:24:02
270	21	127.0.0.1	1	2026-06-16 11:24:23	2026-06-16 11:24:23
271	21	127.0.0.1	1	2026-06-16 11:25:02	2026-06-16 11:25:02
272	21	127.0.0.1	\N	2026-06-18 03:35:01	2026-06-18 03:35:01
273	19	127.0.0.1	1	2026-06-18 15:31:51	2026-06-18 15:31:51
274	19	127.0.0.1	1	2026-06-18 15:31:56	2026-06-18 15:31:56
275	18	127.0.0.1	1	2026-06-19 03:55:40	2026-06-19 03:55:40
276	19	127.0.0.1	1	2026-06-19 03:55:45	2026-06-19 03:55:45
277	19	127.0.0.1	1	2026-06-19 03:55:49	2026-06-19 03:55:49
278	17	127.0.0.1	1	2026-06-19 06:06:39	2026-06-19 06:06:39
279	17	127.0.0.1	1	2026-06-19 06:06:43	2026-06-19 06:06:43
280	18	127.0.0.1	1	2026-06-19 06:26:09	2026-06-19 06:26:09
281	18	127.0.0.1	1	2026-06-19 06:26:14	2026-06-19 06:26:14
282	17	127.0.0.1	1	2026-06-19 09:16:11	2026-06-19 09:16:11
283	17	127.0.0.1	1	2026-06-19 09:16:15	2026-06-19 09:16:15
284	21	127.0.0.1	1	2026-06-19 09:25:32	2026-06-19 09:25:32
285	21	127.0.0.1	1	2026-06-19 09:25:34	2026-06-19 09:25:34
286	21	127.0.0.1	1	2026-06-19 09:25:38	2026-06-19 09:25:38
287	19	127.0.0.1	1	2026-06-19 09:50:18	2026-06-19 09:50:18
288	19	127.0.0.1	1	2026-06-19 09:50:23	2026-06-19 09:50:23
289	19	127.0.0.1	1	2026-06-19 12:26:19	2026-06-19 12:26:19
290	19	127.0.0.1	1	2026-06-19 12:26:25	2026-06-19 12:26:25
291	21	127.0.0.1	\N	2026-06-21 06:54:13	2026-06-21 06:54:13
292	21	127.0.0.1	1	2026-06-21 07:18:59	2026-06-21 07:18:59
293	21	127.0.0.1	1	2026-06-21 07:19:12	2026-06-21 07:19:12
294	19	127.0.0.1	1	2026-06-21 13:16:16	2026-06-21 13:16:16
295	19	127.0.0.1	1	2026-06-21 13:16:19	2026-06-21 13:16:19
296	21	127.0.0.1	1	2026-06-21 13:33:11	2026-06-21 13:33:11
297	21	127.0.0.1	1	2026-06-21 13:33:14	2026-06-21 13:33:14
298	19	127.0.0.1	1	2026-06-21 13:56:55	2026-06-21 13:56:55
299	19	127.0.0.1	1	2026-06-21 13:57:00	2026-06-21 13:57:00
300	21	127.0.0.1	1	2026-06-21 14:09:56	2026-06-21 14:09:56
301	17	127.0.0.1	1	2026-06-21 14:10:20	2026-06-21 14:10:20
302	17	127.0.0.1	1	2026-06-21 14:10:23	2026-06-21 14:10:23
303	17	127.0.0.1	1	2026-06-21 14:11:58	2026-06-21 14:11:58
304	17	127.0.0.1	1	2026-06-21 14:12:01	2026-06-21 14:12:01
305	17	127.0.0.1	1	2026-06-21 14:12:31	2026-06-21 14:12:31
306	17	127.0.0.1	1	2026-06-21 14:12:36	2026-06-21 14:12:36
307	21	127.0.0.1	1	2026-06-21 15:11:46	2026-06-21 15:11:46
308	19	127.0.0.1	1	2026-06-21 15:11:56	2026-06-21 15:11:56
309	19	127.0.0.1	1	2026-06-21 15:11:58	2026-06-21 15:11:58
310	19	127.0.0.1	1	2026-06-21 15:12:37	2026-06-21 15:12:37
311	19	127.0.0.1	1	2026-06-21 15:12:43	2026-06-21 15:12:43
312	21	127.0.0.1	1	2026-06-23 04:42:25	2026-06-23 04:42:25
313	19	127.0.0.1	1	2026-06-23 05:54:58	2026-06-23 05:54:58
314	19	127.0.0.1	1	2026-06-23 05:55:01	2026-06-23 05:55:01
315	14	127.0.0.1	\N	2026-06-23 09:16:06	2026-06-23 09:16:06
316	14	127.0.0.1	1	2026-06-23 09:16:34	2026-06-23 09:16:34
317	14	127.0.0.1	1	2026-06-23 09:16:38	2026-06-23 09:16:38
318	14	127.0.0.1	1	2026-06-23 09:16:42	2026-06-23 09:16:42
319	18	127.0.0.1	1	2026-06-23 12:48:47	2026-06-23 12:48:47
320	18	127.0.0.1	1	2026-06-23 12:48:50	2026-06-23 12:48:50
321	19	127.0.0.1	5	2026-06-24 07:34:42	2026-06-24 07:34:42
322	21	127.0.0.1	\N	2026-06-24 09:18:00	2026-06-24 09:18:00
323	19	127.0.0.1	\N	2026-06-24 09:31:27	2026-06-24 09:31:27
324	21	127.0.0.1	7	2026-06-24 09:38:59	2026-06-24 09:38:59
325	18	127.0.0.1	\N	2026-06-24 09:47:07	2026-06-24 09:47:07
326	19	127.0.0.1	7	2026-06-25 16:30:38	2026-06-25 16:30:38
327	19	127.0.0.1	7	2026-06-25 16:30:47	2026-06-25 16:30:47
328	19	127.0.0.1	7	2026-06-25 16:31:47	2026-06-25 16:31:47
329	19	127.0.0.1	7	2026-06-25 16:31:55	2026-06-25 16:31:55
330	19	127.0.0.1	5	2026-06-25 16:33:54	2026-06-25 16:33:54
331	19	127.0.0.1	5	2026-06-25 16:34:02	2026-06-25 16:34:02
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, category_id, name, slug, description, price, stock, weight, images, is_active, created_at, updated_at, thumbnail_index, video, length, width, height, name_en, description_en, price_usd, price_myr) FROM stdin;
19	2	BASARI.ID - Atasan Blouse Cream,Coklat muda- Bahan Crinkle (2202) - Kanaya Blouse	basariid-atasan-blouse-creamcoklat-muda-bahan-crinkle-2202-kanaya-blouse-JmvF	*Bahan Crinkle Airflow*\r\n\r\nuntuk bagian lehernya engga lahak yaa masi ketutup🥰\r\n\r\npanjang baju : 60 cm\r\nld : 115 cm\r\npanjang lengan : 55 cm\r\n\r\nuntuk barang yang sudah di beli tidak dapat dikembalikan karna masalah ukuran, karena terkait ukuran sudah di jelaskan di deskripsi, persyaratan refund apabila ada barang yang reject wajib di sertai video unboxing❤️	104000.00	23	500	["products/86w0kFk9afwKE0qq2XjcD3hls4xPXp85MNc2ayLO.webp", "products/cnoOw9ri1aocD4yxL1jNNIwcrfpCYYh0z6GLFytH.webp", "products/n8oAxqg7IddOdzjvJR7jZWf8kaUdfMynJLj1rgln.webp", "products/dMacOuYOlnaJPb27HadzWZNqwgdsVkm4meko9cDr.webp", "products/UAbdSjD5AEiPUJEFAk1yA9Kh50FJx2VlgwM2GBIu.webp"]	t	2026-06-09 10:26:55	2026-06-26 00:35:22	4	\N	30	25	5	\N	\N	6.00	29.00
17	2	Basari.Id - Kelly Blouse - Atasan Wanita bahan Polo Linen - Blouse Putih - Blouse Lengan Karet	basariid-kelly-blouse-atasan-wanita-bahan-polo-linen-blouse-putih-blouse-lengan-karet-HvH0	Kelly Blouse\r\n\r\nBahan : Polo Linen\r\n\r\nLingkar Dada : 110 cm\r\nPanjang Baju : 65 cm\r\nPanjang Lengan : 57 cm\r\nLingkar ketiak :  52 cm\r\n\r\nAvailable in 3 Colors\r\n- Hitam\r\n- Putih ( menerawang dan TIPIS lebih baik pake inner lagi yaa temen temen!)\r\n- Mocca\r\nWarna Putih(menerawang)	129000.00	28	300	["products/B7wUXq3CVt4ZJv3RWnOAk8GfPN9jX7qk7l1xEpR9.webp", "products/n3wbBJ8cqdH9gpKT8JFlPxfZqIJ4c4dNr22QiuwM.webp", "products/QaaX6bL7127j0sEKv2jEzlGbL0SYjgICKexHtmdj.webp", "products/TVQWv0xoXGcdTKqchtBQXgtqp6shPQMrYmN5LrWr.webp", "products/fjd1NCGSfXrp96pNTytsDeRYq0NAxv04TFGQvUgV.webp", "products/uW2qMaUH7VTZvcRidb440lYRgkwq1rMXd9XWKmRS.webp"]	t	2026-06-09 10:17:32	2026-06-21 14:13:03	3	\N	30	25	5	\N	\N	5.30	29.90
15	7	Basari.id - Hara Tunik - Bahan Tencel Bordir - Baju Formal - Baju Undangan - Raya Tunik	basariid-hara-tunik-bahan-tencel-bordir-baju-formal-baju-undangan-raya-tunik-qyCN	Hara Tunik \r\n\r\n\r\n\r\n*Tunik Only / Luaran Only (tanpa inner)*\r\n*Menerwang wajib pakai inner lagi*\r\n\r\n\r\n\r\n\r\n\r\n                               - BAHAN -\r\n\r\n                             Tencel Bordir \r\n\r\n(bahannya ringan,tipis, menerawang dan nyaman untuk dipakai)\r\n\r\n\r\n- SIZE CHART - \r\nLingkar Dada = 114 cm\r\nPanjang Baju = 89 cm\r\nPanjang Lengan = 54 cm	198000.00	9	300	["products/iagKbPbr7QHSKYqWTeZSIDbmb9U2H45RFjxxLqOq.webp", "products/nu2t6EJew3BBfTSuwXqvjo1p4G1b2n7eocXusPtX.webp", "products/oXttunKdb3rFniwv9FFLi1AEjYjK4lztuR2gnHMj.webp", "products/YT4K9rC70gQMKNMlRxhBNHxhnNGMvnoXdpGzDby8.webp", "products/MRx3Gr4VKOP4SOdDWznLm7zfEJBit8Z4uKi8OfZX.webp", "products/OwCEXroDSsrI5I9kCSr3C8iMjLzC0AZ0xQp48R6E.webp", "products/bxiOLAycYrL2MwLjkuqX8G6tBnzGTvi8xHfDCjeU.webp"]	t	2026-06-09 09:59:26	2026-06-11 04:10:13	6	\N	30	25	5	\N	\N	\N	\N
10	2	BASARI.ID - Milly - Atasan wanita (blouse) warna hitam,warna pink - atasan hitam - lady crush- atasan wanita lengan panjang	basariid-milly-atasan-wanita-blouse-warna-hitamwarna-pink-atasan-hitam-lady-crush-atasan-wanita-lengan-panjang-wgUc	Milly\r\n\r\n\r\n\r\nAvailable 4 Colors :\r\n\r\n- Black\r\n\r\n- Silver Pink\r\n\r\n\r\n\r\nLingkar dada = 100cm\r\n\r\nPanjang baju = 58cm\r\n\r\n\r\n\r\nBahan : Premium Lady Crush\r\n\r\n\r\n\r\nterdapat sleting di bagian belakang\r\n\r\n\r\n\r\n\r\n\r\nbarang yang sudah di beli tidak dapat dikembalikan karna masalah ukuran, karena terkait ukuran sudah di jelaskan di deskripsi, persyaratan refund apabila ada barang yang reject wajib di sertai video unboxing❤️	82000.00	40	500	["products/QzHM1h4mw07iTvVd38ggIR7zkHVfAszzlbREI4ly.webp", "products/Jcx7mUc7HcGa6jhi5r91fi0dMeoP2Gt9fBDJ56t4.webp", "products/FCvKyhrJXsrUsxo5cVD6o09VG662kOiuvawW50jw.webp", "products/e8bUWrkPZCV3kc5qVzH383DyJ12sPRBzqrPbj6Qk.webp", "products/3d0PGuS5CaFaOHC9UwhjoYhNJoXL6dWIMhkphqjd.webp"]	t	2026-06-08 11:50:47	2026-06-08 12:08:11	4	\N	30	25	5	\N	\N	\N	\N
18	2	BASARI.ID (2212) - LUMI BLOUSE - Blouse Tali Belakang - Atasan Tali Belakang - Bahan Polo Linen	basariid-2212-lumi-blouse-blouse-tali-belakang-atasan-tali-belakang-bahan-polo-linen-qu5S	Lumi Blouse\r\n\r\nLingkar dada = 110 cm\r\nPanjang baju = 65 cm\r\nPanjang lengan = 54 cm\r\nLingkar Ketiak = 50 cm\r\n\r\n\r\nBahan = Polo Linen\r\n\r\n⚫️ terdapat sleting di bagian belakang\r\n\r\n⚫️ karet bagian pergelangan tangan\r\n\r\nbarang yang sudah di beli tidak dapat dikembalikan karna masalah ukuran, karena terkait ukuran sudah di jelaskan di deskripsi, persyaratan refund apabila ada barang yang reject wajib di sertai video unboxing❤️	97000.00	30	300	["products/RPyuwqe4R3edOfuqt4PBnMJXzeukw2QwVGYKylFA.webp", "products/3BxbbfOxHDK9kbmf7MHy3hYEiRzrhSJ385crLzT1.webp", "products/HkIAcIJLTF4iKftGV3URBOMdh3I0WCjGKkzypEGC.webp", "products/e6Gjd8KuIyxRYRYF3RVgGcy7NgvB4Ytc3dsaelTI.webp"]	t	2026-06-09 10:20:18	2026-06-19 06:20:11	3	\N	30	25	5	\N	\N	6.50	29.90
9	2	Milly Blouse - Blouse Broken White - Blouse navy - Blouse pink - Bahan texture - Bahan Lady Crush	milly-blouse-blouse-broken-white-blouse-navy-blouse-pink-bahan-texture-bahan-lady-crush-p0Tt	Warna Broken White (menerawang)\r\n\r\n\r\n\r\nPERBERAAN STRECTH DAN NON STRETCH\r\n\r\n\r\n\r\n• STRETCH warnanya lebih gelap(pekat) di bandingkan dengan yang NON STRETCH\r\n\r\n• cuttingan, pola, dan model stretch dan non stretch sama\r\n\r\n\r\n\r\n\r\n\r\nuntuk barang yang sudah di beli tidak dapat dikembalikan karna masalah ukuran, karena terkait ukuran sudah di jelaskan di deskripsi, persyaratan refund apabila ada barang yang reject wajib di sertai video unboxing❤️\r\n\r\n\r\n\r\nMilly Blouse\r\n\r\n\r\n\r\nBahan : Lady Crush Premium \r\n\r\nbahannya ringan,tipis dan nyaman untuk dipakai ❤️\r\n\r\n\r\n\r\nlingkar dada : 100cm\r\n\r\npanjang baju : 58cm\r\n\r\nlebar bahu : 36cm\r\n\r\nlebar ketiak : 21cm\r\n\r\nlingkar lengan : 42cm\r\n\r\npanjang lengan : 58cm\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nAvailable in 4 Colors\r\n\r\n- Pink\r\n\r\n- Navy\r\n\r\n- Black\r\n\r\n- Broken white ( aga nerawang dan lebih baik pake inner lagi yaa temen temen!)	82000.00	60	500	["products/pWec2HimChiqKwUgH7KgYDwmhDNWG0ImDCqmYpqo.png", "products/Dk1qqGGbiJwn8lfcjeWcyFvXussW09wDkcobPicc.png", "products/GM9XmpVLAv3iVahlZqkWCzREImklVwKxzFD4po2z.png", "products/fR8c0MWmIlj9pisPQK85kHE847caGyNU4p07cuTc.png"]	t	2026-06-08 11:27:41	2026-06-08 12:15:45	3	\N	30	25	5	\N	\N	\N	\N
11	1	BASARI.ID - COTTON CARDIGAN -Cardigan polos - Cardigan Wanita - Cardigan Katun - Cardigan murah	basariid-cotton-cardigan-cardigan-polos-cardigan-wanita-cardigan-katun-cardigan-murah-RIpR	lingkar dada 100\r\n\r\npanjang baju 60\r\n\r\npanjang tangan 56\r\n\r\nlingkar ketiak 46cm\r\n\r\nlingkar lengan 27 cm\r\n\r\n\r\n\r\nbahan : katun baby terry\r\n\r\n\r\n\r\nAvailable in 6 colors\r\n\r\n- Putih (Broken white)\r\n\r\n- Black\r\n\r\n- Misty Grey\r\n\r\n- Maroon\r\n\r\n- Steel Blue\r\n\r\n- Cream\r\n\r\n\r\n\r\nuntuk barang yang sudah di beli tidak dapat dikembalikan karna masalah ukuran, karena terkait ukuran sudah di jelaskan di deskripsi, persyaratan refund apabila ada barang yang reject wajib di sertai video unboxing	119000.00	100	250	["products/Y5gzv9p4MGPMgLktCGr1Yg2YUgCxUb1wYKkn7KMz.webp", "products/SPRkdZbQg4Zrsii3YvDkOpbjaPCn3Smbg1NWrda9.webp", "products/NEkNT2HT72BqYMsCPaSnDizjxoDz8DgAKHiGp4pB.webp", "products/AEHsARzBTVELosMSfZnrtpgmsohwIsug8RXf8cNS.webp", "products/QEQZYfHQ3zUqj7HN7GuIFC20yvvGqTPvxGttlzk8.webp", "products/zf9cnmNnM5jNDVPD6ksWt1evKwBIKbrwyqwzfzbG.webp", "products/qf0WCaDYWkNplireONfPCDz3T9XZeGZoztVRniUl.webp", "products/euykB3ca4YmK64yez8prtB9F7Fb1qOjS9i2EuBRh.webp", "products/VjxF0oE8PfyxVIjwClTmH41i6X0UqNYYsO8jAhZk.webp"]	t	2026-06-08 12:38:06	2026-06-08 12:39:12	8	\N	30	25	5	\N	\N	\N	\N
12	6	Cardigan Katun - Cardigan Bahan Katun - Outer Wanita	cardigan-katun-cardigan-bahan-katun-outer-wanita-36hm	lingkar dada 100\r\npanjang baju 60\r\npanjang tangan 56\r\n\r\n\r\nbahan : katun baby terry\r\n\r\n\r\nAvailable in 8 colors (warna lain di etalase terpisah)\r\n- Putih \r\n- Black\r\n- Misty Grey\r\n- Maroon\r\n- Steel Blue\r\n- Navy\r\n- Light Brown\r\n- Toffee\r\n\r\n\r\nuntuk barang yang sudah di beli tidak dapat dikembalikan karna masalah ukuran, karena terkait ukuran sudah di jelaskan di deskripsi, persyaratan refund apabila ada barang yang reject wajib di sertai video unboxing❤️	113000.00	30	300	["products/cLTOpgP6LyjicGok6pJR4AnXdgbDdYMyCA87Skse.webp", "products/9B1gai0T24aZFGrOOlypZlt9qfSa6HJGBy0PKpFe.webp", "products/n9H7tt5jPefqDH9Ax1rIYMnQC55vEY8uHs7aXJKK.webp", "products/csyBRhHRDzEMtKDg0SSOsQnaqqmnl3atmSJX6tfg.webp", "products/IazjHQXaF6lpy45egHnDA2onP8AIuRUUvRM0l7j3.webp", "products/dRPNgYq96yGHw3d2HX1YdsTlC6WD3c3aEd0LUkKJ.webp"]	t	2026-06-09 09:37:08	2026-06-09 09:37:08	0	\N	30	25	5	\N	\N	\N	\N
13	3	Basari.id - Sweat Pants Baan Katun - Celana Olahraga - Celana Santai - Bahan Katun	basariid-sweat-pants-baan-katun-celana-olahraga-celana-santai-bahan-katun-N0ba	Bahan : Katun\r\n\r\n\r\n- Ukuran -\r\nLingkar Pinggang = 86cm\r\nPanjang Celana = 101cm	164000.00	9	300	["products/2k9bpRwqHt18w34TapTTvKmBPZYfs7dJtfxXLj7b.webp", "products/K1WGMonEwe0gl9BekHgzY8z86z7AdMv2uSVtcdHt.webp", "products/gXKouhu54X9Nda7AYYMQecesj1aZnF19Y2TZeojv.webp"]	t	2026-06-09 09:40:32	2026-06-09 09:40:32	0	\N	30	25	5	\N	\N	\N	\N
16	2	BASARI.ID (2206)- ADEEVA BLOUSE -Blouse Broken white - Atasan Broken White - Blouse Busui - Blouse Bahan adem - Korean Blouse	basariid-2206-adeeva-blouse-blouse-broken-white-atasan-broken-white-blouse-busui-blouse-bahan-adem-korean-blouse-wFWR	untuk barang yang sudah di beli tidak dapat dikembalikan karna masalah ukuran, karena terkait ukuran sudah di jelaskan di deskripsi, persyaratan refund apabila ada barang yang reject wajib di sertai video unboxing❤️\r\n\r\n\r\npanjang baju = 65 cm\r\nlingkar dada = 114 cm\r\npanjang lengan = 54 cm\r\nlingkar ketiak = 50 cm\r\n\r\n\r\n*Bahan Polo Linen*\r\n( adem tipis tidak bikin panas )\r\n\r\nwarna broken white menerawang wajib pake inner lagi\r\n\r\nBagian dada nya ada kancing, busui friendly!\r\n- Outfit undangan\r\n- Casual Outfit\r\n- Outfit kerja\r\n- Outfit ngantor\r\n- Outfit Kuliah	110000.00	10	300	["products/sjcW4D8bJicg6qAI5RXVj3objGRWwKC0JwymPiK1.webp", "products/C01XzGmeNKDezY8zXE8CI9UwOVEENQtt2qA45mj5.webp", "products/O0hi27QVMe1PtEVW81uDXE41GrcIrJsRMj7dIU96.webp", "products/hB6rvvJ14cBjD3JkWFJyzsmIg6RR6iUP0AK5OJoT.webp", "products/nF4xmTVcT0Fg967JaeEcf7nH9tatlEPxB2IMO0Ip.webp", "products/cap8RI7tQei26HVUwyBAcqQjVhY6yqJe9yRBdw5a.webp", "products/2pEco37gJCrOIJY3tcHcSg2ZFfclA6vCCNgNScz1.webp"]	t	2026-06-09 10:05:45	2026-06-09 10:05:45	6	\N	30	25	5	\N	\N	\N	\N
20	1	Black Blouse	black-blouse-dFCP	iabfiuhaseiuhiueahfdiusaehiuhesauirh	200000.00	0	12	["products/aAtYXuHvovrJVxC8gidgnboO3bbwmG8AC1AcVOJm.webp"]	t	2026-06-13 03:11:28	2026-06-15 05:36:19	0	products/videos/Cm9am2Lksd1ub3muH2cLRyohaluxgyveJDf4G1Q4.mp4	30	25	5	\N	\N	\N	\N
21	1	korpako	korpako-Vs6k	Bahu warna putih menarik dan bagus	150000.00	8	200	["products/gUDkYsIV36aowKqGe1I30r5R1lBZhhX4MksTgXcY.webp", "products/GnSvhiJ9bchWImv9pGNIGVJRbaG5K8aNVHYS9cfx.webp", "products/Wkag9x6P3i8wVH7ujfqY5Ri30Lmn9xKL310ivphw.webp"]	t	2026-06-15 08:05:08	2026-06-21 13:33:33	0	\N	30	25	5	White Outer	white shirt with good catoon	6.50	29.90
14	6	BASARI.ID - Atasan Polos Wanita - Atasan Bahan Knit Halus - Sweater Rajut - Sweater Polos Rajut	basariid-atasan-polos-wanita-atasan-bahan-knit-halus-sweater-rajut-sweater-polos-rajut-SES0	untuk barang yang sudah di beli tidak dapat dikembalikan karna masalah ukuran, karena terkait ukuran sudah di jelaskan di deskripsi, persyaratan refund apabila ada barang yang reject wajib di sertai video unboxing\r\n\r\n\r\n\r\nKnitwear\r\nBahan : Premium Viscose Knit\r\nbahannya tebal, lembut dan nyaman untuk dipakai \r\n\r\nSIZE I (S)\r\nLingkar Dada : 120 cm\r\nPanjang Baju Depan : 60 cm\r\nPanjang Baju Belakang : 67 cm\r\nPanjang Lengan : 54 cm\r\nLingkar Ketiak : 34 cm\r\n\r\nSIZE II (M)\r\nLingkar Dada : 126 cm\r\nPanjang Baju Depan : 60 cm\r\nPanjang Baju Belakang : 67 cm\r\nPanjang Lengan : 54 cm\r\nLingkar Ketiak : 34 cm\r\n\r\n\r\n*Toleransi Ukuran 2-3 cm, dikarenakan tipe bahan yang stretch*	174000.00	19	300	["products/hb2wjxliuwBVeGwe4GcdB5sqfFJTlusYRp1vcvu6.webp", "products/R3k5MAsPeBvCm2qZxFSfwQ0uNKzkuSldVtRVRBpi.webp", "products/mUWwlubIwGZRkbqefNeDxyLbcWjBayvQnvzuQ2Nv.webp", "products/lfeL5P9dEqUixInyOEXlVzxtimhFMAX8XatBxU4t.webp", "products/T2SvzTz9kaRpp3Pc1eqop6IbqtG14mthZvdBgcO1.webp", "products/TuPLrIyLvVgW3IXYaUSRRH3eWNsTi0cj7lZRv3en.webp", "products/IPXE8HD4DsZYWq3X8cb23xigyeHh7LeukkRV997n.webp", "products/fIbPOVmQH9zlCwGsUxEXpeb2wCaaCheif5VQiQn7.webp", "products/qd9idiyqUKsu0qY8UsZ3WyaCwj4SLH9ygys7EaFz.webp", "products/yKny70eQ6blyxnuGb6673UMGqCx5bT9AezmwowUY.webp"]	t	2026-06-09 09:53:11	2026-06-23 09:17:32	9	\N	30	25	5	\N	\N	\N	\N
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, user_id, product_id, order_id, order_item_id, rating, comment, admin_reply, admin_replied_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
HddTMrGQEvhjziQKBIWXmfxM7SCdFNKGQWYhVe4K	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiRmJieGNsa2FBOURCSzV6S3Jzb2xQY0Y1RjYwNTNTdnhOZGhnZHV0TyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sYWNhay1wZXNhbmFuIjtzOjU6InJvdXRlIjtzOjEzOiJ0cmFja2luZy5wYWdlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1782457912
nHjmkwOA6WysoXglQ3jy0tIFIwrmfJnpYojcsJI7	5	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	YTo1OntzOjY6Il90b2tlbiI7czo0MDoiVjk2QWtwd3AzSXRoaE1aNDhTOUhwengxUUMxUWVvcnZDYVRpaE81byI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTg6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi9kYXNoYm9hcmQvcmV2ZW51ZT9wZXJpb2Q9ZGFpbHkiO3M6NToicm91dGUiO3M6MjM6ImFkbWluLmRhc2hib2FyZC5yZXZlbnVlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6NTtzOjUyOiJsb2dpbl9hZG1pbl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==	1782441000
iyjqqK2j3o8vajgDxlQEigJWkSU2JIs1QWiG6xo3	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiTm5McThLT0lYVzdNR0VzZlpOMmo1aWN0MDduWlN2RGpPOGpRNkZHeSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wYXltZW50LW1ldGhvZCI7czo1OiJyb3V0ZSI7czoxMjoiaW5mby5wYXltZW50Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1782447837
ZATvB0fbBZH3QWLQF8fA3Fd8pzDtehuXJvDqyJr3	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.126.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiNTBORWxaQkY5V2RYVG5DV3hjcER3RTk5NXg1N3RaOW5xaXhFMzBQWiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wYXltZW50LW1ldGhvZCI7czo1OiJyb3V0ZSI7czoxMjoiaW5mby5wYXltZW50Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1782457600
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (id, key, value, created_at, updated_at) FROM stdin;
1	hero_video	videos/paqoC8HhJzn6HPTrVnyLVciAqWUyithonokCqTuL.mp4	2026-06-09 05:58:35	2026-06-18 03:31:20
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, phone, address, city, postal_code, remember_token, created_at, updated_at, locale) FROM stdin;
1	payy	pay@gmail.com	$2y$12$mHRnB5MmYKc75nRi.smE0OtHKS3IjNvonBCK6y.sfaZAAnJpxBGVu	086637886711	Jl ABC no 1	Bandung	40123	\N	2026-05-29 11:38:09	2026-05-30 10:04:05	id
5	Fahri	fahri.fazariadi@gmail.com	$2y$12$cNrAQt1c7QqDLCaJLPWMse03IYmjNKWl06A.XdxqTtapY3SSQ.rU.	\N	\N	\N	\N	\N	2026-06-24 07:26:03	2026-06-24 07:26:03	id
6	Gibran	gibranrabani888@gmail.con	$2y$12$2dNXV242Wbj6x8afXboWKOpFarxqG2p64EuCDsj8ri8dfuQdN.BIO	\N	\N	\N	\N	\N	2026-06-24 09:33:37	2026-06-24 09:33:37	id
7	Gibran	gibranrabani888@gmail.com	$2y$12$JnD2/G7V6DqNog5kRLdkzeWlFiS0K6qim14rkcNHVpi36I8cwIXTu	\N	\N	\N	\N	\N	2026-06-24 09:38:23	2026-06-24 09:38:23	id
\.


--
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_id_seq', 2, true);


--
-- Name: banners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.banners_id_seq', 11, true);


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 79, true);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_id_seq', 5, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 9, true);


--
-- Name: conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversations_id_seq', 13, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 26, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 45, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 278, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 61, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 61, true);


--
-- Name: page_visits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.page_visits_id_seq', 3138, true);


--
-- Name: product_colors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_colors_id_seq', 180, true);


--
-- Name: product_sizes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_sizes_id_seq', 115, true);


--
-- Name: product_views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_views_id_seq', 331, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 22, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 10, true);


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settings_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 7, true);


--
-- Name: admins admins_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_email_unique UNIQUE (email);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: banners banners_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banners
    ADD CONSTRAINT banners_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_slug_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_unique UNIQUE (slug);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_invoice_number_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_invoice_number_unique UNIQUE (invoice_number);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: page_visits page_visits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.page_visits
    ADD CONSTRAINT page_visits_pkey PRIMARY KEY (id);


--
-- Name: product_colors product_colors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_colors
    ADD CONSTRAINT product_colors_pkey PRIMARY KEY (id);


--
-- Name: product_sizes product_sizes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_sizes
    ADD CONSTRAINT product_sizes_pkey PRIMARY KEY (id);


--
-- Name: product_views product_views_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_views
    ADD CONSTRAINT product_views_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products products_slug_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_slug_unique UNIQUE (slug);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_user_id_order_item_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_order_item_id_unique UNIQUE (user_id, order_item_id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: settings settings_key_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_key_unique UNIQUE (key);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: cart_items cart_items_cart_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_foreign FOREIGN KEY (cart_id) REFERENCES public.carts(id) ON DELETE CASCADE;


--
-- Name: cart_items cart_items_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: carts carts_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: conversations conversations_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE SET NULL;


--
-- Name: conversations conversations_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: conversations conversations_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: messages messages_conversation_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_conversation_id_foreign FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE RESTRICT;


--
-- Name: orders orders_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: product_colors product_colors_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_colors
    ADD CONSTRAINT product_colors_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: product_sizes product_sizes_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_sizes
    ADD CONSTRAINT product_sizes_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: product_views product_views_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_views
    ADD CONSTRAINT product_views_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products products_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_foreign FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_order_item_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_order_item_id_foreign FOREIGN KEY (order_item_id) REFERENCES public.order_items(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict WHr1cZxaVmwI8z9ZAPVCB9m5Cnx9JYlavC2Is1IRmttQ3COWPfVmJxAGxadwDqg

