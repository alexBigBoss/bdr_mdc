-- Vista por pelicula
SELECT movie.title, movie.genres, genre.genre
  FROM movie
 INNER JOIN movie_genre_association AS mga ON movie.movieid = mga.movieid
 INNER JOIN genre ON genre.id = mga.genreid
 WHERE movie.movieid = 1
 
-- Vista de por genero
SELECT movie.title, genre.genre
  FROM movie
 INNER JOIN movie_genre_association AS mga ON movie.movieid = mga.movieid
 INNER JOIN genre ON genre.id = mga.genreid
 WHERE genre.id = 3
 LIMIT 1000 
 
-- Vista por rating dada una pelicula
SELECT movie.title, rating.userid, rating.rating, rating.timestamp
  FROM movie
 INNER JOIN rating ON rating.movieid = movie.movieid
 WHERE movie.movieid = 1
 LIMIT 1000 