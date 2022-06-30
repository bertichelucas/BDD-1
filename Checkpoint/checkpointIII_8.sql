/*
Camada 0522TDBD1N1C8LAED0222PT
Numero de Grupo 8
Integrantes:
Cesar Sanchez
Lucas Jimenez
Brandon Sarasty
Lucas Bertiche
*/


/*
1. Listar todas las reservas de hoteles realizadas en la ciudad de Nápoles.
*/

SELECT HR.*
FROM hotelesxreserva HR
INNER JOIN hoteles H ON H.idhotel = HR.idHotel
WHERE H.ciudad = "Napoles";

#devuelve 6

/*
2. Listar el número de pago (idpago), el precio, la cantidad de cuotas de todas las
reservas realizadas con tarjeta de crédito.
*/

SELECT P.idpago AS NroPago, P.precioTotal, P.cantidadCuotas
FROM reservas R
INNER JOIN pagos P ON P.idpago = R.idreserva
INNER JOIN metodospago MP ON MP.idmetodospago = P.idMetodosPago
WHERE MP.nombre = "Tarjeta de Credito";

#devuelve 19

/*
3. Listar la cantidad de reservas realizadas de acuerdo al método de pago.
*/

SELECT COUNT(R.idreserva) AS CantReservas, P.idMetodosPago
FROM reservas R
INNER JOIN pagos P ON R.idpago = P.idpago
GROUP BY P.idMetodosPago;

#devuelve 3

/*
4. Listar las reservas de los clientes cuyo pago lo hicieron a través de tarjeta de
crédito, se pide mostrar el nombre, apellido, país y el método de pago.
*/

SELECT C.nombres, C.apellidos, PAI.nombre AS Pais, MP.nombre AS MetodoPago
FROM reservas R
INNER JOIN clientes C ON C.idcliente = R.idcliente
INNER JOIN paises PAI ON PAI.idPais = C.idPais
INNER JOIN pagos P ON P.idpago = R.idPago
INNER JOIN metodospago MP ON MP.idmetodospago = P.idmetodospago
WHERE  MP.nombre = "Tarjeta de Credito";

#devuelve 19

/*
5. Listar la cantidad de reservas de hoteles por país, se necesita mostrar el nombre
del país y la cantidad.
*/

SELECT P.nombre AS Pais, COUNT(HR.idhotelesxreserva) AS "Cant Reservas de hoteles"
FROM hotelesxreserva HR 
INNER JOIN hoteles H ON H.idhotel = HR.idhotel
INNER JOIN paises P ON P.idpais = H.idPais
GROUP BY P.nombre;

#devuelve 8

/*
6. Listar el nombre, apellido, número de pasaporte,ciudad y nombre del país de los
clientes de origen Peruano.
*/

select c.nombres, c.apellidos, c.numeroPasaporte, c.ciudad, p.nombre as pais
from clientes c 
inner join paises p on p.idpais = c.idPais
where p.nombre = "Peru";

#devuelve 5

/*
7. Listar la cantidad de reservas realizadas de acuerdo al método de pago y el
nombre completo del cliente.
*/

SELECT count(R.idreserva) AS CantReservas,
MP.nombre AS MetodoPago, concat(C.nombres, C.apellidos) AS NombreCompleto
FROM reservas R
INNER JOIN pagos P ON R.idpago = P.idpago
INNER JOIN metodospago MP ON MP.idmetodospago = P.idmetodospago
INNER JOIN clientes C ON C.idcliente = R.idCliente
GROUP BY MP.nombre, NombreCompleto;

#devuelve 51

/*
8. Mostrar la cantidad de clientes por país, se necesita visualizar el nombre del
país y la cantidad de clientes.
*/

SELECT COUNT(C.idcliente) AS CantClientes,
P.nombre AS Pais
FROM clientes C 
INNER JOIN paises P ON P.idPais = C.idPais
GROUP BY P.nombre;

#devuelve 11

/*
9. Listar todas las reservas de hotel, se pide mostrar el nombre del hotel,dirección,
ciudad, el país, el tipo de pensión y que tengan como tipo de hospedaje 'Media
pensión'.
*/

select r.idreserva, h.nombre, h.direccion, h.ciudad, p.nombre as pais, th.nombre as tipoHospedaje from reservas r
inner join hotelesxreserva hr on hr.idreserva = r.idreserva
inner join hoteles h on h.idhotel = hr.idhotel
inner join paises p on p.idpais = h.idPais
inner join tiposhospedaje th on th.idtiposhospedaje = hr.idTiposHospedaje
where th.nombre = "Media Pension";

#devuelve 22

/*
10. Mostrar por cada método de pago el monto total obtenido,se pide visualizar el
nombre del método de pago y el total.
*/

select mp.nombre as metodoPago, sum(p.precioTotal) as totalObtenido from metodospago as mp
inner join pagos p on p.idMetodosPago = mp.idmetodospago
group by mp.nombre;

#devuelve 3

/*
11. Mostrar la suma de los pagos realizados en la sucursal de Mendoza, llamar al
resultado “TOTAL MENDOZA”.
*/

SELECT sum(P.precioTotal) AS "TOTAL MENDOZA", S.ciudad
FROM sucursales S
INNER JOIN reservas R ON R.idSucursal = S.idSucursal
INNER JOIN pagos P ON P.idpago = R.idPago
GROUP BY S.ciudad
HAVING S.ciudad = "Mendoza";

#devuelve 1

#12. Listar todos los clientes que no han realizado reservas.

SELECT C.*
FROM clientes C
LEFT JOIN reservas R ON R.idCliente = C.idcliente
WHERE R.idreserva IS NULL;

#devuelve 34

/*
13. Listar todas las reservas de vuelos realizadas donde el origen sea Chile y el
destino Ecuador, mostrar el id Reserva, id Vuelo, fecha de partida, fecha de
llegada, fecha de la reserva.
*/

SELECT R.idreserva, V.idvuelo, V.fechaPartida, V.fechaLlegada, R.fechaRegistro, V.origen, V.destino
FROM reservas R
INNER JOIN vuelosxreserva VR ON VR.idReserva = R.idreserva
INNER JOIN vuelos V ON V.idvuelo = VR.idVuelo
WHERE V.origen = "Chile" AND V.destino = "Ecuador";

#devuelve 3

/*
14. Listar el nombre y cantidad de habitaciones de aquellos hoteles que tengan de
30 a 70 habitaciones pertenecientes al país Argentina.
*/

SELECT H.nombre, H.cantidadHabitaciones
FROM hoteles H
INNER JOIN paises P ON P.idpais = H.idPais
WHERE P.nombre = "Argentina" AND H.cantidadHabitaciones BETWEEN 30 AND 70;

#devuelve 3

/*
15. Listar el top 10 de hoteles más utilizados y la cantidad de reservas en las que ha
sido reservado.
*/

SELECT H.nombre, count(HR.idReserva) AS CantReservas
FROM hoteles H
INNER JOIN hotelesxreserva HR ON H.idhotel = HR.idHotel
GROUP BY H.nombre
ORDER BY CantReservas DESC
LIMIT 10;

#devuelve 10

/*
16.Listar los clientes (nombre y apellido) y cuáles han sido los medios de pago que
han utilizado, esta lista deberá estar ordenada por apellidos de manera
ascendente.
*/

select c.nombres, c.apellidos, mp.nombre as Medio_Pago from clientes c 
inner join reservas r on r.idcliente = c.idcliente
inner join pagos p on p.idpago = r.idPago
inner join metodospago mp on mp.idmetodospago = p.idMetodosPago order by c.apellidos asc;

#devuelve 62

/*
17. Listar la cantidad de reservas que se realizaron para los vuelos que el origen ha
sido de Argentina o Colombia, en el horario de las 18hs. Mostrar la cantidad de
vuelos y país de origen.
*/

select count(*) as Cantidad_vuelos, v.origen from vuelosxreserva vr 
inner join vuelos v on v.idVuelo = vr.idVuelo
where (v.origen = "Argentina" or v.origen = "Colombia") and extract(hour from(v.fechaPartida)) = 18 
group by v.origen;

#devuelve 1

/*
18. Mostrar los totales de ventas de sucursales por países y ordenarlas de mayor a
menor.
*/

select pai.nombre as Pais, sum(p.precioTotal) AS TotalDeVenta from reservas r
inner join pagos p on p.idpago = r.idpago 
inner join sucursales s on s.idSucursal = r.idSucursal
inner join paises pai on pai.idpais = s.idPais
group by pai.nombre;

#devuelve 2

/*
19. Mostrar los países que no tienen clientes asignados ordenados por los que
empiezan por Z primero.
*/

SELECT P.nombre AS Pais
FROM paises P
LEFT JOIN clientes C ON P.idpais = C.idPais
WHERE C.idcliente IS NULL
ORDER BY P.nombre DESC;

#devuelve 19

/*
20. Generar un listado con los hoteles que tuvieron más de 2 reservas realizadas.
Mostrar el nombre del hotel y la cantidad.
*/

select h.nombre, count(hr.idhotelesxreserva) as CantidadDeReservas from hoteles h
inner join hotelesxreserva hr on h.idhotel = hr.idHotel
group by h.nombre
having CantidadDeReservas > 2;

#devuelve  4


