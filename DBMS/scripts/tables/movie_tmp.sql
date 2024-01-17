-- Table: public.movie_tmp

-- DROP TABLE IF EXISTS public.movie_tmp;

CREATE TABLE IF NOT EXISTS public.movie_tmp
(
    id SERIAL PRIMARY KEY,
    movieid bigint,
    title character varying(234) COLLATE pg_catalog."default",
    genres character varying(234) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.movie_tmp
    OWNER to postgres;