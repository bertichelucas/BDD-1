#######################GROUP BY###############################
/*** CLIENTES ***/
#¿Cuántos clientes existen?

SELECT count(ClienteID) AS CantidadClientes FROM clientes;

#Cuantos clientes hay por ciudad

SELECT count(ClienteID) AS Clientes , ciudad
FROM clientes
GROUP BY Ciudad;

/*** FACTURAS ***/

#¿Cuál es el total de transporte?

SELECT sum(Transporte) FROM facturas;

#¿Cuál es el total de transporte por EnvioVia (empresa de envío)?

SELECT sum(Transporte), EnvioVia FROM facturas
GROUP BY EnvioVia;

#Calcular la cantidad de facturas por cliente. Ordenar descendentemente por
#cantidad de facturas.

SELECT ClienteID AS IDCliente, count(FacturaID) AS CantFacturas FROM facturas
GROUP BY ClienteID
ORDER BY CantFacturas DESC;

#Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.

SELECT ClienteID AS IDCliente, count(FacturaID) AS CantFacturas FROM facturas
GROUP BY ClienteID
ORDER BY CantFacturas DESC
LIMIT 5;

#¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?

SELECT  count(FacturaID)  AS CantFacturas, PaisEnvio FROM facturas
GROUP BY PaisEnvio
ORDER BY CantFacturas
LIMIT 1;

/*Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado
realizó más operaciones de ventas?*/

SELECT EmpleadoID, count(FacturaID) AS CantVentas FROM facturas
GROUP BY EmpleadoID
ORDER BY CantVentas DESC
LIMIT 1;

/*** FACTURA DETALLE ***/

#¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?

SELECT count(FacturaID) AS CantApariciones, ProductoID FROM facturadetalle
GROUP BY ProductoID
ORDER BY CantApariciones DESC
LIMIT 1;

/*¿Cuál es el total facturado? Considerar que el total facturado es la suma de
cantidad por precio unitario.*/

SELECT sum(Cantidad * PrecioUnitario) AS TotalFacturado
FROM facturadetalle;

#¿Cuál es el total facturado para los productos ID entre 30 y 50?

SELECT sum(Cantidad * PrecioUnitario) AS TotalFacturado
FROM facturadetalle
WHERE ProductoID BETWEEN 30 AND 50;

#¿Cuál es el precio unitario promedio de cada producto?

SELECT avg(PrecioUnitario) AS Promedio, ProductoID FROM facturadetalle
GROUP BY ProductoID;

#¿Cuál es el precio unitario máximo?

SELECT MAX(PrecioUnitario) AS MaxPrecioUnitario
FROM facturadetalle;

#######################JOIN###############################

#Generar un listado de todas las facturas del empleado 'Buchanan'.

SELECT * FROM facturas F
INNER JOIN empleados E ON E.EmpleadoID = F.EmpleadoID
WHERE E.Apellido = "Buchanan";

/*Generar un listado con todos los campos de las facturas del correo 'Speedy
Express'.*/

SELECT * FROM facturas F
INNER JOIN correos C ON C.CorreoID = F.EnvioVia
WHERE Compania = "Speedy Express";

/*Generar un listado de todas las facturas con el nombre y apellido de los
empleados.*/

SELECT F.FacturaID AS NroFactura, E.Nombre, E.Apellido FROM facturas F
INNER JOIN empleados E ON E.EmpleadoID = F.EmpleadoID;

/*Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío
“USA”.*/

SELECT * FROM facturas F
INNER JOIN clientes C ON C.ClienteID = F.ClienteID
WHERE C.Titulo = "Owner" AND  F.PaisEnvio = "USA";

/*Mostrar todos los campos de las facturas del empleado cuyo apellido sea
“Leverling” o que incluyan el producto id = “42”.*/

SELECT F.* FROM facturas F
INNER JOIN empleados E ON E.EmpleadoID = F.EmpleadoID
INNER JOIN facturadetalle FD ON F.FacturaID = FD.FacturaID
WHERE E.Apellido = "Leverling" OR FD.ProductoID = "42";

/*Mostrar todos los campos de las facturas del empleado cuyo apellido sea
“Leverling” y que incluya los producto id = “80” o ”42”.*/

SELECT F.* FROM facturas F
INNER JOIN empleados E ON E.EmpleadoID = F.EmpleadoID
INNER JOIN facturadetalle FD ON F.FacturaID = FD.FacturaID
WHERE E.Apellido = "Leverling" AND FD.ProductoID IN (42, 80);

/*Generar un listado con los cinco mejores clientes, según sus importes de
compras total (PrecioUnitario * Cantidad).*/

SELECT C.ClienteID AS Cliente, SUM(FD.PrecioUnitario * FD.Cantidad) AS ImporteTotalDeCompras FROM clientes C
INNER JOIN facturas F ON F.ClienteID = C.ClienteID
INNER JOIN facturadetalle FD ON F.FacturaID = FD.FacturaID
GROUP BY CLIENTE
ORDER BY ImporteTotalDeCompras DESC
LIMIT 5;

/*Generar un listado de facturas, con los campos id, nombre y apellido del cliente,
fecha de factura, país de envío, Total, ordenado de manera descendente por
fecha de factura y limitado a 10 filas.*/

SELECT F.FechaFactura, F.PaisEnvio, F.ClienteID, sum(FD.PrecioUnitario * FD.Cantidad) AS Total FROM facturas F
INNER JOIN facturadetalle FD ON F.FacturaID = FD.FacturaID
GROUP BY F.FechaFactura, F.PaisEnvio, F.ClienteID
ORDER BY F.FechaFactura DESC
LIMIT 10;

#Cliente no tiene nombre ni apellido...
