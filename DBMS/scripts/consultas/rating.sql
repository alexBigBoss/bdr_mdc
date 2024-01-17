SELECT id, userid, movieid, rating, 
	   TO_TIMESTAMP(timestamp) AS converted_timestamp
  FROM rating_tmp 
 ORDER BY converted_timestamp DESC
 LIMIT 100