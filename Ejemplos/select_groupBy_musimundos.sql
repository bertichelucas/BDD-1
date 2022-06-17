/*** SELECT Y GROUP BY ***/

#Listar las canciones cuya duración sea mayor a 2 minutos.

SELECT * FROM canciones
WHERE milisegundos > 120000;

#Listar las canciones cuyo nombre comience con una vocal.

SELECT * FROM canciones
WHERE substr(nombre, 1, 1) IN ("A", "E","I","O", "U");

/*Listar las canciones ordenadas por compositor en forma descendente.
Luego, por nombre en forma ascendente. Incluir únicamente aquellas
canciones que tengan compositor.*/

SELECT * FROM canciones
WHERE compositor != ""
ORDER BY compositor DESC;

SELECT * FROM canciones
WHERE compositor !=""
ORDER BY nombre;

/* Listar la cantidad de canciones de cada compositor.
Modificar la consulta para incluir únicamente los compositores que
tengan más de 10 canciones.*/

SELECT COUNT(id) AS CantCanciones, compositor FROM canciones
WHERE compositor != ""
GROUP BY compositor
HAVING CantCanciones > 10;

/*a) Listar el total facturado agrupado por ciudad.
b) Modificar el listado del punto (a) mostrando únicamente las ciudades
de Canadá.
c) Modificar el listado del punto (a) mostrando únicamente las ciudades
con una facturación mayor a 38.
d) Modificar el listado del punto (a) agrupando la facturación por país, y
luego por ciudad.*/

SELECT SUM(total) AS TotalPorCiudad, ciudad_de_facturacion FROM facturas
GROUP BY ciudad_de_facturacion;

SELECT SUM(total) AS TotalPorCiudad, ciudad_de_facturacion FROM facturas
WHERE pais_de_facturacion = "Canada"
GROUP BY ciudad_de_facturacion;

SELECT SUM(total) AS TotalPorCiudad, ciudad_de_facturacion FROM facturas
GROUP BY ciudad_de_facturacion
HAVING TotalPorCiudad > 38;

SELECT SUM(total) AS TotalPorCiudad, pais_de_facturacion, ciudad_de_facturacion FROM facturas
GROUP BY pais_de_facturacion, ciudad_de_facturacion;

/*a) Listar la duración mínima, máxima y promedio de las canciones.
b) Modificar el punto (a) mostrando la información agrupada por género.*/

SELECT MIN(milisegundos), MAX(milisegundos), AVG(milisegundos) FROM canciones;

SELECT MIN(C.milisegundos) AS MinDuracion, 
MAX(C.milisegundos) AS MaxDuracion, 
AVG(C.milisegundos) as Promedio, G.nombre as Genero FROM canciones C
INNER JOIN generos G ON G.id = C.id_genero
GROUP BY G.nombre;


