/*
Empleados
a) Crear un SP que liste los apellidos y nombres de los empleados ordenados
alfabéticamente.
b) Invocar el SP para verificar el resultado.
*/

DELIMITER $$
CREATE PROCEDURE ordenar_empleados_nombre_apellido()
BEGIN
SELECT Nombre, Apellido FROM empleados
ORDER BY Nombre, Apellido;
END $$

CALL ordenar_empleados_nombre_apellido();

/*
Empleados por ciudad
a) Crear un SP que reciba el nombre de una ciudad y liste los empleados de esa
ciudad.
b) Invocar al SP para listar los empleados de Seattle.
*/

DELIMITER $$
CREATE PROCEDURE ordenar_empleados_ciudad(IN pi_ciudad VARCHAR(15))
BEGIN
SELECT Nombre, Apellido, Ciudad FROM empleados
WHERE Ciudad = pi_ciudad
ORDER BY Nombre, Apellido;
END $$

CALL ordenar_empleados_ciudad("London");

/*
Clientes por país
a) Crear un SP que reciba el nombre de un país y devuelva la cantidad de clientes
en ese país.
b) Invocar el SP para consultar la cantidad de clientes en Portugal.
*/

drop procedure sp_cant_clientes_pais;

DELIMITER $$
CREATE PROCEDURE sp_cant_clientes_pais (IN pi_pais VARCHAR(15), OUT po_cant_clientes INT)
BEGIN

SELECT count(ClienteID) INTO po_cant_clientes FROM clientes
WHERE Pais = "Germany"
GROUP BY Pais;
END $$

CALL sp_cant_clientes_pais("Germany", @cant);
SELECT @cant;

/*
Productos sin stock
a) Crear un SP que reciba un número y liste los productos cuyo stock está por
debajo de ese número. El resultado debe mostrar el nombre del producto, el
stock actual y el nombre de la categoría a la que pertenece el producto.
b) Listar los productos con menos de 10 unidades en stock.
c) Listar los productos sin stock.
*/

DELIMITER $$
CREATE PROCEDURE sp_productos_bajo_stock(IN numero INT)
BEGIN
SELECT p.ProductoNombre, p.UnidadesStock, c.CategoriaNombre FROM productos p
INNER JOIN categorias c on p.CategoriaID = c.CategoriaID
WHERE p.UnidadesStock < numero;
END $$

CALL sp_productos_bajo_stock(15);

/*
Ventas con descuento
a) Crear un SP que reciba un porcentaje y liste los nombres de los productos que
hayan sido vendidos con un descuento igual o superior al valor indicado,
indicando además el nombre del cliente al que se lo vendió.
b) Listar la información de los productos que hayan sido vendidos con un
descuento mayor al 10%.
*/

DROP PROCEDURE sp_descuento_productos_clientes;

DELIMITER $$
CREATE PROCEDURE sp_descuento_productos_clientes(IN porcentaje DOUBLE)
BEGIN
SELECT p.ProductoNombre, fd.Descuento, c.Titulo FROM productos p
INNER JOIN facturadetalle fd on fd.ProductoID = p.ProductoID
INNER JOIN facturas f on f.FacturaID = fd.FacturaID
INNER JOIN clientes c on c.ClienteID = f.ClienteID
WHERE fd.Descuento >= porcentaje;
END $$

CALL sp_descuento_productos_clientes(0.10);

