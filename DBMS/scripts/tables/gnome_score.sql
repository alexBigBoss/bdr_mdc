-- Table: public.gnome_score_tmp

-- DROP TABLE IF EXISTS public.gnome_score_tmp;

CREATE TABLE IF NOT EXISTS public.gnome_score_tmp
(
    id SERIAL PRIMARY KEY,
    movieid bigint,
    tagid bigint,
    relevance NUMERIC(5, 1)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.gnome_score_tmp
    OWNER to postgres;