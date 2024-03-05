# Tarea 8

## Descripción de la actividad

1. Crear vistas (view) sobre consultas significativas, recurrentes, etc. que
- incluye un JOIN
- incluye un LEFT JOIN
- incluye un RIGHT JOIN
- incluye una subconsulta
2. Investigar y crear al menos un disparador (TRIGGER) de inserción, actualización o eliminación.
3. Guarda tus consultas como archivo SQL en tus repositorio
4. Explicar qué hace cada vista y disparador que utilizas qué beneficios para tu BD

## Desarrollo de la actividad

### 1. Crear vistas (view) sobre consultas significativas, recurrentes

#### JOIN

Esta vista realiza un conteo de películas por género, utilizando un INNER JOIN entre las tablas movie, movie_genre y genre. Agrupa los resultados por género y los ordena en forma descendente por cantidad. Es útil para obtener rápidamente una visión general de la distribución de películas por género en la base de datos.

```sql
CREATE OR REPLACE VIEW vista_conteo_peliculas_genero AS
SELECT genre.genre, COUNT(1) cantidad
  FROM movie
 INNER JOIN movie_genre AS mga ON movie.movieid = mga.movieid
 INNER JOIN genre ON genre.id = mga.genreid
 GROUP BY genre.genre
 ORDER BY cantidad DESC;
 
SELECT * FROM vista_conteo_peliculas_genero;
```

#### LEFT JOIN

Esta vista utiliza un LEFT JOIN para relacionar las películas con sus calificaciones, mostrando todos los títulos de películas incluso si no tienen calificaciones asociadas. Es útil para analizar todas las películas y sus calificaciones (si existen), permitiendo identificar aquellas sin calificar.

```sql
CREATE OR REPLACE VIEW vista_conteo_peliculas_rating AS
SELECT movie.title, rating.userid, rating.rating, rating.timestamp
  FROM movie
  LEFT JOIN rating ON rating.movieid = movie.movieid;

SELECT * FROM vista_conteo_peliculas_rating;
```

#### RIGHT JOIN

Mediante un RIGHT JOIN, esta vista asocia cada película con sus etiquetas (tags), mostrando todas las etiquetas incluso si no están vinculadas a una película. Es útil para entender cómo los usuarios etiquetan las películas, incluyendo aquellas películas que no tienen etiquetas.

```sql
CREATE OR REPLACE VIEW vista_conteo_peliculas_tag AS
SELECT movie.title, tag.userid, tag.tag, tag.timestamp
  FROM movie
 RIGHT JOIN tag ON tag.movieid = movie.movieid;

SELECT * FROM vista_conteo_peliculas_tag;
```

#### Sub consulta

Esta vista identifica a los usuarios con más de 16,000 etiquetas, mostrando las películas que han calificado y etiquetado. Utiliza una subconsulta para filtrar estos usuarios y luego realiza varios INNER JOIN para recuperar información relevante.

```sql
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
```

## 2. Investigar y crear al menos un disparador (TRIGGER) de inserción, actualización o eliminación.

El disparador trg_delete_movie está diseñado para mantener la integridad de la base de datos al eliminar automáticamente todos los registros relacionados en movie_genre, rating, tag, y link cuando se elimina una película de la tabla movie. Esto asegura que no queden datos huérfanos en la base de datos después de que se elimina una película.

```sql
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
```

## 3. Guarda tus consultas como archivo SQL

[Script de base de datos](script.sql)