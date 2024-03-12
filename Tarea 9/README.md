# Tarea 9

## Descripción de la actividad

1. Usa lo aprendido hasta ahora para crear al menos dos funciones o procedimientos almacenados que calculen algunos de lo siguientes resultados (o equivalentes):
- correlación entre dos conjuntos de datos, o
- regresión lineal entre 2 variables, o
- distancia de levenstein entre cadena de caracteres, o
- cantidad de elementos de un arreglo, o
- seasonal naive para series de tiempo

## Desarrollo de la actividad

### Correlación entre 2 peliculas calificadas por los mismos usuarios.

```sql
CREATE OR REPLACE FUNCTION calcular_correlacion_entre_peliculas(movieid1 bigint, movieid2 bigint)
RETURNS numeric AS $$
DECLARE
    suma_rating1 numeric;
    suma_rating2 numeric;
    suma_rating1_cuadrado numeric;
    suma_rating2_cuadrado numeric;
    suma_productos numeric;
    n int;
    correlacion numeric;
    denominador numeric;
BEGIN
    -- Recoger las calificaciones para las dos películas por parte de los mismos usuarios
    SELECT 
        SUM(r1.rating) AS suma_rating1, 
        SUM(r2.rating) AS suma_rating2, 
        SUM(r1.rating * r1.rating) AS suma_rating1_cuadrado, 
        SUM(r2.rating * r2.rating) AS suma_rating2_cuadrado, 
        SUM(r1.rating * r2.rating) AS suma_productos, 
        COUNT(*) AS n
    INTO suma_rating1, suma_rating2, suma_rating1_cuadrado, suma_rating2_cuadrado, suma_productos, n
    FROM public.rating r1
    JOIN public.rating r2 ON r1.userid = r2.userid AND r2.movieid = movieid2
    WHERE r1.movieid = movieid1 AND r1.userid IN (SELECT userid FROM public.rating WHERE movieid = movieid2);

    -- Calcular el denominador de la fórmula de correlación
    denominador := SQRT((n * suma_rating1_cuadrado - suma_rating1 * suma_rating1) * (n * suma_rating2_cuadrado - suma_rating2 * suma_rating2));
    
    -- Verificar si el denominador es cero para prevenir división por cero
    IF denominador = 0 OR n = 0 THEN
        RETURN NULL; -- Retorna NULL si el denominador es cero o no hay datos comunes
    ELSE
        -- Calcular la correlación de Pearson
        correlacion := (n * suma_productos - suma_rating1 * suma_rating2) / denominador;
        RETURN correlacion;
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT calcular_correlacion_entre_peliculas(1, 12)
```

El código anterior define una función en PostgreSQL llamada calcular_correlacion_entre_peliculas, diseñada para calcular la correlación de Pearson entre las calificaciones de dos películas específicas, identificadas por sus movieid. La correlación de Pearson es una medida estadística que indica el grado de relación lineal entre dos variables, en este caso, las calificaciones de dos películas. El valor de correlación varía entre -1 y 1, donde 1 indica una correlación positiva perfecta, -1 una correlación negativa perfecta, y 0 ninguna correlación.

- Solo se incluyen usuarios que han calificado ambas películas, lo que es crucial para calcular la correlación correctamente.


### Regresión lineal

```sql
CREATE OR REPLACE FUNCTION calcular_regresion_lineal()
RETURNS TABLE(pendiente numeric, interseccion numeric) AS $$
DECLARE
    suma_x numeric; -- Suma del total de calificaciones recibidas por película
    suma_y numeric; -- Suma de las calificaciones promedio
    suma_xy numeric; -- Suma del producto de x*y
    suma_x_cuadrado numeric; -- Suma de x al cuadrado
    n int; -- Número total de entradas
    m numeric; -- Pendiente de la línea de regresión
    b numeric; -- Intersección con el eje Y
BEGIN
    -- Calcular las sumas y el número de películas
    SELECT 
        SUM(contador), 
        SUM(promedio),
        SUM(contador*promedio),
        SUM(contador*contador),
        COUNT(*)
    INTO suma_x, suma_y, suma_xy, suma_x_cuadrado, n
    FROM (
        SELECT 
            movieid, 
            COUNT(rating) AS contador, -- Total de calificaciones por película
            AVG(rating) AS promedio -- Promedio de calificaciones por película
        FROM public.rating
        GROUP BY movieid
    ) AS datos;

    -- Calcular pendiente (m) y la intersección (b)
    m := (n * suma_xy - suma_x * suma_y) / (n * suma_x_cuadrado - suma_x * suma_x);
    b := (suma_y - m * suma_x) / n;

    RETURN QUERY SELECT m, b;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM calcular_regresion_lineal();
```

El código anterior define una función en PostgreSQL llamada calcular_regresion_lineal, que calcula la línea de regresión lineal entre dos variables dentro de un conjunto de datos de películas. La regresión lineal es un método estadístico utilizado para modelar la relación entre una variable dependiente y una o más variables independientes, ajustando una línea recta (y= mx+b) a los datos. En este contexto, la función intenta predecir la calificación promedio de las películas (y) basada en el número total de calificaciones que reciben (x).