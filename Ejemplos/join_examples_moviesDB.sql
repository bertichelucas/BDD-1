/*Utilizando la base de datos de movies, queremos conocer, por un lado, los
títulos y el nombre del género de todas las series de la base de datos.*/

SELECT title, name FROM series
INNER JOIN genres ON genre_id = genres.id;

/*Por otro, necesitamos listar los títulos de los episodios junto con el nombre y
apellido de los actores que trabajan en cada uno de ellos.*/

SELECT title, concat(first_name, last_name) AS "Nombre y Apellido" FROM episodes
INNER JOIN actor_episode ON episodes.id = episode_id
INNER JOIN actors ON actors.id = actor_id;

/*Para nuestro próximo desafío, necesitamos obtener a todos los actores o
actrices (mostrar nombre y apellido) que han trabajado en cualquier película
de la saga de La Guerra de las galaxias.*/

SELECT concat(first_name, last_name) AS "Nombre y Apellido", title FROM actors
INNER JOIN actor_movie ON actors.id	 = actor_id
INNER JOIN movies ON movies.id = movie_id
WHERE title LIKE "La Guerra de las galaxias%";

/*Crear un listado a partir de la tabla de películas, mostrar un reporte de la
cantidad de películas por nombre de género.*/

SELECT name AS Genero, count(*) AS "Cantidad de Peliculas" FROM movies
INNER JOIN genres ON genre_id =genres.id
GROUP BY genre_id;