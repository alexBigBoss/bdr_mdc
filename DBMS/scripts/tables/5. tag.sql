-- Table: public.tag

-- DROP TABLE IF EXISTS public.tag;

CREATE TABLE IF NOT EXISTS public.tag
(
    id SERIAL PRIMARY KEY,
    userid bigint,
    movieid bigint,
    tag character varying(254),
    "timestamp" timestamp without time zone,

    FOREIGN KEY (movieid) REFERENCES public.movie(movieid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tag
    OWNER to postgres;
	
-- Índice en la columna movieid para mejorar búsquedas
CREATE INDEX idx_tag_movieid ON public.tag(movieid);