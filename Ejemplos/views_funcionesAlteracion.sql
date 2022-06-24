/*
Crear una vista con los siguientes datos de los clientes: ID, contacto, y el
Fax. En caso de que no tenga Fax, colocar el teléfono, pero aclarándolo. Por
ejemplo: “TEL: (01) 123-4567”.
*/

CREATE VIEW vistaclientes AS
SELECT ClienteID, 
Contacto,
CASE
	WHEN Fax = "" THEN concat("TEL: ", Telefono)
    ELSE Fax
END AS FaxTel
FROM clientes;

/*
Se necesita listar los números de teléfono de los clientes que no tengan
fax. Hacerlo de dos formas distintas:
a. Consultando la tabla de clientes.
b. Consultando la vista de clientes.
*/

SELECT Telefono, ClienteID FROM clientes
WHERE Fax = "";

SELECT * FROM vistaclientes
WHERE FaxTel LIKE "TEL:%";


/*
Crear una vista con los siguientes datos de los proveedores: ID,
contacto, compañía y dirección. Para la dirección tomar la dirección,
ciudad, código postal y país.
*/

CREATE VIEW proveedoresdireccion AS
SELECT ProveedorID, Contacto, Compania, 
concat(Direccion, Ciudad, CodigoPostal, Pais) AS Direccion
FROM proveedores;

/*
Listar los proveedores que vivan en la calle Americanas en Brasil. Hacerlo
de dos formas distintas:
a. Consultando la tabla de proveedores.
b. Consultando la vista de proveedores.
*/

SELECT * FROM proveedores
WHERE Direccion LIKE "%Americanas%" AND Pais = "Brazil";

SELECT * FROM proveedoresdireccion
WHERE Direccion LIKE "%Americanas%Brazil%";

/*
Crear una vista de productos que se usará para control de stock. Incluir el ID
y nombre del producto, el precio unitario redondeado sin decimales, las
unidades en stock y las unidades pedidas. Incluir además una nueva
columna PRIORIDAD con los siguientes valores:
■ BAJA: si las unidades pedidas son cero.
■ MEDIA: si las unidades pedidas son menores que las unidades
en stock.
■ URGENTE: si las unidades pedidas no duplican el número de
unidades.
■ SUPER URGENTE: si las unidades pedidas duplican el número
de unidades en caso contrario.
*/

CREATE VIEW prioridadProducto AS 
SELECT ProductoID, ProductoNombre, round(PrecioUnitario) AS PrecioUnit,
UnidadesStock, UnidadesPedidas,
CASE
	WHEN UnidadesPedidas = 0 THEN "BAJA"
    WHEN UnidadesPedidas < UnidadesStock THEN "MEDIA"
    WHEN UnidadesPedidas < UnidadesStock * 2 THEN "URGENTE"
    WHEN UnidadesPedidas >= UnidadesStock * 2 THEN "SUPER URGENTE"
END AS Prioridad
FROM productos;

/*
Se necesita un reporte de productos para identificar problemas de stock.
Para cada prioridad indicar cuántos productos hay y su precio promedio.
No incluir las prioridades para las que haya menos de 5 productos.
*/

SELECT Prioridad, count(ProductoID) AS CantProductosXPrioridad
FROM prioridadproducto
GROUP BY Prioridad
HAVING CantProductosXPrioridad >= 5;
