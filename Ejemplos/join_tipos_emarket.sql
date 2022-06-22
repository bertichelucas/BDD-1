/** Unir todos los datos **/

SELECT F.FacturaID AS IDFactura, 
F.FechaFactura AS FechaFactura,
C.Compania AS NombreCompaniaCorreo,
CL.Titulo AS TituloCliente,
CA.CategoriaNombre AS CategoriaNombre,
P.ProductoNombre AS NombreProducto,
FD.PrecioUnitario AS PrecioUnitario,
FD.Cantidad AS Cantidad
FROM facturas F
INNER JOIN correos C ON C.CorreoID = F.EnvioVia
INNER JOIN clientes CL ON CL.ClienteID = F.ClienteID
INNER JOIN facturadetalle FD ON FD.FacturaID  = F.FacturaID
INNER JOIN productos P ON P.ProductoID = FD.ProductoID
INNER JOIN categorias CA ON CA.CategoriaID = P.CategoriaID;


/*1. Listar todas las categorías junto con información de sus productos. Incluir todas
las categorías aunque no tengan productos.*/

SELECT C.CategoriaNombre, P.* FROM categorias C
LEFT JOIN productos P ON C.CategoriaID = P.CategoriaID;


/*2. Listar la información de contacto de los clientes que no hayan comprado nunca
en emarket.*/

SELECT C.* FROM clientes C
LEFT JOIN facturas F ON C.ClienteID = F.ClienteID
WHERE F.FacturaID IS NULL;

/*
3. Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y
la información de contacto de su proveedor. Tener en cuenta que puede haber
productos para los cuales no se indicó quién es el proveedor.
*/

SELECT P.ProductoNombre, C.CategoriaNombre, PROV.* FROM productos P
INNER JOIN categorias C ON P.CategoriaID = C.CategoriaID
LEFT JOIN proveedores PROV ON PROV.ProveedorID = P.ProveedorID;

#4. Para cada categoría listar el promedio del precio unitario de sus productos.

SELECT C.CategoriaNombre, avg(P.PrecioUnitario) AS PromedioPrecio FROM productos P
INNER JOIN categorias C ON C.CategoriaID = P.CategoriaID
GROUP BY C.CategoriaID;

/*
5. Para cada cliente, indicar la última factura de compra. Incluir a los clientes que
nunca hayan comprado en e-market.
*/

SELECT C.Compania AS Cliente, max(f.FechaFactura)  FROM clientes C
LEFT JOIN facturas F ON C.ClienteID = F.ClienteID
GROUP BY Cliente;

/*
6. Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un
listado con todas las empresas de correo, y la cantidad de facturas
correspondientes. Realizar la consulta utilizando RIGHT JOIN.
*/

SELECT COUNT(F.FacturaID), CO.Compania AS Compania FROM facturas F
RIGHT JOIN correos CO on F.EnvioVia = CO.CorreoID
GROUP BY Compania;