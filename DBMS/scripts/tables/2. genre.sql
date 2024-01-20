-- Table: public.genre

-- DROP TABLE IF EXISTS public.genre;

CREATE TABLE IF NOT EXISTS public.genre
(
    id SERIAL PRIMARY KEY,
    genre character varying(50)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.genre
    OWNER to postgres;

-- Añadir un índice a la columna 'genre' de la tabla 'genre'
CREATE INDEX idx_genre ON public.genre(genre);