-- Table: public.link_tmp

-- DROP TABLE IF EXISTS public.link_tmp;

CREATE TABLE IF NOT EXISTS public.link_tmp
(
    id SERIAL PRIMARY KEY,
    movieid bigint,
    imdbid bigint,
    tmdbid bigint
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.link_tmp
    OWNER to postgres;