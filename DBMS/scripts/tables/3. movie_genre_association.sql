-- Crear la tabla movie_genre_association
CREATE TABLE IF NOT EXISTS public.movie_genre_association
(
    id SERIAL PRIMARY KEY,
    movieid bigint,
    genreid bigint,
    FOREIGN KEY (movieid) REFERENCES public.movie(movieid),
    FOREIGN KEY (genreid) REFERENCES public.genre(id)
);

-- Crear un índice en la columna movieid para mejorar búsquedas
CREATE INDEX idx_movie_genre_association_movieid ON public.movie_genre_association(movieid);

-- Crear un índice en la columna genreid para mejorar búsquedas
CREATE INDEX idx_movie_genre_association_genreid ON public.movie_genre_association(genreid);
