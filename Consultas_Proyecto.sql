/*  2. Muestra los nombres de todas las películas con una clasificación por
edades de ‘R.
*/

SELECT title , rating 
FROM film f
WHERE rating = 'R';

/* 3. Encuentra los nombres de los actores que tengan un “actor_id entre 30
y 40.
*/

SELECT "actor_id", CONCAT("first_name", ' ', "last_name") AS "Nombre_Completo"
FROM "actor" AS a
WHERE "actor_id" BETWEEN 30 AND 40;

/* 4. Obtén las películas cuyo idioma coincide con el idioma original.
*/

SELECT *
FROM "film"
WHERE "original_language_id" = "language_id";

-- El resultado no da coincidencias debido a que la BBDD solo aporta el valor 1 para language_id y valor null para orginal_language_id.

/* 5. dena las películas por duración de forma ascendente.
 */

SELECT *
FROM "film" AS f
ORDER BY "length" ASC;

/* 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen en su
apellido.
*/

SELECT CONCAT("first_name", ' ', "last_name") AS "Nombre_Completo"
FROM "actor" AS a
WHERE "last_name" LIKE '%ALLEN%';


/* 7. Encuentra la cantidad total de películas en cada clasificación de la tabla
“film y muestra la clasificación junto con el recuento. 
*/

SELECT "rating", COUNT(*) AS "total_peliculas"
FROM "film"
GROUP BY "rating";

/* 8. Encuentra el título de todas las películas que son PG-13 o tienen una
duración mayor a 3 horas en la tabla film */

SELECT "title", "rating", "length"
FROM "film" AS f
WHERE "rating" = 'PG-13' OR "length" > 180;

/* 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
 */

SELECT 
    ROUND(VAR_POP("replacement_cost"), 2) AS "varianza_replacement_cost",
    ROUND(STDDEV_POP("replacement_cost"), 2) AS "desviacion_estandar_replacement_cost"
FROM "film";

/* 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
 */

SELECT MAX("length") AS "Mayor_duracion", MIN("length") AS "Menor_Duracion"
FROM "film" AS f;

/* 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
*/

SELECT "amount"
FROM "payment" AS p
ORDER BY "payment_date" DESC
LIMIT 1 OFFSET 2;

/* 12. Encuentra el título de las películas en la tabla “film que no sean ni ‘NC-17' ni ‘G' en cuanto a su clasificación.
*/

SELECT "title", "rating"
FROM "film" AS f
WHERE "rating" NOT IN ('G', 'NC-17');

/* 13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.
*/

SELECT 
    "rating",
    ROUND(AVG("length"), 0) AS "Promedio_Duracion"
FROM "film" AS f
GROUP BY "rating";

/* 14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos.
*/

SELECT "title", "length"
FROM "film" AS f
WHERE "length" > 180;

/* 15. ¿Cuánto dinero ha generado en total la empresa?
 */

SELECT SUM("amount") AS "Ingresos_Totales"
FROM "payment" AS p;

/* 16. Muestra los 10 clientes con mayor valor de id.
*/

SELECT "customer_id"
FROM "customer" AS c
ORDER BY "customer_id" DESC
LIMIT 10;

/* 17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby'
*/

SELECT CONCAT(a."first_name", ' ', a."last_name") AS "Nombre_Completo"
FROM "actor" AS a
    JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
    JOIN "film" AS f ON fa."film_id" = f."film_id"
WHERE f."title" = 'EGG IGBY';

/* 18. Selecciona todos los nombres de las películas únicos 
 */

SELECT DISTINCT "title"
FROM "film" AS f;

/* 19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film.
*/

SELECT f."title"
FROM "film" AS f
    JOIN "film_category" AS fc ON f."film_id" = fc."film_id"
    JOIN "category" AS c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Comedy' AND f."length" > 180;

/* 20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.
*/

SELECT c."name", AVG(f."length") AS "Duracion_Promedio"
FROM "film" AS f
    JOIN "film_category" AS fc ON f."film_id" = fc."film_id"
    JOIN "category" AS c ON fc."category_id" = c."category_id"
GROUP BY c."name"
HAVING AVG(f."length") > 110
ORDER BY AVG(f."length") DESC;

/* 21. ¿Cuál es la media de duración del alquiler de las películas?
*/

SELECT AVG("rental_duration") AS "Duracion_Alquiler"
FROM "film" AS f;

/* 22. Crea una columna con el nombre y apellidos de todos los actores y
actrices.
*/

SELECT CONCAT("first_name", ' ', "last_name") AS "Nombre_Completo_Actores"
FROM "actor" AS a;

/* 23. Numeros de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.
*/

SELECT DATE("rental_date") AS "Dia_Alquiler", COUNT(*) AS "Cantidad_Alquiler"
FROM "rental" AS r
GROUP BY DATE("rental_date")
ORDER BY "Cantidad_Alquiler" DESC;

/* 24. Encuentra las películas con una duración superior al promedio.
*/

SELECT "title", "length"
FROM "film" AS f
WHERE "length" > (SELECT AVG("length") FROM "film" AS f2);

/* 25. Averigua el número de alquileres registrados por mes.
*/

SELECT EXTRACT(MONTH FROM "rental_date") AS "mes", COUNT(*) AS "cantidad_alquileres"
FROM "rental"
GROUP BY EXTRACT(MONTH FROM "rental_date")
ORDER BY "mes";

/* 26. Encuentra el promedio, la desviación estándar y varianza del total
pagado.
*/

SELECT 
    ROUND(AVG("amount"), 2) AS "Promedio",
    ROUND(STDDEV("amount"), 2) AS "Desviacion_Estandar",
    ROUND(VARIANCE("amount"), 2) AS "Varianza"
FROM "payment" AS p;

/* 27. ¿Qué películas se alquilan por encima del precio medio?
*/

SELECT "title", "rental_rate"
FROM "film" AS f
WHERE "rental_rate" > (SELECT AVG("rental_rate") FROM "film" AS f2);

/* 28. Muestra el id de los actores que hayan participado en más de 40
películas. */

SELECT "actor_id", 
       COUNT("film_id") AS "Cantidad_Peliculas"
FROM "film_actor" AS fa
GROUP BY "actor_id"
HAVING COUNT("film_id") > 40;

/* 29. Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible.
*/

SELECT f."title", 
       COUNT(i."inventory_id") - COUNT(r."rental_id") AS "cantidad_disponible"
FROM "film" AS f
LEFT JOIN "inventory" AS i ON f."film_id" = i."film_id"
LEFT JOIN "rental" AS r ON i."inventory_id" = r."inventory_id" AND r."return_date" IS NULL
GROUP BY f."title"
ORDER BY "cantidad_disponible" DESC;

/* 30. Obtener los actores y el número de películas en las que ha actuado.
 */

SELECT a."first_name", 
       a."last_name", 
       COUNT(fa."film_id") AS "cantidad_peliculas"
FROM "actor" AS a
JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
GROUP BY a."actor_id", a."first_name", a."last_name"
ORDER BY "cantidad_peliculas" DESC;

/* 31. Obtener todas las películas y mostrar los actores que han actuado en 
ellas, incluso si algunas películas no tienen actores asociados.
*/

SELECT f."title" AS "titulo_pelicula", 
       a."first_name" AS "nombre_actor", 
       a."last_name" AS "apellido_actor"
FROM "film" AS f
LEFT JOIN "film_actor" AS fa ON f."film_id" = fa."film_id"
LEFT JOIN "actor" AS a ON fa."actor_id" = a."actor_id"
ORDER BY f."title", a."last_name", a."first_name";

/* 32. Obtener todos los actores y mostrar las películas en las que han 
actuado, incluso si algunos actores no han actuado en ninguna película.
*/

SELECT a."first_name" AS "nombre_actor", 
       a."last_name" AS "apellido_actor", 
       f."title" AS "titulo_pelicula"
FROM "actor" AS a
LEFT JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
LEFT JOIN "film" AS f ON fa."film_id" = f."film_id"
ORDER BY a."last_name", a."first_name", f."title";

/* 33. Obtener todas las películas que tenemos y todos los registros de
alquiler.
*/

SELECT f."title" AS "titulo_pelicula", 
       r."rental_date" AS "fecha_alquiler", 
       r."return_date" AS "fecha_devolucion", 
       r."customer_id" AS "id_cliente"
FROM "film" AS f
LEFT JOIN "inventory" AS i ON f."film_id" = i."film_id"
LEFT JOIN "rental" AS r ON i."inventory_id" = r."inventory_id"
ORDER BY f."title", r."rental_date";

/* 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
 */

SELECT 
    c."customer_id", 
    c."first_name", 
    c."last_name", 
    SUM(p."amount") AS "total_gastado"
FROM "customer" AS c
JOIN "payment" AS p ON c."customer_id" = p."customer_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
ORDER BY "total_gastado" DESC
LIMIT 5;

/* 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
 */

SELECT a."first_name", 
       a."last_name"
FROM "actor" AS a
WHERE a."first_name" = 'JOHNNY';

/* 36. Renombra la columna “first_name como Nombre y “last_name como
Apellido.
*/

SELECT a."first_name" AS "Nombre", 
       a."last_name" AS "Apellido"
FROM "actor" AS a;

/* 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
 */

SELECT MAX(a."actor_id") AS "ID_Mas_Alto", 
       MIN(a."actor_id") AS "ID_Mas_Bajo"
FROM "actor" AS a;

/* 38. Cuenta cuántos actores hay en la tabla “actor".
 */

SELECT COUNT(*) AS "Total_Actores"
FROM "actor" AS a;

/* 39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente.
*/

SELECT a."first_name" AS "Nombre", 
       a."last_name" AS "Apellido"
FROM "actor" AS a
ORDER BY a."last_name" ASC;

/* 40. Selecciona las primeras 5 películas de la tabla “film".
 */

SELECT *
FROM "film" AS f
LIMIT 5;

/* 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?
*/

SELECT a."first_name" AS "Nombre", 
       COUNT(*) AS "Cantidad"
FROM "actor" AS a
GROUP BY a."first_name"
ORDER BY "Cantidad" DESC
LIMIT 1;

-- El nombre más repetido es PENELOPE

/* 42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.
*/

SELECT r."rental_id" AS "id_alquiler", 
       r."rental_date" AS "fecha_alquiler", 
       r."return_date" AS "fecha_devolucion", 
       c."first_name" AS "nombre_cliente", 
       c."last_name" AS "apellido_cliente"
FROM "rental" AS r
JOIN "customer" AS c ON r."customer_id" = c."customer_id"
ORDER BY r."rental_date";

/* 43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.
*/

SELECT c."customer_id" AS "id_cliente", 
       c."first_name" AS "nombre_cliente", 
       c."last_name" AS "apellido_cliente", 
       r."rental_id" AS "id_alquiler", 
       r."rental_date" AS "fecha_alquiler", 
       r."return_date" AS "fecha_devolucion"
FROM "customer" AS c
LEFT JOIN "rental" AS r ON c."customer_id" = r."customer_id"
ORDER BY c."customer_id", r."rental_date";

/* 44. Encuentra los actores que han participado en películas de la categoría 'Action'. */

SELECT DISTINCT a."first_name" AS "nombre_actor", 
                a."last_name" AS "apellido_actor"
FROM "actor" AS a
    JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
    JOIN "film" AS f ON fa."film_id" = f."film_id"
    JOIN "film_category" AS fc ON f."film_id" = fc."film_id"
    JOIN "category" AS c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Action'
ORDER BY a."last_name", a."first_name";

--#####RESPUESTA#####
/*No, esta consulta no aporta valor directamente en la mayoría de los casos 
 porque genera un producto cartesiano sin relación lógica entre las películas y las categorías.
 */
--###################

/* 45. Encuentra todos los actores que no han participado en películas. */

SELECT a."first_name" AS "nombre_actor", 
       a."last_name" AS "apellido_actor"
FROM "actor" AS a
    LEFT JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
WHERE fa."actor_id" IS NULL
ORDER BY a."last_name", a."first_name";

/* 46. Selecciona el nombre de los actores y la cantidad de películas en las que han participado. */

SELECT a."first_name" AS "nombre_actor", 
       a."last_name" AS "apellido_actor", 
       COUNT(fa."film_id") AS "cantidad_peliculas"
FROM "actor" AS a
    LEFT JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
GROUP BY a."actor_id", a."first_name", a."last_name"
ORDER BY "cantidad_peliculas" DESC, a."last_name", a."first_name";

/* 47. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores 
 * y el número de películas en las que han participado. */

CREATE VIEW "actor_num_peliculas" AS
SELECT a."first_name" AS "nombre_actor", 
       a."last_name" AS "apellido_actor", 
       COUNT(fa."film_id") AS "cantidad_peliculas"
FROM "actor" AS a
    LEFT JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
GROUP BY a."actor_id", a."first_name", a."last_name";

/* 48. Calcula el número total de alquileres realizados por cada cliente. */

SELECT c."customer_id" AS "id_cliente", 
       c."first_name" AS "nombre_cliente", 
       c."last_name" AS "apellido_cliente", 
       COUNT(r."rental_id") AS "total_alquileres"
FROM "customer" AS c
    JOIN "rental" AS r ON c."customer_id" = r."customer_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
ORDER BY "total_alquileres" DESC, c."last_name", c."first_name";

/* 49. Calcula la duración total de las películas en la categoría 'Action'. */

SELECT SUM(f."length") AS "duracion_total"
FROM "film" AS f
    JOIN "film_category" AS fc ON f."film_id" = fc."film_id"
    JOIN "category" AS c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Action';

/* 50. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente. */

CREATE TEMPORARY TABLE "cliente_rentas_temporal" (
    "id_cliente" INT,
    "nombre_cliente" VARCHAR(50),
    "apellido_cliente" VARCHAR(50),
    "total_alquileres" INT
);

INSERT INTO "cliente_rentas_temporal" ("id_cliente", "nombre_cliente", "apellido_cliente", "total_alquileres")
SELECT c."customer_id" AS "id_cliente", 
       c."first_name" AS "nombre_cliente", 
       c."last_name" AS "apellido_cliente", 
       COUNT(r."rental_id") AS "total_alquileres"
FROM "customer" AS c
    JOIN "rental" AS r ON c."customer_id" = r."customer_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
ORDER BY "total_alquileres" DESC;

SELECT * FROM "cliente_rentas_temporal";

/* 51. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces. */

CREATE TEMPORARY TABLE "peliculas_alquiladas" (
    "id_pelicula" INT,
    "titulo_pelicula" VARCHAR(255),
    "cantidad_alquileres" INT
);

INSERT INTO "peliculas_alquiladas" ("id_pelicula", "titulo_pelicula", "cantidad_alquileres")
SELECT f."film_id" AS "id_pelicula", 
       f."title" AS "titulo_pelicula", 
       COUNT(r."rental_id") AS "cantidad_alquileres"
FROM "film" AS f
    JOIN "inventory" AS i ON f."film_id" = i."film_id"
    JOIN "rental" AS r ON i."inventory_id" = r."inventory_id"
GROUP BY f."film_id", f."title"
HAVING COUNT(r."rental_id") >= 10
ORDER BY "cantidad_alquileres" DESC;

SELECT * FROM "peliculas_alquiladas";

/* 52. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ 
 * y que aún no se han devuelto. 
 * Ordena los resultados alfabéticamente por título de película. */

SELECT f."title" AS "titulo_pelicula"
FROM "customer" AS c
    JOIN "rental" AS r ON c."customer_id" = r."customer_id"
    JOIN "inventory" AS i ON r."inventory_id" = i."inventory_id"
    JOIN "film" AS f ON i."film_id" = f."film_id"
WHERE c."first_name" = 'TAMMY' 
  AND c."last_name" = 'SANDERS'
  AND r."return_date" IS NULL
ORDER BY f."title";

/* 53. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. 
 * Ordena los resultados alfabéticamente por apellido. */

SELECT DISTINCT a."first_name" AS "nombre_actor", 
                a."last_name" AS "apellido_actor"
FROM "actor" AS a
    JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
    JOIN "film" AS f ON fa."film_id" = f."film_id"
    JOIN "film_category" AS fc ON f."film_id" = fc."film_id"
    JOIN "category" AS c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Sci-Fi'
ORDER BY a."last_name", a."first_name";

/* 54. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron 
 * después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. 
 * Ordena los resultados alfabéticamente por apellido. */

SELECT DISTINCT a."first_name" AS "nombre_actor", 
                a."last_name" AS "apellido_actor"
FROM "actor" AS a
    JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
    JOIN "film" AS f ON fa."film_id" = f."film_id"
    JOIN "inventory" AS i ON f."film_id" = i."film_id"
    JOIN "rental" AS r ON i."inventory_id" = r."inventory_id"
WHERE r."rental_date" > (
    SELECT MIN(r2."rental_date")
    FROM "film" AS f2
        JOIN "inventory" AS i2 ON f2."film_id" = i2."film_id"
        JOIN "rental" AS r2 ON i2."inventory_id" = r2."inventory_id"
    WHERE f2."title" = 'SPARTACUS CHEAPER'
)
ORDER BY a."last_name", a."first_name";

/* 55. Encuentra el nombre y apellido de los actores que han actuado en películas 
 * que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. 
 * Ordena los resultados alfabéticamente por apellido. */

SELECT DISTINCT a."first_name" AS "nombre_actor", 
                a."last_name" AS "apellido_actor"
FROM "actor" AS a
    JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
    JOIN "film" AS f ON fa."film_id" = f."film_id"
    JOIN "inventory" AS i ON f."film_id" = i."film_id"
    JOIN "rental" AS r ON i."inventory_id" = r."inventory_id"
WHERE r."rental_date" > (
    SELECT MIN(r2."rental_date")
    FROM "film" AS f2
        JOIN "inventory" AS i2 ON f2."film_id" = i2."film_id"
        JOIN "rental" AS r2 ON i2."inventory_id" = r2."inventory_id"
    WHERE f2."title" = 'SPARTACUS CHEAPER'
)
ORDER BY a."last_name", a."first_name";

/* 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’. */

SELECT a."first_name" AS "nombre_actor", 
       a."last_name" AS "apellido_actor"
FROM "actor" AS a
WHERE a."actor_id" NOT IN (
    SELECT DISTINCT fa."actor_id"
    FROM "film_actor" AS fa
        JOIN "film" AS f ON fa."film_id" = f."film_id"
        JOIN "film_category" AS fc ON f."film_id" = fc."film_id"
        JOIN "category" AS c ON fc."category_id" = c."category_id"
    WHERE c."name" = 'Music'
)
ORDER BY a."last_name", a."first_name";

/* 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días. */

SELECT DISTINCT f."title" AS "titulo_pelicula"
FROM "rental" AS r
    JOIN "inventory" AS i ON r."inventory_id" = i."inventory_id"
    JOIN "film" AS f ON i."film_id" = f."film_id"
WHERE r."return_date" - r."rental_date" > INTERVAL '8 days'
ORDER BY f."title";

/* 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’. */

SELECT DISTINCT f."title" AS "titulo_pelicula"
FROM "film" AS f
    JOIN "film_category" AS fc ON f."film_id" = fc."film_id"
    JOIN "category" AS c ON fc."category_id" = c."category_id"
WHERE fc."category_id" IN (
    SELECT fc2."category_id"
    FROM "film_category" AS fc2
        JOIN "category" AS c2 ON fc2."category_id" = c2."category_id"
    WHERE c2."name" = 'Animation'
)
ORDER BY f."title";

/* 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. 
 * Ordena los resultados alfabéticamente por título de película. */

SELECT f."title" AS "titulo_pelicula"
FROM "film" AS f
WHERE f."length" = (
    SELECT f2."length"
    FROM "film" AS f2
    WHERE f2."title" = 'DANCING FEVER'
)
ORDER BY f."title";

/* 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. 
 * Ordena los resultados alfabéticamente por apellido. */

SELECT c."first_name" AS "nombre_cliente", 
       c."last_name" AS "apellido_cliente"
FROM "customer" AS c
    JOIN "rental" AS r ON c."customer_id" = r."customer_id"
    JOIN "inventory" AS i ON r."inventory_id" = i."inventory_id"
    JOIN "film" AS f ON i."film_id" = f."film_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
HAVING COUNT(DISTINCT f."film_id") >= 7
ORDER BY c."last_name", c."first_name";

/* 61. Encuentra la cantidad total de películas alquiladas por categoría 
 * y muestra el nombre de la categoría junto con el recuento de alquileres. */

SELECT c."name" AS "nombre_categoria", 
       COUNT(r."rental_id") AS "cantidad_alquileres"
FROM "category" AS c
    JOIN "film_category" AS fc ON c."category_id" = fc."category_id"
    JOIN "film" AS f ON fc."film_id" = f."film_id"
    JOIN "inventory" AS i ON f."film_id" = i."film_id"
    JOIN "rental" AS r ON i."inventory_id" = r."inventory_id"
GROUP BY c."name"
ORDER BY "cantidad_alquileres" DESC;

/* 62. Encuentra el número de películas por categoría estrenadas en 2006. */

SELECT c."name" AS "nombre_categoria", 
       COUNT(f."film_id") AS "numero_peliculas"
FROM "category" AS c
    JOIN "film_category" AS fc ON c."category_id" = fc."category_id"
    JOIN "film" AS f ON fc."film_id" = f."film_id"
WHERE f."release_year" = 2006
GROUP BY c."name"
ORDER BY "numero_peliculas" DESC;

/* 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos. */

SELECT s."staff_id" AS "id_trabajador", 
       s."first_name" AS "nombre_trabajador", 
       s."last_name" AS "apellido_trabajador", 
       st."store_id" AS "id_tienda"
FROM "staff" AS s
    CROSS JOIN "store" AS st
ORDER BY s."staff_id", st."store_id";

/* 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, 
 * su nombre y apellido junto con la cantidad de películas alquiladas. */

SELECT c."customer_id" AS "id_cliente", 
       c."first_name" AS "nombre_cliente", 
       c."last_name" AS "apellido_cliente", 
       COUNT(r."rental_id") AS "cantidad_peliculas_alquiladas"
FROM "customer" AS c
    JOIN "rental" AS r ON c."customer_id" = r."customer_id"
    JOIN "inventory" AS i ON r."inventory_id" = i."inventory_id"
    JOIN "film" AS f ON i."film_id" = f."film_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
ORDER BY "cantidad_peliculas_alquiladas" DESC, c."last_name", c."first_name";











