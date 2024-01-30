# Tarea 3

## Descripción de la actividad

1. Crear un esquema del modelo relacional de tu base de datos a partir del modelo entidad relación de la tarea anterior.
2. Representar con un diagrama relacional tu esquema del punto anterior
3. Encuentra cuatro operaciones que vayas a usar en tu base de datos y exprésalas mediante operadores del álgebra relacional. Explica con tus propias palabras cada una de estas operaciones.

## Desarrollo de la actividad

### Esquema modelo relacional

![Tarea_3](./Tarea%203.png)

### Consultas de base de datos

1. Consultar los géneros dado la pelicula con id 1

```
π: movie.title, movie.genres, genre.genre
σ: movie.movieid = 1
(movie x movie_genre x genre)
```
 
2. Consulta de todas las pelicula que contengan el por género igual a 3

```
π: movie.title, genre.genre
σ: genre.id = 3
(movie x movie_genre x genre)
```
 
3. Consultar todas las calificaciones (ratings) de la pelicula con id 3

```
π: movie.title, rating.userid, rating.rating, rating.timestamp
σ: movie.movieid = 3
(movie x rating)
```

4. Consultar todas las peliculas con la etiqueta `'artificial intelligence'`

```
π: movie.title, tag.userid, tag.tag, tag.timestamp
σ: tag.tag = 'artificial intelligence'
(movie x tag)
```