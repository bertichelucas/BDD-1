/*
Crear una vista para poder organizar los envíos de las facturas. Indicar número
de factura, fecha de la factura y fecha de envío, ambas en formato dd/mm/yyyy,
valor del transporte formateado con dos decimales, y la información del
domicilio del destino incluyendo dirección, ciudad, código postal y país, en una
columna llamada Destino.
*/

CREATE VIEW enviosFacturas AS
SELECT FacturaID AS NroFactura,
date_format(FechaFactura, "%d%m%y") AS FechaFactura,
date_format(FechaEnvio, "%d%m%y") AS FechaEnvio,
TRUNCATE(Transporte, 2) AS ValorTransporte,
concat(DireccionEnvio, CiudadEnvio, CodigoPostalEnvio, PaisEnvio) AS Destino
FROM facturas;

/*
Realizar una consulta con todos los correos y el detalle de las facturas que
usaron ese correo. Utilizar la vista creada.
*/

SELECT E.*, C.* FROM enviosfacturas E 
INNER JOIN facturas F ON E.NroFactura = F.FacturaID
INNER JOIN correos C ON C.CorreoID = F.EnvioVia;

/*
Crear una vista con un detalle de los productos en stock. Indicar id, nombre del
producto, nombre de la categoría y precio unitario.
*/

CREATE VIEW detallesProductosCategoria AS
SELECT P.ProductoID AS ID,
P.ProductoNombre AS NombreProducto,
C.CategoriaNombre AS NombreCategoria,
p.PrecioUnitario AS PrecioUnitario
FROM productos P
INNER JOIN categorias C ON C.CategoriaID = P.CategoriaID;

/*
Escribir una consulta que liste el nombre y la categoría de todos los productos
vendidos. Utilizar la vista creada.
*/

SELECT NombreProducto, NombreCategoria
FROM detallesproductoscategoria
INNER JOIN facturadetalle F ON ID = F.ProductoID;





