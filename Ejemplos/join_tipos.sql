#Obtener los artistas que han actuado en una o más películas.

SELECT count(P.ID) AS CantPeliculas, concat(A.Nombre, A.apellido) AS Artista FROM artista A
INNER JOIN artista_x_pelicula AP ON A.id = AP.artista_id
INNER JOIN pelicula P ON P.id = AP.pelicula_id
GROUP BY A.nombre, A.apellido
HAVING CantPeliculas >= 1;

#Obtener las películas donde han participado más de un artista según nuestra
#base de datos.

SELECT P.titulo, COUNT(AP.artista_id) AS CantArtistas FROM pelicula P
INNER JOIN artista_x_pelicula AP ON P.id = AP.pelicula_id
GROUP BY P.titulo;

/*Obtener aquellos artistas que han actuado en alguna película, incluso
aquellos que aún no lo han hecho, según nuestra base de datos.*/

SELECT DISTINCT concat(A.Nombre," ", A.apellido) AS Artista FROM artista A
LEFT JOIN artista_x_pelicula AP ON A.id = AP.artista_id;

/*Obtener las películas que no se le han asignado artistas en nuestra base de
datos.*/

SELECT P.titulo FROM pelicula P
LEFT JOIN artista_x_pelicula AP ON P.ID = AP.pelicula_id
WHERE AP.artista_id IS NULL;

/*Obtener aquellos artistas que no han actuado en alguna película, según
nuestra base de datos.*/

SELECT * FROM artista A
LEFT JOIN artista_x_pelicula AP ON A.id = AP.artista_id
WHERE AP.artista_id IS NULL;

/*Obtener aquellos artistas que han actuado en dos o más películas según
nuestra base de datos.*/

SELECT COUNT(AP.pelicula_id) AS CANTPELICULAS, concat(A.Nombre," ", A.apellido) AS Artista FROM artista A
INNER JOIN  artista_x_pelicula AP ON A.ID = AP.artista_id
GROUP BY A.nombre, A.apellido
HAVING CANTPELICULAS >= 2;

/*Obtener aquellas películas que tengan asignado uno o más artistas, incluso
aquellas que aún no le han asignado un artista en nuestra base de datos.*/

SELECT * FROM pelicula;



