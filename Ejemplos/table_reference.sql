/*En el salón de Musimundos tenemos un cliente fanático de Willie Dixon, 
quiere comprar toda la colección de sus temas, pero NO le interesan los temas que sean de su etapa en el rock.
Hagamos una consulta en la base de datos donde muestre todos los registros 
que contengan canciones con sus géneros, Y que el compositor sea Willie Dixon, Y que tengan el género Blues.*/



SELECT canciones.nombre, compositor, generos.nombre 
FROM canciones, generos
WHERE compositor = "Willie Dixon" 
AND generos.nombre = "Blues"
AND generos.id = id_genero;
