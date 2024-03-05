CREATE OR REPLACE VIEW vista_conteo_peliculas_genero AS
SELECT genre.genre, COUNT(1) cantidad
  FROM movie
 INNER JOIN movie_genre AS mga ON movie.movieid = mga.movieid
 INNER JOIN genre ON genre.id = mga.genreid
 GROUP BY genre.genre
 ORDER BY cantidad DESC;
 
SELECT * FROM vista_conteo_peliculas_genero;

CREATE OR REPLACE VIEW vista_conteo_peliculas_rating AS
SELECT movie.title, rating.userid, rating.rating, rating.timestamp
  FROM movie
  LEFT JOIN rating ON rating.movieid = movie.movieid;

SELECT * FROM vista_conteo_peliculas_rating;

CREATE OR REPLACE VIEW vista_conteo_peliculas_tag AS
SELECT movie.title, tag.userid, tag.tag, tag.timestamp
  FROM movie
 RIGHT JOIN tag ON tag.movieid = movie.movieid;

SELECT * FROM vista_conteo_peliculas_tag;

CREATE OR REPLACE VIEW vista_usuario_mas_participacion AS
SELECT users_with_many_tags.userid, movie.title, rating.rating, tag.tag
  FROM (
    SELECT tag.userid
      FROM tag
     GROUP BY tag.userid
     HAVING COUNT(1) > 16000
 ) AS users_with_many_tags 
 INNER JOIN rating ON rating.userid = users_with_many_tags.userid
 INNER JOIN movie ON movie.movieid = rating.movieid
 INNER JOIN tag ON movie.movieid = tag.movieid AND tag.userid = users_with_many_tags.userid;

SELECT * FROM vista_usuario_mas_participacion;

CREATE OR REPLACE FUNCTION fn_delete_movie_related()
RETURNS TRIGGER AS $$
BEGIN
    -- Eliminar registros relacionados en movie_genre
    DELETE FROM public.movie_genre WHERE movieid = OLD.movieid;
    
    -- Eliminar registros relacionados en rating
    DELETE FROM public.rating WHERE movieid = OLD.movieid;
    
    -- Eliminar registros relacionados en tag
    DELETE FROM public.tag WHERE movieid = OLD.movieid;
    
    -- Eliminar registros relacionados en link
    DELETE FROM public.link WHERE movieid = OLD.movieid;
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_delete_movie
BEFORE DELETE ON public.movie
FOR EACH ROW EXECUTE FUNCTION fn_delete_movie_related();