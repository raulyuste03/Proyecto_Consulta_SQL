/*  2. Muestra los nombres de todas las películas con una clasificación por
edades de ‘R.
*/

select title , rating 
from film f
where rating = 'R';

/* 3. Encuentra los nombres de los actores que tengan un “actor_id entre 30
y 40.
*/

select actor_id , concat(first_name,' ', last_name) as Nombre_Completo 
from actor a 
where actor_id between 30 and 40;

/* 4. Obtén las películas cuyo idioma coincide con el idioma original.
*/

select *
from film
where original_language_id = language_id ;

-- El resultado no da coincidencias debido a que la BBDD solo aporta el valor 1 para language_id y valor null para orginal_language_id.

/* 5. dena las películas por duración de forma ascendente.
 */

select *
from film f 
order by length asc ;

/* 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen en su
apellido.
*/

select concat(first_name, ' ', last_name) as Nombre_Completo 
from actor a 
where last_name = 'ALLEN';

/* 7. Encuentra la cantidad total de películas en cada clasificación de la tabla
“film y muestra la clasificación junto con el recuento. 
*/

select rating, COUNT(*) AS total_peliculas
from film
group by rating;

/* 8. Encuentra el título de todas las películas que son PG-13 o tienen una
duración mayor a 3 horas en la tabla film */

select title , rating , length 
from film f 
where rating = 'PG-13' or length > 180;

/* 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
 */

select 
    var_pop(replacement_cost) as varianza_replacement_cost,
    stddev_pop(replacement_cost) as desviacion_estandar_replacement_cost
from film;

/* 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
 */

select max(length) as Mayor_duracion, min(length) as Menor_Duracion 
from film f ;

/* 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
*/

select amount 
from payment p
order by payment_date desc 
limit 1 offset 2;

/* 12. Encuentra el título de las películas en la tabla “film que no sean ni ‘NC-17' ni ‘G' en cuanto a su clasificación.
*/

select title , rating 
from film f 
where rating not in ('G', 'NC-17');

/* 13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.
*/

select round(avg(length), 2) as Promedio_Duracion, rating 
from film f
group by rating ;

/* 14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos.
*/

select title , length 
from film f 
where length > 180;

/* 15. ¿Cuánto dinero ha generado en total la empresa?
 */

select sum(amount) as Ingresos_Totales
from payment p ;

/* 16. Muestra los 10 clientes con mayor valor de id.
*/

select customer_id 
from customer c 
order by customer_id desc 
limit 10;

/* 17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby'
*/

select concat(a.first_name, ' ' , a.last_name) as Nombre_Completo
from actor a 
	join film_actor fa ON a.actor_id = fa.actor_id
	join film f on fa.film_id = f.film_id 
where f.title = 'EGG IGBY';

/* 18. Selecciona todos los nombres de las películas únicos 
 */

select distinct title 
from film f ;

/* 19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film.
*/

select f.title 
from film f 
	join film_category fc on f.film_id = fc.film_id 
	join category c on fc.category_id = c.category_id 
where c."name" = 'Comedy' and f.length > 180;

/* 20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.
*/

select c."name" ,avg(f.length) as Duracion_Promedio
from film f 
	join film_category fc on f.film_id = fc.film_id 
	join category c on fc.category_id = c.category_id
group by c."name"
having avg(f.length) > 110
order by avg(f.length) desc ; 

/* 21. ¿Cuál es la media de duración del alquiler de las películas?
*/

select avg(rental_duration) as Duracion_Alquiler 
from film f ;

/* 22. Crea una columna con el nombre y apellidos de todos los actores y
actrices.
*/

select concat(first_name, ' ', last_name) as Nombre_Completo_Actores 
from actor a ;

/* 23. Numeros de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.
*/

select DATE(rental_date) as Dia_Alquiler, count(*) as Cantidad_Alquiler 
from rental r 
group by DATE(rental_date)
order by Cantidad_Alquiler desc ;

/* 24. Encuentra las películas con una duración superior al promedio.
*/

select title , length 
from film f 
where length > (select avg(length) from film f2) ;

/* 25. Averigua el número de alquileres registrados por mes.
*/

SELECT EXTRACT(MONTH FROM rental_date) AS mes, COUNT(*) AS cantidad_alquileres
FROM rental
GROUP BY EXTRACT(MONTH FROM rental_date)
ORDER BY mes;

/* 26. Encuentra el promedio, la desviación estándar y varianza del total
pagado.
*/

select avg(amount) as Promedio, stddev(amount) as Desvianza, variance(amount) as Varianza  
from payment p ;

/* 27. ¿Qué películas se alquilan por encima del precio medio?
*/

select title , rental_rate 
from film f 
where rental_rate > (select avg(rental_rate) from film f2);

/* 28. Muestra el id de los actores que hayan participado en más de 40
películas. */

select actor_id , count(film_id) as Cantidad_Peliculas 
from film_actor fa 
group by actor_id 
having count(film_id) > 40; 

/* 29. Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible.
*/

SELECT f.title, COUNT(i.inventory_id) AS cantidad_disponible
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
GROUP BY f.title
ORDER BY cantidad_disponible DESC;

/* 30. Obtener los actores y el número de películas en las que ha actuado.
 */

select a.first_name, a.last_name, COUNT(fa.film_id) as cantidad_peliculas
from actor a
	join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by cantidad_peliculas desc ;

/* 31. Obtener todas las películas y mostrar los actores que han actuado en 
ellas, incluso si algunas películas no tienen actores asociados.
*/

select f.title as titulo_pelicula, 
       a.first_name as nombre_actor, 
       a.last_name as apellido_actor
from film f
	left join film_actor fa on f.film_id = fa.film_id
	left join actor a on fa.actor_id = a.actor_id
order by f.title, a.last_name, a.first_name;

/* 32. Obtener todos los actores y mostrar las películas en las que han 
actuado, incluso si algunos actores no han actuado en ninguna película.
*/

select a.first_name as nombre_actor, 
       a.last_name as apellido_actor, 
       f.title as titulo_pelicula
from actor a
	left join film_actor fa on a.actor_id = fa.actor_id
	left join film f on fa.film_id = f.film_id
order by a.last_name, a.first_name, f.title;

/* 33. Obtener todas las películas que tenemos y todos los registros de
alquiler.
*/

select f.title as titulo_pelicula, 
       r.rental_date as fecha_alquiler, 
       r.return_date as fecha_devolucion, 
       r.customer_id as id_cliente
from film f
	left join inventory i on f.film_id = i.film_id
	left join rental r on i.inventory_id = r.inventory_id
order by f.title, r.rental_date;

/* 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
 */

select 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(p.amount) as total_gastado
from customer c
	join payment p on c.customer_id = p.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_gastado desc 
limit 5;

/* 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
 */

select first_name , last_name 
from actor a 
where first_name = 'JOHNNY';

/* 36. Renombra la columna “first_name como Nombre y “last_name como
Apellido.
*/

select first_name as Nombre, last_name as Apellido
from actor a ;

/* 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
 */

select max(actor_id), min(actor_id) 
from actor a ;

/* 38. Cuenta cuántos actores hay en la tabla “actor".
 */

select count(*) 
from actor a ;

/* 39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente.
*/

select first_name as Nombre , last_name as Apellido
from actor a 
order by Apellido asc ;

/* 40. Selecciona las primeras 5 películas de la tabla “film".
 */

select *
from film f 
limit 5;

/* 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?
*/

select first_name as Nombre, count(*) as Cantidad 
from actor a 
group by Nombre
order by Cantidad desc 
limit 1;

/* 42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.
*/

select r.rental_id as id_alquiler, 
       r.rental_date as fecha_alquiler, 
       r.return_date as fecha_devolucion, 
       c.first_name as nombre_cliente, 
       c.last_name as apellido_cliente
from rental r
	join customer c on r.customer_id = c.customer_id
order by r.rental_date;

/* 43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.
*/

select c.customer_id as id_cliente, 
       c.first_name as nombre_cliente, 
       c.last_name as apellido_cliente, 
       r.rental_id as id_alquiler, 
       r.rental_date as fecha_alquiler, 
       r.return_date as fecha_devolucion
from customer c
	left join rental r on c.customer_id = r.customer_id
order by c.customer_id, r.rental_date;

/* 44. uentra los actores que han participado en películas de la categoría
'Action'.

 */

select f.title as titulo_pelicula, 
       c.name as nombre_categoria
from film f
	cross join category c;

--#####RESPUESTA#####
/*No, esta consulta no aporta valor directamente en la mayoría de los casos 
 porque genera un producto cartesiano sin relación lógica entre las películas y las categorías.
 */
--###################

/* 45. Encuentra los actores que han participado en películas de la categoría
'Action'.
*/

select distinct a.first_name as nombre_actor, 
                a.last_name as apellido_actor
from actor a
    join film_actor fa on a.actor_id = fa.actor_id
    join film f on fa.film_id = f.film_id
    join film_category fc on f.film_id = fc.film_id
    join category c on fc.category_id = c.category_id
where c.name = 'Action'
order by a.last_name, a.first_name;

/* 46. Encuentra todos los actores que no han participado en películas.
 */

select a.first_name as nombre_actor, 
       a.last_name as apellido_actor
from actor a
    left join film_actor fa on a.actor_id = fa.actor_id
where fa.actor_id is null
order by a.last_name, a.first_name;

/* 47. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.
*/

select a.first_name as nombre_actor, 
       a.last_name as apellido_actor, 
       count(fa.film_id) as cantidad_peliculas
from actor a
    left join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by cantidad_peliculas desc, a.last_name, a.first_name;

/* 48. Crea una vista llamada “actor_num_peliculas que muestre los nombres
de los actores y el número de películas en las que han participado.
*/

create view actor_num_peliculas as
select a.first_name as nombre_actor, 
       a.last_name as apellido_actor, 
       count(fa.film_id) as cantidad_peliculas
from actor a
    left join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name;

/* 49. Calcula el número total de alquileres realizados por cada cliente
 */

select c.customer_id as id_cliente, 
       c.first_name as nombre_cliente, 
       c.last_name as apellido_cliente, 
       count(r.rental_id) as total_alquileres
from customer c
    join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_alquileres desc, c.last_name, c.first_name;

/* 50. Calcula la duración total de las películas en la categoría 'Action'.
 */

select sum(f.length) as duracion_total
from film f
    join film_category fc on f.film_id = fc.film_id
    join category c on fc.category_id = c.category_id
where c.name = 'Action';

/* 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente.
*/

create temporary table cliente_rentas_temporal (
    id_cliente int,
    nombre_cliente varchar(50),
    apellido_cliente varchar(50),
    total_alquileres int
);

insert into cliente_rentas_temporal (id_cliente, nombre_cliente, apellido_cliente, total_alquileres)
select c.customer_id as id_cliente, 
       c.first_name as nombre_cliente, 
       c.last_name as apellido_cliente, 
       count(r.rental_id) as total_alquileres
from customer c
    join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_alquileres desc;

select * from cliente_rentas_temporal;

/* 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces.*/

create temporary table peliculas_alquiladas (
    id_pelicula int,
    titulo_pelicula varchar(255),
    cantidad_alquileres int
);

insert into peliculas_alquiladas (id_pelicula, titulo_pelicula, cantidad_alquileres)
select f.film_id as id_pelicula, 
       f.title as titulo_pelicula, 
       count(r.rental_id) as cantidad_alquileres
from film f
    join inventory i on f.film_id = i.film_id
    join rental r on i.inventory_id = r.inventory_id
group by f.film_id, f.title
having count(r.rental_id) >= 10
order by cantidad_alquileres desc;

select * from peliculas_alquiladas;

/* 53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.
*/

select f.title as titulo_pelicula
from customer c
    join rental r on c.customer_id = r.customer_id
    join inventory i on r.inventory_id = i.inventory_id
    join film f on i.film_id = f.film_id
where c.first_name = 'TAMMY' 
  and c.last_name = 'SANDERS'
  and r.return_date is null
order by f.title;

/* 54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.
*/

select distinct a.first_name as nombre_actor, 
                a.last_name as apellido_actor
from actor a
    join film_actor fa on a.actor_id = fa.actor_id
    join film f on fa.film_id = f.film_id
    join film_category fc on f.film_id = fc.film_id
    join category c on fc.category_id = c.category_id
where c.name = 'Sci-Fi'
order by a.last_name, a.first_name;

/* 55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.
*/

select distinct a.first_name as nombre_actor, 
                a.last_name as apellido_actor
from actor a
    join film_actor fa on a.actor_id = fa.actor_id
    join film f on fa.film_id = f.film_id
    join inventory i on f.film_id = i.film_id
    join rental r on i.inventory_id = r.inventory_id
where r.rental_date > (
    select min(r2.rental_date)
    from film f2
        join inventory i2 on f2.film_id = i2.film_id
        join rental r2 on i2.inventory_id = r2.inventory_id
    where f2.title = 'SPARTACUS CHEAPER'
)
order by a.last_name, a.first_name;

/* 56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’.
*/

select a.first_name as nombre_actor, 
       a.last_name as apellido_actor
from actor a
where a.actor_id not in (
    select distinct fa.actor_id
    from film_actor fa
        join film f on fa.film_id = f.film_id
        join film_category fc on f.film_id = fc.film_id
        join category c on fc.category_id = c.category_id
    where c.name = 'Music'
)
order by a.last_name, a.first_name;

/* 57.Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.
*/

select distinct f.title as titulo_pelicula
from rental r
    join inventory i on r.inventory_id = i.inventory_id
    join film f on i.film_id = f.film_id
where r.return_date - r.rental_date > interval '8 days'
order by f.title;

/* 58. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation’.
*/

select distinct f.title as titulo_pelicula
from film f
    join film_category fc on f.film_id = fc.film_id
    join category c on fc.category_id = c.category_id
where fc.category_id in (
    select fc2.category_id
    from film_category fc2
        join category c2 on fc2.category_id = c2.category_id
    where c2.name = 'Animation'
)
order by f.title;

/* 59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.
*/

select f.title as titulo_pelicula
from film f
where f.length = (
    select f2.length
    from film f2
    where f2.title = 'DANCING FEVER'
)
order by f.title;

/* 60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.
*/

select c.first_name as nombre_cliente, 
       c.last_name as apellido_cliente
from customer c
    join rental r on c.customer_id = r.customer_id
    join inventory i on r.inventory_id = i.inventory_id
    join film f on i.film_id = f.film_id
group by c.customer_id, c.first_name, c.last_name
having count(distinct f.film_id) >= 7
order by c.last_name, c.first_name;

/* 61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.
*/

select c.name as nombre_categoria, 
       count(r.rental_id) as cantidad_alquileres
from category c
    join film_category fc on c.category_id = fc.category_id
    join film f on fc.film_id = f.film_id
    join inventory i on f.film_id = i.film_id
    join rental r on i.inventory_id = r.inventory_id
group by c.name
order by cantidad_alquileres desc;

/* 62. Encuentra el número de películas por categoría estrenadas en 2006.
*/

select c.name as nombre_categoria, 
       count(f.film_id) as numero_peliculas
from category c
    join film_category fc on c.category_id = fc.category_id
    join film f on fc.film_id = f.film_id
where f.release_year = 2006
group by c.name
order by numero_peliculas desc;


/* 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.
*/

select s.staff_id as id_trabajador, 
       s.first_name as nombre_trabajador, 
       s.last_name as apellido_trabajador, 
       st.store_id as id_tienda
from staff s
    cross join store st
order by s.staff_id, st.store_id;

/* 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.
 */

select c.customer_id as id_cliente, 
       c.first_name as nombre_cliente, 
       c.last_name as apellido_cliente, 
       count(r.rental_id) as cantidad_peliculas_alquiladas
from customer c
    join rental r on c.customer_id = r.customer_id
    join inventory i on r.inventory_id = i.inventory_id
    join film f on i.film_id = f.film_id
group by c.customer_id, c.first_name, c.last_name
order by cantidad_peliculas_alquiladas desc, c.last_name, c.first_name;











