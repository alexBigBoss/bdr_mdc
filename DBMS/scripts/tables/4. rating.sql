-- Table: public.rating

-- DROP TABLE IF EXISTS public.rating;

CREATE TABLE IF NOT EXISTS public.rating
(
    id SERIAL PRIMARY KEY,
    userid bigint,
    movieid bigint,
    rating NUMERIC(5, 1),
    "timestamp" timestamp without time zone,

    FOREIGN KEY (movieid) REFERENCES public.movie(movieid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.rating
    OWNER to postgres;

-- Índice en la columna movieid para mejorar búsquedas
CREATE INDEX idx_rating_movieid ON public.rating(movieid);