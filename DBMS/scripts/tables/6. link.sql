-- Table: public.link

-- DROP TABLE IF EXISTS public.link;

CREATE TABLE IF NOT EXISTS public.link
(
    id SERIAL PRIMARY KEY,
    movieid bigint,
    imdbid bigint,
    tmdbid bigint,

    FOREIGN KEY (movieid) REFERENCES public.movie(movieid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.link
    OWNER to postgres;

-- Índice en la columna movieid para mejorar búsquedas
CREATE INDEX idx_link_movieid ON public.link(movieid);
