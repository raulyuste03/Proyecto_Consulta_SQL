# Proyecto_Consulta_SQL
Segundo Proyecto del curso de Data Analytics en ThePower. Relacionado con la consultas sql desde una base de datos externa.
Este proyecto contiene diversas consultas SQL que resuelven problemas prácticos relacionados con una base de datos de películas, clientes, alquileres y trabajadores. Las consultas están organizadas por su propósito y funcionalidad, cubriendo operaciones comunes como agrupaciones, combinaciones, filtros, y cálculos avanzados.

**Tabla de Contenidos:**
Descripción del Proyecto
    Consultas Realizadas
    Películas y Categorías
    Clientes y Alquileres
    Trabajadores y Tiendas
Consultas Avanzadas
Ejecución
Notas Adicionales

**Descripción del Proyecto**
Este proyecto aborda diversas problemáticas de una base de datos relacional típica, incluyendo relaciones entre películas, categorías, clientes, trabajadores y registros de alquiler. Las consultas SQL utilizadas están diseñadas para extraer información relevante y responder a preguntas específicas sobre los datos.

****Consultas Realizadas****
  **Películas y Categorías**
      Películas por Categoría: Encontramos cuántas películas hay en cada categoría.
      Películas de la Categoría 'Sci-Fi': Identificamos actores que actuaron en películas de la categoría 'Sci-Fi'.
      Películas por Duración: Listamos películas con la misma duración que 'Dancing Fever'.
      Películas Estrenadas en 2006: Calculamos el número de películas por categoría estrenadas en 2006.
  **Clientes y Alquileres**
      Clientes y Total de Alquileres: Calculamos la cantidad total de películas alquiladas por cada cliente.
      Clientes con Más de 7 Películas: Identificamos clientes que han alquilado al menos 7 películas distintas.
      Alquileres por Categoría: Calculamos el total de alquileres realizados por categoría.
  **Trabajadores y Tiendas**
      Combinaciones de Trabajadores y Tiendas: Generamos todas las combinaciones posibles de trabajadores con tiendas mediante un CROSS JOIN.
  **Consultas Avanzadas**
      Películas Alquiladas por más de 8 Días: Filtramos películas alquiladas durante más de 8 días.
      Actores por Categorías Excluyentes: Identificamos actores que no han actuado en películas de la categoría 'Music'.
      Vista para Alquileres por Cliente: Creamos una vista para listar clientes y la cantidad de películas que han alquilado.
      
****Ejecución****
  **Pre-requisitos:**
    Un servidor de base de datos compatible (e.g., PostgreSQL, MySQL).
    Acceso a la base de datos que contiene las tablas mencionadas (film, customer, rental, etc.).
  **Pasos para ejecutar las consultas:**
    Carga la base de datos con los datos iniciales.
    Copia y ejecuta las consultas SQL proporcionadas en tu cliente de base de datos.
    Analiza los resultados obtenidos.
    
****Notas Adicionales****
      Las consultas están optimizadas para bases de datos relacionales con esquemas similares al de un sistema de gestión de películas y alquileres.
      Utilizamos operaciones como JOIN, GROUP BY, HAVING, y subconsultas para obtener información avanzada.
      Para tablas temporales y vistas, asegúrate de que tu servidor de base de datos soporta estas funcionalidades.
      
****Créditos****
      Este proyecto fue desarrollado como parte de una práctica interactiva para resolver problemas SQL y demostrar el uso de consultas avanzadas.
