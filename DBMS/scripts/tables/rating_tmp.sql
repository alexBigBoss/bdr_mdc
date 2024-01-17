-- Table: public.rating_tmp

-- DROP TABLE IF EXISTS public.rating_tmp;

CREATE TABLE IF NOT EXISTS public.rating_tmp
(
    id SERIAL PRIMARY KEY,
    userid bigint,
    movieid bigint,
    rating NUMERIC(5, 1),
    "timestamp" bigint
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.rating_tmp
    OWNER to postgres;