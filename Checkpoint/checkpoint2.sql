/*** CHECKPOINT 2 ***/

/*
1. Listar todos los clientes que su apellido empiece por A, ordenados por apellido
de manera ascendente.
*/

SELECT * FROM clientes
WHERE apellidos LIKE "A%"
ORDER BY apellidos;

/*
2. Listar nombre, apellido,dirección de aquellos clientes que en su dirección
contengan la palabra “martin”.
*/

SELECT nombres, apellidos, direccion FROM clientes
WHERE direccion LIKE "%martin%";

/*
3. Listar todos los hoteles que tengan de 30 a 60 habitaciones.
*/

SELECT * FROM hoteles
WHERE cantidadHabitaciones BETWEEN 30 AND 60;

/*
4. Mostrar cuál ha sido el mayor importe facturado y llamarlo “Precio Mayor”,
también mostrar cuál es el total facturado y llamarlo “TOTAL”.
*/

SELECT max(precioTotal) AS "Precio Mayor", sum(precioTotal) AS "TOTAL" FROM pagos;

/*
5. Listar las reservas que fueron realizadas el día 16/01/2022 entre las 15hs y las
21hs pertenecientes a la sucursal número 5.
*/

SELECT * FROM reservas
WHERE fechaRegistro BETWEEN "2022-01-16 15:00:00" AND "2022-01-16 21:00:00"
AND idSucursal =5;

/*
6. Mostrar el top 3 de reservas con mayor cantidad de vuelos.
*/

SELECT idReserva, COUNT(idvuelosxreserva) AS CantVuelos FROM vuelosxreserva
GROUP BY idReserva
ORDER BY  CantVuelos DESC
LIMIT 3;

/*
7. Listar los 10 pagos de menor precio.
*/

SELECT * FROM pagos
ORDER BY precioTotal
LIMIT 10;

/*
8. Listar todos los países ordenados alfabéticamente y con su nombre en
mayúsculas.
*/

SELECT idpais, upper(nombre) AS Nombre FROM paises
ORDER BY Nombre;

/*
9. Mostrar todos las reservas de vuelos que sean de clase turista y el id de vuelo
sea 11 o 13. 1P 2T
*/

SELECT * FROM vuelosxreserva 
WHERE idCategoriasVuelos = 2 
AND idVuelo IN(11, 13); 

/*
10. Listar los usuarios que hayan realizado 2 reservas.
*/

SELECT idCliente, COUNT(idreserva) AS TotalReservas FROM reservas
GROUP BY idCliente
HAVING TotalReservas = 2;

/*
11. Mostrar todos los vuelos que tengan como origen Italia o destino Jamaica.
*/

SELECT * FROM vuelos
WHERE origen = "Italia" OR destino = "Jamaica";

/*
12. Mostrar todos los vuelos que tengan como destino Cuba y la cantidad de
pasajeros de primera clase sea menor o igual a 15 personas.
*/

SELECT * FROM vuelos
WHERE destino = "Cuba" AND cantidadPrimeraClase <= 15;

/*
13. Se desea conocer cuál es la cantidad de vuelos que tienen como origen México
*/

SELECT * FROM vuelos
WHERE origen= "México";

/*
14. Se desea conocer cuál es la cantidad de reservas realizadas en la sucursal de
Mendoza por el cliente cuyo pasaporte es EC158846.
*/

SELECT COUNT(reservas.idreserva) AS CantReservas , reservas.idSucursal, reservas.idCliente FROM reservas
INNER JOIN sucursales ON reservas.idSucursal = sucursales.idSucursal
INNER JOIN clientes ON reservas.idcliente = clientes.idcliente
WHERE  sucursales.ciudad = "Mendoza" AND clientes.numeroPasaporte = "EC158846"
GROUP BY reservas.idSucursal, reservas.idCliente;

select * from sucursales;
select * from clientes where numeroPasaporte = "EC158846";

/*
15. Cual es el promedio de pasajeros de clase turista que tengan como destino
Jamaica.
Promedio de cuposTurista entre los vuelos con destino a jamaica?
O Cantidad de pasajeros que tienen un vuelo con destino a jamaica en clase turista?
*/
# CASO 1:

SELECT AVG(cantidadTurista) FROM vuelos
WHERE destino = "Jamaica";

# CASO 2: en este caso no hay ningun pasajero turista que tenga un vuelo a jamaica reservado.

SELECT COUNT(*) as CantPasajerosTuristasConDestinoAJamaica FROM reservas AS r
INNER JOIN vuelosxreserva ON r.idreserva = vuelosxreserva.idReserva
INNER JOIN vuelos AS v ON v.idvuelo = vuelosxreserva.idVuelo
INNER JOIN categoriasvuelos AS cat ON cat.idcategoriasvuelos = vuelosxreserva.idcategoriasvuelos
WHERE cat.nombre = "Turista" AND v.destino = "Jamaica"; 

select * from vuelos WHERE DESTINO = "Jamaica";

/*
16. Cual es el monto total de los pagos realizados en efectivo.(campo:preciototal ). E =1 
*/

SELECT SUM(precioTotal) FROM pagos
WHERE idMetodosPago =1;

/*
17. Mostrar el tercer importe de pagos realizado con menor valor.
*/

SELECT precioTotal FROM pagos
ORDER BY precioTotal
LIMIT 1
OFFSET 2;

/*
18. Se desea conocer la cantidad de reservas realizadas en Chile más
específicamente en el 'Santiago Hotel' . ID = 15
*/

SELECT idHotel, count(idhotelesxreserva)AS CantReservas FROM hotelesxreserva
GROUP BY idHotel
HAVING idHotel =15;

/*
19. Agregar al cliente Solari Carlos cuyo pasaporte es AR221422 , domiciliado en
calle Av.Libertad 451 de la ciudad de Córdoba-Argentina, teléfono móvil
+542645667714.
*/

INSERT INTO clientes VALUES(default, "Carlos", "Solari", "AR221422", "Av.Libertad 451", "Córdoba", "teléfono móvil", 1);

/*
20. Modificar el tipo de hospedaje de 'Pensión Completa' a 'Pensión Premium'
*/
UPDATE tiposhospedaje SET nombre="Pensión Premium"
WHERE  idtiposhospedaje = 2;

select * from tiposhospedaje
