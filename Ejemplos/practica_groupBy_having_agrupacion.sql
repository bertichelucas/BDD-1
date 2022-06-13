/*Conseguir el numero de clientes que son de brazil*/

SELECT pais, count(*) FROM clientes
GROUP BY pais
HAVING pais = "Brazil";

/*lista de cuantas canciones hay por género */

SELECT id_genero, count(*) FROM canciones
GROUP BY id_genero;

/*Es época de balances, y en Musimundos queremos saber 
cuánto dinero llevan gastados todos los clientes juntos en nuestra empresa. */

SELECT  sum(total) FROM facturas;

/* En el sitio web de Musimundos, queremos informar la duración promedio en milisegundos de cada álbum. 
Obtiene una lista de todos los álbumes y su duración (milisegundos) promedio.*/

SELECT AVG(milisegundos) FROM canciones
GROUP BY id_album;

/*En el equipo de desarrollo están mudando de servidor a nuestra aplicación, y quieren saber 
cuál es el peso (bytes) de cada archivo de canciones para 
buscar un servidor adecuado con capacidad suficiente. Hace una consulta a la base de datos 
para saber cuál es el archivo con menor peso en bytes.*/

SELECT MIN(bytes) FROM canciones;

/*En el salón de Musimundos, estamos ofreciendo un descuento para todos aquellos clientes que tengan un total de facturación mayor a 45. 
Hacé una consulta a la base de datos que nos traiga por id_cliente 
la suma total de sus facturas. Filtra aquellos que la suma del total sea &gt;45. ¿Cuál es la suma total del cliente con id = 6? */

SELECT  id_cliente, SUM(total) AS TOTAL FROM facturas
GROUP BY id_cliente
HAVING TOTAL > 45;




