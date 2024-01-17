-- Table: public.gnome_tag_tmp

-- DROP TABLE IF EXISTS public.gnome_tag_tmp;

CREATE TABLE IF NOT EXISTS public.gnome_tag_tmp
(
    id SERIAL PRIMARY KEY,
    tagid bigint,
    tag character varying(234) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.gnome_tag_tmp
    OWNER to postgres;