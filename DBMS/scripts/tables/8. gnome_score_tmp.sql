-- Table: public.gnome_score

-- DROP TABLE IF EXISTS public.gnome_score;

CREATE TABLE IF NOT EXISTS public.gnome_score
(
    id SERIAL PRIMARY KEY,
    movieid bigint,
    tagid bigint,
    relevance NUMERIC(5, 1),

    FOREIGN KEY (movieid) REFERENCES public.movie(movieid),
    FOREIGN KEY (tagid) REFERENCES public.gnome_tag(tagid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.gnome_score
    OWNER to postgres;

-- Índices en las columnas movieid y tagid para mejorar búsquedas
CREATE INDEX idx_gnome_score_movieid ON public.gnome_score(movieid);
CREATE INDEX idx_gnome_score_tagid ON public.gnome_score(tagid);