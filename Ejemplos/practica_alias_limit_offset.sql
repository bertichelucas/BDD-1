/*** ALIAS LIMIT Y OFFSET ***/

#Mostrar el título de todas las series y usar alias para que el nombre del campo
#este en español.

SELECT title AS titulo FROM series;

/*
Traer el título de las películas con el rating mayor a 3, con más de 1 premio y con
fecha de lanzamiento entre el año ‘1988-01-01’ al ‘2009-12-31’. Ordenar los
resultados por rating descendentemente.
*/

SELECT title AS titulo, rating AS calificacion FROM movies
WHERE rating > 3 AND awards > 1 AND release_date BETWEEN "1988-01-01" AND "2009-12-31"
ORDER BY rating DESC;

#Traer el top 3 a partir del registro 10 de la consulta anterior.

SELECT title AS titulo, rating AS calificacion FROM movies
WHERE rating > 3 AND awards > 1 AND release_date BETWEEN "1988-01-01" AND "2009-12-31"
ORDER BY rating DESC
LIMIT 3;

#¿Cuáles son los 3 peores episodios teniendo en cuenta su rating?

SELECT title, number, rating FROM episodes
ORDER BY rating
LIMIT 3;

#Obtener el listado de todos los actores. Quitar las columnas de fechas y película
#favorita, además traducir los nombres de las columnas.

SELECT first_name AS Nombre, last_name AS Apellido, rating AS Calificacion FROM actors;

/*** ALIAS, LIMIT Y OFFSET PARTE 2 ***/

#Mostrar el título de todas las series y usar alias para que tanto el nombre de la
#tabla como el campo estén en español.

SELECT title AS titulo FROM series AS Series;

