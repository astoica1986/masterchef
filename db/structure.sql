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

--
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recipes (
    id bigint NOT NULL,
    rate double precision DEFAULT 0.0,
    author_tip character varying,
    prep_time integer DEFAULT 0,
    budget character varying,
    name text NOT NULL,
    difficulty text,
    people_quantity integer,
    cook_time integer DEFAULT 0,
    total_time integer DEFAULT 0,
    nb_comments integer,
    image character varying,
    author text,
    tags text[] DEFAULT '{}'::text[],
    ingredients text DEFAULT '{}'::text[],
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    searchable tsvector GENERATED ALWAYS AS ((((setweight(to_tsvector('french'::regconfig, COALESCE(ingredients, ''::text)), 'A'::"char") || setweight(to_tsvector('french'::regconfig, COALESCE(name, ''::text)), 'B'::"char")) || setweight(to_tsvector('french'::regconfig, COALESCE(author, ''::text)), 'C'::"char")) || setweight(to_tsvector('french'::regconfig, COALESCE(difficulty, ''::text)), 'D'::"char"))) STORED
);


--
-- Name: recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recipes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recipes_id_seq OWNED BY public.recipes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: recipes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes ALTER COLUMN id SET DEFAULT nextval('public.recipes_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_recipes_on_author; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_author ON public.recipes USING gin (author);


--
-- Name: index_recipes_on_difficulty; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_difficulty ON public.recipes USING gin (difficulty);


--
-- Name: index_recipes_on_ingredients; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_ingredients ON public.recipes USING gin (ingredients);


--
-- Name: index_recipes_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_name ON public.recipes USING gin (name);


--
-- Name: index_recipes_on_searchable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_searchable ON public.recipes USING gin (searchable);


--
-- Name: index_recipes_on_tags; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_tags ON public.recipes USING gin (tags);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20211118034711'),
('20211118160035'),
('20211118180143'),
('20211128080727'),
('20211128081321');


