/*
Mostrar el nombre, precio y color de los accesorios para asientos de las bicicletas
cuyo precio sea mayor a 100 pesos
Tablas: Production.Product
Campos: Name, ListPrice, Color
*/

SELECT P.Name AS Nombre,
P.ListPrice AS Precio,
p.Color AS Color 
FROM product P
INNER JOIN productcategory AS PC ON PC.ProductCategoryID = P.ProductSubcategoryID
WHERE P.ListPrice > 100;

/*
Mostrar los empleados que tienen más de 90 horas de vacaciones
Tablas: Employee
Campos: VacationHours, BusinessEntityID
*/

SELECT * FROM employee E
WHERE E.VacationHours >= 90;

/*
Mostrar el nombre, precio y precio con iva de los productos con precio distinto de
cero
Tablas: Product
Campos: Name, ListPrice
*/

SELECT P.Name AS Nombre,
P.ListPrice AS Precio
FROM product P
WHERE P.ListPrice != 0;

/*
Mostrar precio y nombre de los productos 776, 777, 778
Tablas: Product
Campos: ProductID, Name, ListPrice
*/

SELECT P.ListPrice AS Precio,
P.Name AS Nombre,
P.ProductID AS ID
FROM product P
WHERE P.ProductID BETWEEN 776 AND 778;

/*
Mostrar las personas ordenadas primero por su apellido y luego por su nombre
Tablas: Contact
Campos: Firstname, Lastname
*/

SELECT C.FirstName AS Nombre,
C.LastName AS Apellido
FROM contact C
ORDER BY C.LastName, C.FirstName;

/*
Mostrar la cantidad y el total vendido por productos
Tablas: SalesOrderDetail
Campos: LineTotal
*/

SELECT S.ProductID AS Producto,
count(S.SalesOrderDetailID) AS Cantidad,
sum(S.LineTotal) AS Total
FROM salesorderdetail S
GROUP BY S.ProductID;


/*
Mostrar el código de subcategoría y el precio del producto más barato de cada una
de ellas
Tablas: Product
Campos: ProductSubcategoryID, ListPrice
*/

SELECT P.ProductSubcategoryID AS Categoria,
min(P.ListPrice) AS PrecioDelProductoMasBaratoXCategoria
FROM product P
GROUP BY P.ProductSubcategoryID;

/*
Mostrar todas las facturas realizadas y el total facturado de cada una de ellas
ordenado por número de factura pero sólo de aquellas órdenes superen un total de
$10.000
Tablas: SalesOrderDetail
Campos: SalesOrderID, LineTotal
*/

SELECT S.SalesOrderID AS Factura,
sum(S.LineTotal) AS Total
FROM salesorderdetail S
GROUP BY S.SalesOrderID
HAVING Total > 10000;

/*
Mostrar los empleados que también son vendedores
Tablas: Employee, SalesPerson
Campos: BusinessEntityID
*/

SELECT *
FROM employee E
INNER JOIN salesperson SP ON E.EmployeeID = SP.SalesPersonID;

/*
Mostrar los empleados ordenados alfabéticamente por apellido y por nombre
Tablas: Employee, Contact
Campos: BusinessEntityID, LastName, FirstName
*/

SELECT E.EmployeeID AS IDEmpleado,
C.LastName AS Apellido,
C.FirstName AS Nombre
FROM employee E
INNER JOIN contact C ON C.ContactID = E.ContactID
ORDER BY C.LastName, C.FirstName;






