-- Table: public.tag_tmp

-- DROP TABLE IF EXISTS public.tag_tmp;

CREATE TABLE IF NOT EXISTS public.tag_tmp
(
    id SERIAL PRIMARY KEY,
    userid bigint,
    movieid bigint,
    tag character varying(254),
    "timestamp" bigint
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tag_tmp
    OWNER to postgres;