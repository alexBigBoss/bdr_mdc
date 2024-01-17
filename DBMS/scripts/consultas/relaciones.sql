SELECT rating.userid, rating.rating, movie.title, movie.genres,
	   tag.tag
  FROM rating_tmp AS rating
 INNER JOIN movie_tmp AS movie ON rating.movieid = movie.movieid
 INNER JOIN tag_tmp AS tag ON tag.movieid = movie.movieid and rating.userid = tag.userid
 LIMIT 100