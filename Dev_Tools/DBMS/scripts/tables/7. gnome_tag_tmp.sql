-- Table: public.gnome_tag

-- DROP TABLE IF EXISTS public.gnome_tag;

CREATE TABLE IF NOT EXISTS public.gnome_tag
(
    tagid SERIAL PRIMARY KEY,
    tag character varying(234)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.gnome_tag
    OWNER to postgres;

-- Índice en la columna tag para mejorar búsquedas
CREATE INDEX idx_gnome_tag_tag ON public.gnome_tag(tag);