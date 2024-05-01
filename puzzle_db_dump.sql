--
-- PostgreSQL database dump
--

-- Dumped from database version 15.6 (Homebrew)
-- Dumped by pg_dump version 15.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: Score; Type: TABLE; Schema: public; Owner: ggg
--

CREATE TABLE public."Score" (
    id integer NOT NULL,
    points integer NOT NULL,
    "puzzleSize" integer NOT NULL,
    "userId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "numberOfMovesMade" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."Score" OWNER TO ggg;

--
-- Name: Score_id_seq; Type: SEQUENCE; Schema: public; Owner: ggg
--

CREATE SEQUENCE public."Score_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Score_id_seq" OWNER TO ggg;

--
-- Name: Score_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ggg
--

ALTER SEQUENCE public."Score_id_seq" OWNED BY public."Score".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: ggg
--

CREATE TABLE public."User" (
    id text NOT NULL,
    "socketId" text NOT NULL
);


ALTER TABLE public."User" OWNER TO ggg;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: ggg
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO ggg;

--
-- Name: Score id; Type: DEFAULT; Schema: public; Owner: ggg
--

ALTER TABLE ONLY public."Score" ALTER COLUMN id SET DEFAULT nextval('public."Score_id_seq"'::regclass);


--
-- Data for Name: Score; Type: TABLE DATA; Schema: public; Owner: ggg
--

COPY public."Score" (id, points, "puzzleSize", "userId", "createdAt", "numberOfMovesMade") FROM stdin;
2	734	3	AWy3CsTy1Eb4bGAUAAAB	2024-05-01 10:44:27.126	0
3	964	3	5k009G8wbPdMuPYgAAAD	2024-05-01 11:25:26.309	0
4	798	3	_17vZiivJ9haXMHJAAAF	2024-05-01 11:41:22.359	0
5	796	3	_17vZiivJ9haXMHJAAAF	2024-05-01 11:42:19.169	0
6	794	3	_17vZiivJ9haXMHJAAAF	2024-05-01 11:43:07.557	0
7	714	4	Yes3bYkqU0DfwxHGAAAB	2024-05-01 11:59:54.39	0
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: ggg
--

COPY public."User" (id, "socketId") FROM stdin;
AWy3CsTy1Eb4bGAUAAAB	AWy3CsTy1Eb4bGAUAAAB
5k009G8wbPdMuPYgAAAD	5k009G8wbPdMuPYgAAAD
_17vZiivJ9haXMHJAAAF	_17vZiivJ9haXMHJAAAF
Yes3bYkqU0DfwxHGAAAB	Yes3bYkqU0DfwxHGAAAB
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: ggg
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
64a1d9f3-a2ce-44d1-a462-96131804441f	17c5a9880b0db275fcd312e1b110e115b188dc25bb2eb52eda1ec4092967e86a	2024-04-29 14:36:34.187939+05	20240429093634_init	\N	\N	2024-04-29 14:36:34.178322+05	1
74b70d8c-63cd-4615-80b5-88e6c0cc6629	4ec126ceb217cadca45740005a86f9ba3f6fee436bada627f431589e5a0ef8cf	2024-05-01 15:48:51.350364+05	20240501104851_add_moves_to_scores	\N	\N	2024-05-01 15:48:51.347559+05	1
\.


--
-- Name: Score_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ggg
--

SELECT pg_catalog.setval('public."Score_id_seq"', 7, true);


--
-- Name: Score Score_pkey; Type: CONSTRAINT; Schema: public; Owner: ggg
--

ALTER TABLE ONLY public."Score"
    ADD CONSTRAINT "Score_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: ggg
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: ggg
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: User_socketId_key; Type: INDEX; Schema: public; Owner: ggg
--

CREATE UNIQUE INDEX "User_socketId_key" ON public."User" USING btree ("socketId");


--
-- Name: Score Score_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ggg
--

ALTER TABLE ONLY public."Score"
    ADD CONSTRAINT "Score_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

