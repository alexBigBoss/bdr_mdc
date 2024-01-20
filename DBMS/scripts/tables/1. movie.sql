-- Table: public.movie

-- DROP TABLE IF EXISTS public.movie;

CREATE TABLE IF NOT EXISTS public.movie
(
    movieid SERIAL PRIMARY KEY,
    title character varying(234)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.movie
    OWNER to postgres;

-- Índice en la columna movieid para mejorar búsquedas
CREATE INDEX idx_movie_movieid ON public.movie(movieid);