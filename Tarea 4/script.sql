CREATE DATABASE movie_lens;

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

-- Crear la tabla movie_genre
CREATE TABLE IF NOT EXISTS public.movie_genre
(
    id SERIAL PRIMARY KEY,
    movieid bigint,
    genreid bigint,
    FOREIGN KEY (movieid) REFERENCES public.movie(movieid),
    FOREIGN KEY (genreid) REFERENCES public.genre(id)
);

-- Crear un índice en la columna movieid para mejorar búsquedas
CREATE INDEX idx_movie_genre_movieid ON public.movie_genre(movieid);

-- Crear un índice en la columna genreid para mejorar búsquedas
CREATE INDEX idx_movie_genre_genreid ON public.movie_genre(genreid);

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

INSERT INTO public.movie (movieid, title) VALUES
(1, 'Toy Story (1995)'),
(2, 'Jumanji (1995)'),
(3, 'Grumpier Old Men (1995)'),
(4, 'Waiting to Exhale (1995)'),
(5, 'Father of the Bride Part II (1995)'),
(6, 'Heat (1995)'),
(7, 'Sabrina (1995)'),
(8, 'Tom and Huck (1995)'),
(9, 'Sudden Death (1995)'),
(10, 'GoldenEye (1995)'),
(11, 'American President, The (1995)'),
(12, 'Dracula: Dead and Loving It (1995)'),
(13, 'Balto (1995)'),
(14, 'Nixon (1995)'),
(15, 'Cutthroat Island (1995)'),
(16, 'Casino (1995)'),
(17, 'Sense and Sensibility (1995)'),
(18, 'Four Rooms (1995)'),
(19, 'Ace Ventura: When Nature Calls (1995)'),
(20, 'Money Train (1995)');

INSERT INTO public.genre (id, genre) VALUES
(1, '(no genres listed)'),
(2, 'Action'),
(3, 'Adventure'),
(4, 'Animation'),
(5, 'Children'),
(6, 'Comedy'),
(7, 'Crime'),
(8, 'Documentary'),
(9, 'Drama'),
(10, 'Fantasy'),
(11, 'Film-Noir'),
(12, 'Horror'),
(13, 'IMAX'),
(14, 'Musical'),
(15, 'Mystery'),
(16, 'Romance'),
(17, 'Sci-Fi'),
(18, 'Thriller'),
(19, 'War'),
(20, 'Western');


INSERT INTO public.movie_genre (id, movieid, genreid) VALUES
(1, 1, 3),
(2, 1, 4),
(3, 1, 5),
(4, 1, 6),
(5, 1, 10),
(6, 2, 3),
(7, 2, 5),
(8, 2, 10),
(9, 3, 6),
(10, 3, 16),
(11, 4, 6),
(12, 4, 9),
(13, 4, 16),
(14, 5, 6),
(15, 6, 2),
(16, 6, 7),
(17, 6, 18),
(18, 7, 6),
(19, 7, 16),
(20, 8, 3);

INSERT INTO public.rating (id, userid, movieid, rating, "timestamp") VALUES
(71, 2, 1, 3.5, '1970-01-14 05:03:35.82'),
(255, 3, 1, 4.0, '1970-01-17 15:51:12.215'),
(911, 4, 1, 3.0, '1970-01-19 05:12:24.252'),
(1153, 5, 1, 4.0, '1970-01-10 22:30:25.949'),
(1305, 8, 1, 4.0, '1970-01-11 07:21:32.517'),
(1638, 10, 1, 3.5, '1970-01-15 04:59:31.347'),
(1715, 12, 1, 4.0, '1970-01-14 12:19:42.601'),
(2451, 13, 1, 4.0, '1970-01-15 15:27:03.97'),
(3017, 18, 1, 3.0, '1970-01-13 19:51:13.483'),
(4348, 26, 1, 3.0, '1970-01-15 19:41:55.839'),
(5102, 36, 1, 5.0, '1970-01-10 22:05:31.378'),
(5859, 43, 1, 4.0, '1970-01-14 13:08:11.388'),
(6538, 47, 1, 2.0, '1970-01-10 21:31:33.79'),
(6658, 50, 1, 4.0, '1970-01-17 05:35:05.313'),
(6739, 51, 1, 4.0, '1970-01-18 11:39:02.879'),
(6892, 56, 1, 2.0, '1970-01-14 12:06:15.56'),
(6922, 57, 1, 4.0, '1970-01-14 05:20:03.282'),
(8352, 64, 1, 4.0, '1970-01-17 14:30:44.429'),
(8439, 66, 1, 3.0, '1970-01-14 04:16:40.903'),
(8518, 67, 1, 3.0, '1970-01-12 07:01:01.584');

INSERT INTO public.tag (id, userid, movieid, tag, "timestamp") VALUES
(2307, 791, 1, 'Owned', '1970-01-18 12:52:55.493'),
(3750, 1048, 1, 'imdb top 250', '1970-01-14 13:35:44.394'),
(4227, 1361, 1, 'Pixar', '1970-01-15 01:49:06.311'),
(10004, 3164, 1, 'Pixar', '1970-01-15 03:48:24.727'),
(10005, 3164, 1, 'time travel', '1970-01-15 03:48:24.729'),
(14075, 3448, 1, 'children', '1970-01-18 06:38:21.854'),
(14076, 3448, 1, 'comedy', '1970-01-18 06:38:21.863'),
(14077, 3448, 1, 'funny', '1970-01-18 06:38:21.851'),
(14078, 3448, 1, 'witty', '1970-01-18 06:38:21.861'),
(23978, 4676, 1, 'rated-G', '1970-01-14 03:57:04.344'),
(24018, 4693, 1, 'animation', '1970-01-15 10:32:34.12'),
(24019, 4693, 1, 'Pixar', '1970-01-15 10:32:34.116'),
(24937, 5054, 1, 'computer animation', '1970-01-17 14:12:13.2'),
(24938, 5054, 1, 'good cartoon chindren', '1970-01-17 14:12:13.217'),
(24939, 5054, 1, 'pixar', '1970-01-17 14:12:13.206'),
(27546, 5571, 1, 'friendship', '1970-01-17 13:41:56.267'),
(33037, 6285, 1, 'bright', '1970-01-14 13:55:04.07'),
(33038, 6285, 1, 'DARING RESCUES', '1970-01-14 13:55:04.095'),
(33039, 6285, 1, 'fanciful', '1970-01-14 13:55:04.058'),
(33040, 6285, 1, 'HEROIC MISSION', '1970-01-14 13:55:04.102');

INSERT INTO public.link (id, movieid, imdbid, tmdbid) VALUES
(1, 1, 114709, 862),
(2, 2, 113497, 8844),
(3, 3, 113228, 15602),
(4, 4, 114885, 31357),
(5, 5, 113041, 11862),
(6, 6, 113277, 949),
(7, 7, 114319, 11860),
(8, 8, 112302, 45325),
(9, 9, 114576, 9091),
(10, 10, 113189, 710),
(11, 11, 112346, 9087),
(12, 12, 112896, 12110),
(13, 13, 112453, 21032),
(14, 14, 113987, 10858),
(15, 15, 112760, 1408),
(16, 16, 112641, 524),
(17, 17, 114388, 4584),
(18, 18, 113101, 5),
(19, 19, 112281, 9273),
(20, 20, 113845, 11517);

INSERT INTO public.gnome_tag (tagid, tag) VALUES
(1, '007'),
(2, '007 (series)'),
(3, '18th century'),
(4, '1920s'),
(5, '1930s'),
(6, '1950s'),
(7, '1960s'),
(8, '1970s'),
(9, '1980s'),
(10, '19th century'),
(11, '3d'),
(12, '70mm'),
(13, '80s'),
(14, '9/11'),
(15, 'aardman'),
(16, 'aardman studios'),
(17, 'abortion'),
(18, 'absurd'),
(19, 'action'),
(20, 'action packed');

INSERT INTO public.gnome_score (id, movieid, tagid, relevance) VALUES
(1, 1, 1, 0.0),
(2, 1, 2, 0.0),
(3, 1, 3, 0.0),
(4, 1, 4, 0.0),
(5, 1, 5, 0.0),
(6, 1, 6, 0.0),
(7, 1, 7, 0.0),
(8, 1, 8, 0.0),
(9, 1, 9, 0.0),
(10, 1, 10, 0.0),
(11, 1, 11, 1.0),
(12, 1, 12, 0.0),
(13, 1, 13, 0.0),
(14, 1, 14, 0.0),
(15, 1, 15, 0.0),
(16, 1, 16, 0.0),
(17, 1, 17, 0.0),
(18, 1, 18, 0.0),
(19, 1, 19, 1.0),
(20, 1, 20, 0.0);